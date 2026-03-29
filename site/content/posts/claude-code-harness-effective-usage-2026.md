---
title: "Claude Code Harness 완전 정복: 설정부터 멀티 에이전트까지, 생산성 10배 높이는 실전 가이드 (2026)"
date: 2026-03-29
draft: false
tags: ["Claude Code", "Harness", "settings.json", "Hooks", "MCP", "CLAUDE.md", "멀티 에이전트", "커스텀 커맨드", "DevOps", "AI 코딩"]
categories: ["실전 가이드"]
description: "2026년 3월 기준, Claude Code harness를 제대로 구성하면 생산성이 10배 달라집니다. settings.json, 훅, CLAUDE.md, MCP 서버, 멀티 에이전트 오케스트레이션까지 10개 에이전트 병렬 리서치 결과를 총정리합니다."
summary: "Claude Code 350K+ 일일 사용자 중 상위 1%는 harness 구성이 다릅니다. 10개 리서치 에이전트로 공식 문서, GitHub, 커뮤니티를 전수 조사한 결과를 바탕으로, 설정 파일 하나하나를 실전 예제와 함께 해부합니다."
ShowToc: true
TocOpen: true
seo:
  primary_keyword: "Claude Code harness"
  secondary_keywords: ["Claude Code settings.json", "Claude Code hooks", "Claude Code MCP", "Claude Code CLAUDE.md", "Claude Code 멀티 에이전트", "Claude Code 설정", "AI 코딩 도구 2026"]
  word_count: 0
  quality_score: 0
  last_optimized: null
  review_required: false
---

"Claude Code를 쓰는데 왜 남들보다 느리죠?"

대부분의 사용자가 Claude Code를 **기본 설정 그대로** 씁니다. 그런데 350,000명 이상의 일일 사용자 중 상위 1%는 완전히 다른 경험을 하고 있습니다. 차이는 코딩 실력이 아니라 **harness 구성**에 있습니다.

Harness란 settings.json, 훅, CLAUDE.md, MCP 서버, 커스텀 커맨드를 하나의 시스템으로 엮은 것입니다. 잘 구성된 harness는 Claude가 여러분의 코드베이스, 규칙, 워크플로우를 **기억하고 자동화**하게 만듭니다. 이 글에서는 10개 리서치 에이전트를 병렬로 돌려 수집한 최신 자료를 바탕으로, harness의 각 구성 요소를 실전 예제와 함께 해부합니다.

## 2026년 3월, Claude Code는 지금 어디에 있나

본격적인 설정에 들어가기 전에 현재 상황을 짚겠습니다.

| 지표 | 수치 |
|------|------|
| GitHub Stars | 81,600+ |
| 일일 사용자 | 350,000+ |
| 수락된 PR | 1,000,000+ |
| SWE-bench (Opus 4.6) | 80.8% |
| 컨텍스트 윈도우 | 1M 토큰 |

**2026년 주요 업데이트:**

- **Auto Mode** (3월 24일) -- 수동 승인과 `--dangerously-skip-permissions` 사이의 중간 지점. AI 안전 레이어 2개가 안전한 액션은 자동 승인, 위험한 액션은 차단합니다
- **Computer Use** (3월 23일) -- Claude Code가 화면을 직접 클릭하고 조작합니다 (Pro/Max 전용)
- **Channels** (3월 20일) -- Telegram, Discord, iMessage에서 Claude Code를 제어합니다
- **Claude Opus 4.6** (2월 5일) -- SWE-bench 80.8%, Terminal-Bench 2.0 최고 점수
- **Xcode 26.3** (2월 26일) -- Apple이 Claude Agent SDK를 네이티브 통합
- **Claude for Open Source** (2월 26일) -- OSS 메인테이너에게 6개월 무료 Max ($1,200 가치)

## 1. settings.json: Harness의 기초

settings.json은 harness의 토대입니다. Claude Code의 모든 행동 규칙이 여기서 시작됩니다.

### 설정 우선순위 이해하기

Claude Code는 5단계 설정 계층을 따릅니다. **deny는 어느 레벨에서든 항상 이깁니다.**

```
Managed Policy (조직 관리자)
  └→ CLI Arguments (실행 시 플래그)
    └→ Local (~/.claude/settings.json)
      └→ Project (.claude/settings.json)
        └→ User (기본값)
```

### 모델 라우팅으로 비용 절감

가장 영향력 큰 설정은 모델 라우팅입니다.

```json
{
  "model": "opusplan",
  "preferences": {
    "effortLevel": "high"
  }
}
```

**`opusplan`은 숨겨진 보석입니다.** 계획(Plan) 단계에서는 Opus를 사용하고, 실행 단계에서는 자동으로 Sonnet으로 전환합니다. 추론 품질은 유지하면서 비용을 대폭 절감합니다.

| 모델 | 용도 | 비용 |
|------|------|------|
| Opus 4.6 | 복잡한 아키텍처 결정, 심층 추론 | 높음 |
| Sonnet 4.6 | 메인 개발 작업, 코드 생성 | 중간 |
| Haiku 4.5 | 서브에이전트, 경량 작업 | 낮음 (Sonnet의 1/3) |

서브에이전트 비용을 줄이려면 환경변수로 라우팅합니다:

```bash
export CLAUDE_CODE_SUBAGENT_MODEL="haiku"
```

### 권한 모드 설정

6가지 권한 모드가 있습니다. 솔로 개발에는 `acceptEdits`가 최적의 균형점입니다.

```json
{
  "permissions": {
    "mode": "acceptEdits",
    "allow": [
      "Bash(npm test*)",
      "Bash(git status*)",
      "Bash(git diff*)",
      "Read",
      "Glob",
      "Grep"
    ],
    "deny": [
      "Bash(rm -rf*)",
      "Bash(git push --force*)",
      "Bash(curl*)",
      "Bash(wget*)"
    ]
  }
}
```

**핵심 규칙:** `deny`는 어느 레벨에서든 무조건 우선합니다. 파일 편집은 자동 승인하되, 위험한 쉘 명령은 반드시 차단하세요.

### Auto Mode 구성

2026년 3월에 추가된 Auto Mode는 산문 기반 분류기를 사용합니다:

```json
{
  "autoMode": {
    "enabled": true,
    "environment": "Solo developer on macOS. Trusted local environment. Git repo with CI/CD. No production database access."
  }
}
```

`claude auto-mode defaults`로 기본 동작을, `claude auto-mode critique`로 분류 로직을 검사할 수 있습니다.

## 2. CLAUDE.md: Claude에게 프로젝트를 가르치는 법

CLAUDE.md는 Claude가 프로젝트에 대해 아는 모든 것의 출발점입니다. **200줄 이하**를 목표로 하세요.

### 왜 200줄인가

Anthropic의 내부 테스트 결과:

| CLAUDE.md 크기 | 규칙 적용률 |
|---------------|------------|
| 200줄 이하 | 92%+ |
| 200-400줄 | 약 80% |
| 400줄 이상 | 71% 이하 |

파일이 길어질수록 Claude는 규칙을 선택적으로 무시하기 시작합니다.

### 효과적인 CLAUDE.md 구조

```markdown
# Project: my-app

## Build & Test
- `npm run build` -- TypeScript 빌드
- `npm test` -- Vitest로 전체 테스트
- `npm run lint` -- ESLint 실행

## Architecture
- src/api/ -- Express REST 엔드포인트
- src/services/ -- 비즈니스 로직 (DB 접근 금지)
- src/repos/ -- 데이터 접근 계층

## Rules
- 모든 함수에 JSDoc 타입 주석 필수
- 테스트 없는 PR은 머지하지 않음
- snake_case for DB columns, camelCase for JS

## Common Mistakes
- ❌ services/에서 직접 DB 쿼리하지 마세요 → repos/ 사용
- ❌ any 타입 사용 금지
```

### 핵심 패턴

**긍정형 지시가 부정형보다 효과적입니다:**

```markdown
# WRONG
- Do NOT use default exports

# RIGHT
- Use named exports exclusively
```

**`@path` 임포트로 점진적 공개:**

큰 프로젝트에서는 CLAUDE.md를 짧게 유지하고, 세부 내용은 별도 파일로 분리합니다:

```markdown
## Detailed Guides
@context/api-patterns.md
@context/testing-strategy.md
```

**경로별 규칙 적용:**

`.claude/rules/` 디렉토리에 YAML frontmatter로 특정 경로에만 적용되는 규칙을 만들 수 있습니다:

```yaml
---
paths: ["src/api/**"]
---
모든 API 엔드포인트에 rate limiting 미들웨어를 적용하세요.
```

### CLAUDE.md vs settings.json vs 훅

| 용도 | 도구 | 강제력 |
|------|------|--------|
| 코드 스타일, 아키텍처 가이드 | CLAUDE.md | 권고 (~80%) |
| 권한, 모델, 샌드박스 | settings.json | 강제 (100%) |
| 포맷팅, 린팅, 차단 | Hooks | 강제 (100%) |

**규칙:** Claude에게 3번 이상 같은 말을 반복했다면, CLAUDE.md에서 훅으로 옮기세요.

## 3. Hooks: 결정론적 자동화

Hooks는 Claude Code에서 유일하게 **100% 확실한** 자동화 수단입니다. CLAUDE.md가 "해주세요"라면, 훅은 "무조건 합니다"입니다.

### 25개 이벤트 타입

2026년 3월 기준, Claude Code는 25개 훅 이벤트를 지원합니다:

| 카테고리 | 이벤트 |
|----------|--------|
| 세션 | `SessionStart`, `SessionEnd`, `UserPromptSubmit` |
| 도구 | `PreToolUse`, `PostToolUse`, `PermissionRequest` |
| 상태 | `Stop`, `StopFailure`, `ConfigChange`, `CwdChanged` |
| 파일 | `FileChanged`, `InstructionsLoaded` |
| 컨텍스트 | `PreCompact`, `PostCompact` |
| 에이전트 | `SubagentStart`, `SubagentStop`, `TeammateIdle` |
| 작업 | `TaskCreated`, `TaskCompleted` |
| 기타 | `Elicitation`, `WorktreeCreate`, `WorktreeRemove` |

### 4가지 훅 타입

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "type": "command",
        "matcher": "Edit|Write",
        "command": "prettier --write $TOOL_INPUT_FILE_PATH"
      }
    ]
  }
}
```

| 타입 | 설명 | 용도 |
|------|------|------|
| `command` | 쉘 명령 실행 | 포맷터, 린터, 알림 |
| `prompt` | LLM 단일 턴 평가 | 완료 여부 체크 |
| `agent` | 멀티턴 서브에이전트 | 테스트 검증 |
| `http` | HTTP POST 요청 | 외부 서비스 연동 |

### 실전 훅 레시피 5선

**1) 파일 저장 후 자동 포맷팅:**

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "type": "command",
        "matcher": "Edit|Write",
        "command": "prettier --write \"$TOOL_INPUT_FILE_PATH\" 2>/dev/null || true"
      }
    ]
  }
}
```

**2) 위험한 명령 차단:**

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "type": "command",
        "matcher": "Bash",
        "command": "echo \"$TOOL_INPUT\" | grep -qE 'rm -rf /|git push --force (main|master)|DROP TABLE' && exit 2 || exit 0"
      }
    ]
  }
}
```

`exit 2`는 도구 실행을 차단합니다. `exit 0`은 통과입니다.

**3) 커밋 전 린트 실행 (v2.1.85+):**

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "type": "command",
        "matcher": "Bash",
        "if": "Bash(git commit*)",
        "command": "npm run lint -- --quiet"
      }
    ]
  }
}
```

**4) 작업 완료 시 데스크톱 알림 (macOS):**

```json
{
  "hooks": {
    "Stop": [
      {
        "type": "command",
        "command": "osascript -e 'display notification \"Claude Code 작업 완료\" with title \"Claude Code\"'"
      }
    ]
  }
}
```

**5) Stop 훅으로 완료 검증:**

```json
{
  "hooks": {
    "Stop": [
      {
        "type": "prompt",
        "prompt": "모든 태스크가 완료되었는지, 테스트가 통과하는지 확인하세요. 미완료 항목이 있으면 계속 진행하세요."
      }
    ]
  }
}
```

**성능 가이드라인:** 각 훅은 200ms 이내로 유지하세요. 더 오래 걸리는 작업은 `async: true`를 사용합니다.

## 4. 커스텀 커맨드: 반복 작업을 슬래시 하나로

`.claude/commands/` 또는 `.claude/skills/`에 마크다운 파일을 넣으면 `/슬래시-커맨드`가 됩니다.

### 커맨드와 스킬의 통합

2026년 1월부터 commands와 skills가 통합되었습니다. 두 경로 모두 동일하게 슬래시 커맨드를 생성합니다. 스킬이 권장되는 이유는 디렉토리 구조, YAML frontmatter, 자동 검색을 지원하기 때문입니다.

### 커맨드 구조

```markdown
---
name: deploy-check
description: 배포 전 체크리스트 실행. 린트, 테스트, 빌드 순서로 검증
allowed-tools: ["Bash", "Read", "Grep"]
---

다음 순서로 배포 전 체크리스트를 실행하세요:

1. `npm run lint` 실행 -- 에러가 있으면 중단
2. `npm test` 실행 -- 실패 테스트가 있으면 중단
3. `npm run build` 실행 -- 빌드 에러 확인
4. `git status`로 커밋되지 않은 변경사항 확인

$ARGUMENTS 가 있으면 해당 브랜치에서 체크를 실행하세요.

모든 체크를 통과하면 ✅ 배포 가능을 출력하세요.
실패한 항목이 있으면 ❌ 와 함께 실패 이유를 출력하세요.
```

### 5개 도메인별 커맨드 예시

**개발:** TDD 사이클, 병렬 코드 리뷰, 라이브 문서 조회

```markdown
---
name: tdd
description: RED-GREEN-REFACTOR TDD 사이클 실행
---
1. $ARGUMENTS 에 대한 테스트를 먼저 작성하세요 (RED)
2. 테스트를 실행해서 실패를 확인하세요
3. 최소한의 코드로 테스트를 통과시키세요 (GREEN)
4. 리팩토링하세요 (REFACTOR)
5. 커버리지 80% 이상을 확인하세요
```

**콘텐츠 생성:** 아티클 작성, 감사, 캘린더

**DevOps:** 배포 체크리스트, 인시던트 대응, SRE/SLO 관리

**보안:** 코드베이스 스캐닝, 컴플라이언스 체크

**자율 루프:** 프로토타입→프로덕션 변환, GitHub-Linear 양방향 싱크

### 효과적인 커맨드 작성 팁

1. 설명(description)을 3인칭으로, 핵심 용도를 250자 이내 첫 문장에 배치
2. 부작용이 있는 커맨드에는 `disable-model-invocation: true` 추가
3. SKILL.md는 500줄 이하로 유지, 상세 내용은 하위 파일로 분리
4. 마이그레이션처럼 정확해야 하는 작업은 구체적 스크립트, 코드 리뷰처럼 유연한 작업은 높은 자유도

## 5. MCP 서버: Claude의 손발을 확장하다

MCP(Model Context Protocol)는 Claude Code에 외부 도구와 데이터 소스를 연결합니다. 레지스트리에 거의 **2,000개 서버**가 등록되어 있습니다.

### 설정 방법

```bash
# CLI 위저드 (가장 쉬운 방법)
claude mcp add github --transport http --url https://api.githubcopilot.com/mcp/

# JSON으로 직접 추가
claude mcp add-json postgres '{"type":"stdio","command":"npx","args":["@anthropic-ai/mcp-server-postgres","postgresql://localhost/mydb"]}'
```

3가지 스코프가 있습니다:

| 스코프 | 위치 | 공유 |
|--------|------|------|
| Local | `~/.claude.json` | 나만 사용 |
| Project | `.mcp.json` (git 포함) | 팀 공유 |
| User | `~/.claude/settings.json` | 전체 프로젝트 |

우선순위: Local > Project > User

### 실전에서 가장 많이 쓰이는 MCP 서버

| 서버 | 용도 | 추천도 |
|------|------|--------|
| GitHub | PR, 이슈, 코드 검색 | ★★★★★ |
| Context7 | 라이브러리 공식 문서 실시간 조회 | ★★★★★ |
| PostgreSQL (dbhub) | DB 스키마, 쿼리 실행 | ★★★★☆ |
| Playwright | 브라우저 자동화, E2E 테스트 | ★★★★☆ |
| Sentry | 에러 모니터링 연동 | ★★★☆☆ |
| Filesystem | 로컬 파일 시스템 접근 | ★★★☆☆ |
| Terraform | IaC 프로바이더 스키마 | ★★★☆☆ |

### MCP 운영 팁

- **4개 이하로 시작하세요.** 대부분의 사용자가 매일 쓰는 서버는 4개 이하입니다
- DB 서버에는 반드시 **읽기 전용 토큰**을 사용하세요
- 커뮤니티 서버는 설치 전에 **소스 코드를 확인**하세요
- Tool Search(Sonnet 4/Opus 4 이후 기본 활성화)가 MCP 도구 스키마를 지연 로딩하여 컨텍스트를 절약합니다

## 6. 멀티 에이전트 오케스트레이션

Claude Code의 가장 강력한 기능은 여러 에이전트를 동시에 실행하는 것입니다. 2026년 기준 3가지 티어가 존재합니다.

### Tier 1: 서브에이전트 (안정)

단일 세션 내에서 Agent 도구로 생성합니다. 각 에이전트는 독립 컨텍스트, 커스텀 시스템 프롬프트, 도구 제한, 모델 선택을 가집니다.

```
부모 에이전트 (Opus)
├── 보안 리뷰 에이전트 (Sonnet) → background
├── 성능 분석 에이전트 (Sonnet) → background
└── 타입 체크 에이전트 (Haiku) → background
```

**핵심:** 서브에이전트끼리는 통신할 수 없습니다. 부모에게만 결과를 보고합니다.

### Tier 2: Agent Teams (실험적)

```bash
export CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1
```

3-5명의 팀원이 태스크 리스트를 공유하고, 의존성을 추적하며, 피어 투 피어 메시지를 주고받습니다.

- **최적 규모:** 3-5 팀원, 팀원당 5-6 태스크
- tmux 분할 패널 또는 in-process 모드로 표시
- `TeammateIdle`, `TaskCreated`, `TaskCompleted` 훅으로 품질 게이트 구현

### Tier 3: DevFleet (MCP 기반)

미션 DAG 오케스트레이션. 각 에이전트가 격리된 git worktree에서 실행되고, 완료 시 자동 머지합니다.

### 비용 최적화 전략

```
오케스트레이터: Opus (계획, 의사결정)
실행 에이전트:  Sonnet (코드 작성, 리뷰)
탐색 에이전트:  Haiku (파일 검색, 간단한 분석)
```

**병목은 생성이 아니라 검증입니다.** 에이전트 수를 늘리는 것보다, 각 에이전트에 구체적인 스코프, 파일 참조, 성공 기준을 제공하는 것이 훨씬 효과적입니다.

## 7. DevOps와 CI/CD 통합

Claude Code는 로컬 개발뿐 아니라 CI/CD 파이프라인에서도 동작합니다.

### GitHub Actions

공식 액션: `anthropics/claude-code-action@v1`

```yaml
name: Claude PR Review
on:
  pull_request:
    types: [opened, synchronize]

jobs:
  review:
    runs-on: ubuntu-latest
    steps:
      - uses: anthropics/claude-code-action@v1
        with:
          anthropic_api_key: ${{ secrets.ANTHROPIC_API_KEY }}
          prompt: |
            이 PR의 변경사항을 리뷰하세요.
            보안 취약점, 성능 이슈, 코드 품질을 확인하세요.
```

**프로덕션 레시피:**
- PR 리뷰 자동화
- 이슈→PR 자동 변환
- 테스트 코드 자동 생성
- 릴리스 노트 작성

### 헤드리스 모드

CI/CD에서는 `-p` 플래그와 `--bare`로 실행합니다:

```bash
claude -p "모든 테스트를 실행하고 결과를 JSON으로 출력해" --bare --output-format json
```

### Managed Code Review (2026년 3월)

Teams/Enterprise 전용 기능으로, 멀티 에이전트 함대가 PR을 분석합니다. `REVIEW.md`로 커스터마이징 가능하며, 머신 리더블 심각도 출력으로 CI 게이팅을 구현합니다. 리뷰당 평균 비용은 $15-25입니다.

### 실전 성과

- TELUS: 57,000명 직원 배포, **PR 턴어라운드 30% 단축**
- Rakuten: 수백만 LOC를 7시간에 처리, **99.9% 정확도**
- 한 케이스 스터디: 350k+ LOC 코드베이스에서 **생산성 2.3배 향상**

## 8. IDE 통합: 어디서든 같은 경험

### VS Code (가장 기능이 풍부)

- 인라인 diff, `@`-멘션 (fuzzy matching + 라인 범위)
- Plan 모드 (마크다운 리뷰), 체크포인트/되감기
- 병렬 탭 대화, Chrome 브라우저 통합 (`@browser`)
- Jupyter 노트북 실행
- **팁:** 보조 사이드바에 Claude를 고정하면 코드와 대화를 동시에 볼 수 있습니다

### JetBrains (IntelliJ, PyCharm, WebStorm, Android Studio, GoLand)

- 네이티브 diff 뷰어 통합
- 자동 진단 공유 (린트/구문 에러)
- 선택 영역 컨텍스트 자동 공유

### Desktop App (macOS/Windows)

VS Code에 없는 **독점 기능**들:

- 비주얼 diff 리뷰 (인라인 코멘트)
- 내장 브라우저로 라이브 앱 프리뷰
- Computer Use (마우스/키보드 직접 조작)
- PR 모니터링 + 자동 수정/자동 머지
- Dispatch (폰에서 태스크 전송)
- 예약된 반복 태스크

### Web App (claude.ai/code)

- GitHub 레포에 직접 연결 (로컬 환경 불필요)
- 비동기 태스크, 보안 스캐닝
- 웹 세션을 VS Code에서 이어서 작업 가능

## 9. 컨텍스트 관리: 숨은 생산성 킬러

컨텍스트 윈도우가 1M 토큰이라 해도, 관리하지 않으면 성능이 급격히 떨어집니다.

### 핵심 수치

| 컨텍스트 사용률 | 성능 |
|----------------|------|
| 0-20% | 최적 |
| 20-40% | 성능 저하 시작 |
| 40%+ | 눈에 띄게 느려짐 |

### 실전 관리 전략

**1) `/clear`를 적극 사용하세요.** 무관한 태스크 사이에 `/clear`를 실행하면 토큰 50-70%를 절약합니다.

**2) 조사는 서브에이전트에 위임하세요.** 파일 탐색, 코드 검색은 서브에이전트가 하면 메인 컨텍스트가 깨끗하게 유지됩니다.

**3) CLAUDE.md는 `/compact`에서 살아남습니다.** 컴팩션 시 디스크에서 다시 읽기 때문입니다. 중요한 지시사항은 CLAUDE.md에 넣으세요.

**4) PostCompact 훅으로 리마인더 재주입:**

```json
{
  "hooks": {
    "PostCompact": [
      {
        "type": "command",
        "command": "echo '리마인더: 모든 파일 변경 후 lint를 실행하세요.'"
      }
    ]
  }
}
```

## 10. 커뮤니티에서 배우는 실전 패턴

10개 에이전트 리서치에서 발견한, 가장 가치 있는 커뮤니티 패턴입니다.

### DO: 이것은 하세요

- **CLAUDE.md를 30-80줄로 유지** -- 짧고 집중된 파일이 긴 파일보다 훨씬 효과적
- **긍정형 지시 사용** -- "default export 금지" 대신 "named export만 사용"
- **핵심 규칙을 상단과 하단 모두 배치** -- Claude는 파일의 처음과 끝에 더 주의를 기울임
- **서브디렉토리별 CLAUDE.md 활용** -- 경로별로 다른 규칙 적용
- **3번 이상 반복한 지시는 훅으로** -- 훅은 100% 강제, CLAUDE.md는 ~80%

### DON'T: 이것은 피하세요

- **`@file`로 문서를 임베드하지 마세요** -- 대화 시작 전에 지시 예산을 소진합니다
- **테스트가 깨지면 테스트를 수정하지 마세요** -- Claude가 가끔 코드 대신 테스트를 수정합니다. 코드를 고치도록 명시하세요
- **git 작업을 Claude에게 맡기지 마세요** -- push, merge, rebase는 직접 하세요
- **한 번에 너무 큰 태스크를 주지 마세요** -- Claude가 복잡한 태스크를 일찍 포기하는 경향이 있습니다. 작게 나누세요

### 추천 리소스

| 리소스 | Stars | 특징 |
|--------|-------|------|
| [awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code) | 33,800 | 종합 큐레이션 |
| [claude-code-ultimate-guide](https://github.com/FlorianBruniaux/claude-code-ultimate-guide) | - | 실전 가이드 |
| [claude-code-hooks-mastery](https://github.com/disler/claude-code-hooks-mastery) | - | 훅 전문 |
| [Builder.io 50 Tips](https://www.builder.io/blog/claude-code-tips-best-practices) | - | 팁 모음 |

## 종합: Harness 구성 체크리스트

새 프로젝트에서 Claude Code harness를 처음부터 구성할 때의 체크리스트입니다.

### Phase 1: 기초 (5분)

- [ ] `claude /init`으로 CLAUDE.md 자동 생성
- [ ] settings.json에 모델 라우팅 설정 (`opusplan` 또는 프로젝트에 맞는 모델)
- [ ] 기본 deny 규칙 추가 (`rm -rf`, `push --force`, 시크릿 파일)

### Phase 2: 자동화 (15분)

- [ ] PostToolUse 훅으로 자동 포맷팅 (Prettier, Black, gofmt)
- [ ] PreToolUse 훅으로 위험 명령 차단
- [ ] Stop 훅으로 완료 검증

### Phase 3: 확장 (30분)

- [ ] 반복 워크플로우를 커스텀 커맨드로 변환
- [ ] MCP 서버 연결 (GitHub 우선, 필요시 DB, Playwright)
- [ ] 서브에이전트 모델 라우팅 (Haiku로 비용 절감)

### Phase 4: 팀 공유

- [ ] `.claude/settings.json`을 git에 포함 (프로젝트 레벨)
- [ ] `.mcp.json`으로 MCP 서버 공유
- [ ] CLAUDE.md를 팀 코딩 표준에 맞게 조정

---

*이 글은 10개 리서치 에이전트(총 50만+ 토큰)를 병렬 실행하여 공식 문서, GitHub, 커뮤니티 토론, 뉴스레터를 조사한 결과를 바탕으로 작성되었습니다. 2026년 3월 29일 기준.*
