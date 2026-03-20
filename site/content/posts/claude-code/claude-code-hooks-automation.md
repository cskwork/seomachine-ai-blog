---
title: "Claude Code Hooks와 자동화 파이프라인: 개발 워크플로우 자동화"
date: 2026-03-11
draft: false
tags: ["Claude Code", "Hooks", "자동화", "CI/CD", "워크플로우"]
categories: ["Claude Code"]
description: "Claude Code Hooks로 개발 워크플로우를 자동화하는 방법. PreToolUse, PostToolUse Hook 설정법과 CI/CD 연동 예제를 포함합니다."
summary: "Hooks와 비대화형 모드를 활용하여 Claude Code를 개발 파이프라인에 통합하는 고급 자동화 기법을 다룹니다."
difficulty: "고급"
ShowToc: true
TocOpen: true
---

Claude Code를 처음 사용할 때는 대화형으로 코드를 수정하고 검토받는 것에 집중하게 된다. 그런데 팀 환경에서 사용하거나 반복적인 작업이 많아지면, 매번 Claude에게 "포맷해줘", "린트 돌려줘", "이 명령 괜찮아?" 같은 말을 붙여야 하는 것이 번거로워진다. Hooks는 이 반복을 없애준다.

## Hooks란

Claude Code Hooks는 Claude가 도구를 실행하기 전후에 자동으로 실행되는 셸 명령이다. IDE의 저장 시 자동 포맷(save-on-format)이나 Git의 pre-commit hook과 개념적으로 동일하다. 차이가 있다면, Claude의 모든 도구 호출을 가로채거나 후처리할 수 있다는 점이다.

`settings.json`에 정의하며, Claude가 파일을 수정하거나 Bash 명령을 실행할 때마다 지정한 스크립트가 함께 동작한다. Claude의 행동을 자동으로 보완하고 검증하는 메커니즘이라고 보면 된다.

Hook이 없을 때의 전형적인 시나리오를 생각해보자. Claude가 TypeScript 파일을 수정한다. 개발자가 "prettier 돌려줘"라고 요청한다. Claude가 prettier를 실행한다. 이 세 단계가 Hook 하나로 줄어든다. Claude가 파일을 수정하는 순간 prettier가 자동으로 실행된다.

## Hook 유형 3가지

### PreToolUse: 도구 실행 전

Claude가 도구를 호출하기 직전에 실행된다. 반환 값에 따라 해당 도구의 실행을 허용하거나 차단할 수 있다. 주로 위험한 작업을 사전에 막거나 파라미터를 검증하는 용도로 쓴다.

PreToolUse는 Claude의 자율성에 명시적인 경계를 그을 수 있는 가장 직접적인 방법이다. "이런 종류의 명령은 절대 실행하지 마라"는 규칙을 코드로 명문화한 것이다.

### PostToolUse: 도구 실행 후

도구가 성공적으로 실행된 직후에 실행된다. 세 가지 Hook 유형 중 가장 자주 활용된다. 파일 수정 후 자동 포맷팅, 코드 변경 후 린트 실행, Bash 명령 실행 후 감사 로그 기록 등 다양하게 응용할 수 있다.

PostToolUse는 "Claude가 무언가를 했다면, 항상 이것도 함께 해라"는 패턴을 구현한다.

### Stop: 세션 종료 시

Claude가 응답을 완료하기 직전에 실행된다. 최종 검증이나 보고서 생성에 적합하다. 세션 동안 변경된 파일 목록을 로깅하거나, 변경 사항 요약을 슬랙으로 전송하거나, 최종 테스트를 한 번 더 실행하는 용도로 사용한다.

## settings.json에서 Hook 설정하기

### 기본 구조

Hook은 `~/.claude/settings.json`(전역) 또는 프로젝트 루트의 `.claude/settings.json`(프로젝트별)에 정의한다.

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "command": "prettier --write $CLAUDE_FILE_PATH"
      }
    ]
  }
}
```

`matcher`는 어떤 도구에 반응할지 정규식으로 지정한다. `command`는 실행할 셸 명령이다. 환경 변수 `$CLAUDE_FILE_PATH`와 `$CLAUDE_TOOL_INPUT` 등이 자동으로 주입된다.

### 실전 예제 1: 파일 저장 후 자동 포맷

가장 기본적이면서 효과가 큰 Hook이다. Write 또는 Edit 도구가 실행될 때마다 prettier를 자동으로 실행한다.

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "command": "npx prettier --write \"$CLAUDE_FILE_PATH\" 2>/dev/null || true"
      }
    ]
  }
}
```

`2>/dev/null || true` 부분이 중요하다. prettier가 지원하지 않는 파일 형식(예: `.env`, 바이너리 파일)에서 오류가 발생해도 Hook이 전체 작업을 중단시키지 않도록 한다. 비치명적인 Hook은 항상 실패를 흡수하는 설계가 필요하다.

### 실전 예제 2: Bash 명령 실행 후 감사 로그

Claude가 실행한 Bash 명령을 타임스탬프와 함께 로그 파일에 기록한다. 팀 환경이나 프로덕션 접근 권한이 있는 환경에서 감사 추적(audit trail)을 유지하는 데 유용하다.

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Bash",
        "command": "echo \"$(date '+%Y-%m-%d %H:%M:%S'): $CLAUDE_TOOL_INPUT\" >> ~/.claude/audit.log"
      }
    ]
  }
}
```

이 로그를 주기적으로 검토하거나 SIEM 시스템으로 전송하면 Claude의 모든 Bash 실행 이력을 추적할 수 있다.

### 실전 예제 3: 위험한 명령 차단

PreToolUse를 활용해 파괴적인 명령을 사전에 차단한다. `rm -rf`, `DROP TABLE`, 강제 푸시 등의 패턴이 감지되면 Claude의 도구 실행 자체를 막는다.

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "command": "echo \"$CLAUDE_TOOL_INPUT\" | grep -qE '(rm -rf|drop table|DROP TABLE|push --force)' && echo 'BLOCKED: 위험한 명령 감지됨' && exit 1 || exit 0"
      }
    ]
  }
}
```

`exit 1`을 반환하면 Claude Code는 해당 도구 실행을 차단하고, 이유를 표준 출력으로 Claude에게 전달한다. Claude는 이 피드백을 받아 대안을 제시하게 된다.

여러 Hook을 배열로 나열하면 순서대로 모두 실행된다. 포맷 Hook과 린트 Hook을 함께 등록하면 파일 수정 시 포맷 후 린트까지 자동으로 처리된다.

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "command": "npx prettier --write \"$CLAUDE_FILE_PATH\" 2>/dev/null || true"
      },
      {
        "matcher": "Write|Edit",
        "command": "npx eslint --fix \"$CLAUDE_FILE_PATH\" 2>/dev/null || true"
      }
    ]
  }
}
```

## 비대화형 모드: CI/CD 연동

Hook이 로컬 개발 환경에서 Claude의 행동을 자동화한다면, 비대화형 모드는 CI/CD 파이프라인에서 Claude를 하나의 도구로 통합하는 방법이다.

### claude -p 명령

`-p` 플래그(또는 `--print`)를 사용하면 프롬프트를 직접 전달하고 한 번의 응답으로 완료된다. 대화 세션을 열지 않으므로 스크립트와 자동화 환경에 적합하다.

```bash
# 단일 파일 리뷰
claude -p "src/auth/login.ts를 보안 관점에서 리뷰해줘"

# JSON 출력으로 파싱 가능
claude -p "변경된 파일 목록을 JSON으로 요약해줘" --output-format json
```

### GitHub Actions PR 자동 리뷰 예제

PR이 열릴 때마다 Claude가 변경 사항을 분석하고 리뷰를 남기는 워크플로우다.

```yaml
name: Claude Code Review
on:
  pull_request:
    types: [opened, synchronize]

jobs:
  review:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'

      - name: Claude Review
        run: |
          npx @anthropic-ai/claude-code -p \
            "git diff origin/main...HEAD를 분석하고
             보안 취약점, 버그 가능성, 성능 이슈를 한국어로 리뷰해줘.
             각 항목을 심각도(HIGH/MEDIUM/LOW)와 함께 표시해줘." \
            --output-format json > review.json
          cat review.json
        env:
          ANTHROPIC_API_KEY: ${{ secrets.ANTHROPIC_API_KEY }}

      - name: Post Review Comment
        uses: actions/github-script@v7
        with:
          script: |
            const fs = require('fs');
            const review = JSON.parse(fs.readFileSync('review.json', 'utf8'));
            github.rest.issues.createComment({
              issue_number: context.issue.number,
              owner: context.repo.owner,
              repo: context.repo.repo,
              body: review.result
            });
```

이 접근의 핵심은 Claude를 블랙박스 도구로 취급하지 않는 것이다. `--output-format json`으로 구조화된 출력을 받아 다음 단계에서 파싱하고 활용할 수 있다.

## 실무 인사이트: 자동화 설계 원칙

Hook과 비대화형 모드를 도입하면서 마주치는 공통적인 실수들이 있다. 경험을 통해 정리한 설계 원칙이다.

### 원칙 1: Hook은 가볍게 유지하라

Hook은 Claude의 모든 도구 호출마다 실행된다. Write를 10번 하면 PostToolUse Hook도 10번 실행된다. 무거운 빌드나 전체 테스트 스위트를 Hook에 넣으면 개발 흐름이 극도로 느려진다.

경험적으로 2초 이내에 완료되는 작업만 Hook에 넣는다. 포맷팅, 린트, 짧은 유효성 검사는 적합하다. 전체 빌드, 통합 테스트, Docker 이미지 빌드는 적합하지 않다.

### 원칙 2: 실패 처리를 명시적으로 설계하라

Hook의 실패는 두 가지로 나뉜다. 무시해도 되는 실패(prettier가 JSON 파일을 못 읽는 경우)와 반드시 차단해야 하는 실패(보안 검사에서 위험 패턴이 감지된 경우)다.

비치명적 Hook은 `|| true`로 실패를 흡수하고, 치명적 Hook은 `exit 1`로 명시적으로 중단시킨다. 이 둘을 섞으면 예측하기 어려운 동작이 발생한다.

### 원칙 3: 점진적으로 도입하라

처음부터 10개의 Hook을 설정하면 디버깅이 어렵다. 어떤 Hook이 문제를 일으키는지 추적하기 어렵고, 팀원들도 갑작스러운 변화에 적응하기 어렵다.

포맷터 Hook 하나를 먼저 도입하고 일주일 동안 안정성을 확인한다. 문제가 없으면 린터 Hook을 추가한다. 그 다음 감사 로그, 보안 검사 순으로 단계적으로 도입한다. 각 단계에서 팀의 피드백을 받아 조정한다.

팀에 공유하기 전에 개인 환경에서 충분히 테스트하는 것도 중요하다. Hook 설정 파일을 버전 관리에 포함해 변경 이력을 추적하면 문제 발생 시 롤백이 쉽다.

---

Claude Code는 단순한 AI 어시스턴트를 넘어 개발 파이프라인의 한 구성 요소로 통합될 수 있다. Hooks는 그 통합의 핵심 메커니즘이다. 처음에는 포맷팅 자동화 정도로 시작하더라도, 팀의 필요에 따라 점점 정교한 자동화로 발전시켜 나갈 수 있다.

## 관련 글

- [Claude Code 커스텀 커맨드](/posts/claude-code/claude-code-custom-commands/)
- [Claude Code 멀티 에이전트](/posts/claude-code/claude-code-multi-agent/)
