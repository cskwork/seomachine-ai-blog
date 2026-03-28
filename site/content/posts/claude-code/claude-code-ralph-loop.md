---
title: "Claude Code Ralph Loop 완전 가이드: AI가 진짜 끝날 때까지 코딩하게 만드는 법"
date: 2026-03-28
draft: false
tags: ["Claude Code", "Ralph Loop", "자율 코딩", "에이전트 루프", "자동화", "TDD"]
categories: ["Claude Code"]
description: "Ralph Loop는 Claude Code를 while true 루프로 감싸 작업이 진짜 완료될 때까지 반복시키는 패턴입니다. 작동 원리, 구현 방법, 커뮤니티 검증 사례를 정리합니다."
summary: "Claude Code가 '다 했다'고 멈추는 문제를 해결하는 Ralph Loop. 원리, 구현, 실전 패턴을 정리합니다."
difficulty: "중급"
ShowToc: true
TocOpen: true
---

Claude Code로 복잡한 기능을 구현하다 보면 반복적으로 겪는 상황이 있습니다. AI가 "완료했습니다"라고 보고하지만, 테스트를 돌려보면 3개가 실패합니다. 린트 에러도 남아 있습니다. 그런데 Claude는 이미 만족스럽게 작업을 끝냈다고 판단한 상태입니다.

이 문제를 정면으로 해결하는 패턴이 있습니다. Ralph Loop입니다.

## Ralph Loop란

Ralph Loop는 Claude Code를 bash `while true` 루프로 감싸서, **외부 검증 조건이 충족될 때까지 동일한 프롬프트를 반복 주입**하는 패턴입니다. 2025년 2월 독립 소프트웨어 엔지니어 Geoffrey Huntley가 발견했고, 현재는 Anthropic 공식 플러그인(`plugins/ralph-wiggum`)으로 흡수되었습니다.

이름은 심슨 가족의 Ralph Wiggum에서 왔습니다. 무지함과 끈기와 낙관이 결합된 캐릭터가 이 패턴의 작동 방식을 정확히 반영합니다. Huntley 본인은 이 기법을 발견했을 때 "ralph하고 싶었다"(1980년대 슬랭으로 구토)고 표현했습니다.

핵심 통찰은 단순합니다. AI 에이전트의 상태는 컨텍스트 창이 아니라 **디스크**에 있습니다. 파일, git 히스토리, 테스트 결과, 로그. 각 반복은 신선한 컨텍스트로 시작하지만, 이전 작업의 결과물은 파일시스템에 그대로 남아 있습니다.

## 작동 원리

Ralph Loop의 구조는 다섯 단계로 이루어집니다.

**1단계: 프롬프트 파일 작성.** PRD(Product Requirements Document)와 명확한 수락 기준을 담은 프롬프트 파일을 만듭니다. "사용자 등록 API를 구현하라"가 아니라, "모든 테스트가 통과하고 린트 에러가 0이면 DONE을 출력하라"처럼 기계적으로 검증 가능한 종료 조건을 포함합니다.

**2단계: bash 루프 실행.** `while true` 루프가 Claude Code를 해당 프롬프트로 실행합니다.

**3단계: 에이전트 작업.** Claude가 코드를 읽고, 수정하고, 테스트를 실행합니다.

**4단계: Stop hook 검증.** 에이전트가 종료를 시도하면 Stop hook이 가로챕니다. 출력에 "Completion Promise" 문자열(예: `DONE`)이 없으면 원본 프롬프트를 재주입합니다.

**5단계: 수렴 또는 중단.** 완료 약속어가 발견되거나 최대 반복 횟수에 도달하면 루프가 종료됩니다.

다음은 가장 단순한 형태의 Ralph Loop 구현입니다.

```bash
#!/bin/bash
MAX_ITERATIONS=20
ITERATION=0

while [ $ITERATION -lt $MAX_ITERATIONS ]; do
  ITERATION=$((ITERATION + 1))
  echo "=== Iteration $ITERATION ==="

  OUTPUT=$(claude -p "$(cat prompt.md)" --allowedTools Edit,Bash,Read,Write)

  if echo "$OUTPUT" | grep -q "DONE"; then
    echo "Completion promise found. Exiting."
    break
  fi

  echo "No completion promise. Re-entering loop..."
done
```

이 스크립트의 핵심은 `--allowedTools` 플래그입니다. 에이전트가 사용할 수 있는 도구를 명시적으로 제한하여, 의도하지 않은 파괴적 작업을 방지합니다.

그런데 실무에서는 이 기본 구조만으로는 부족합니다. 다음 섹션에서 커뮤니티가 검증한 고급 구현체를 살펴봅니다.

## 주요 구현체 비교

Ralph Loop는 여러 오픈소스 프로젝트로 구현되어 있습니다. 각각의 특징이 다르므로 용도에 맞게 선택해야 합니다.

| 프로젝트 | 특징 | 최적 사용처 |
|---------|------|-----------|
| **snarktank/ralph** | Claude Code + Amp 지원, PRD 기반 태스크 관리 | 범용 자율 코딩 |
| **frankbria/ralph-claude-code** | 지능형 종료 감지, Claude Code 전용 | 정밀한 완료 판단이 필요할 때 |
| **Anthropic 공식 플러그인** | Stop hook 기반, 이중 조건 종료, 레이트 리밋 내장 | 공식 지원이 필요할 때 |
| **AnandChowdhary/continuous-claude** | 반복 간 공유 노트 파일, 자동 PR 생성 | 대규모 리팩토링, 커버리지 확장 |

주목할 차이는 종료 감지 방식입니다. 기본 Ralph는 단순 문자열 매칭을 사용하지만, `frankbria/ralph-claude-code`는 컨텍스트를 분석하여 에이전트가 실제로 작업을 완료했는지 아닌지를 지능적으로 판단합니다. Anthropic 공식 플러그인은 Completion Promise와 `EXIT_SIGNAL` 두 가지를 모두 요구하는 이중 조건을 적용합니다.

## Ralph Loop vs /loop: 차이점

Claude Code에는 내장 `/loop` 커맨드가 있습니다. Ralph Loop와 혼동하기 쉽지만 용도가 다릅니다.

| 구분 | Ralph Loop | /loop 커맨드 |
|-----|-----------|-------------|
| **목적** | 단일 태스크를 완료까지 반복 | 일정 간격으로 태스크 폴링 |
| **종료 조건** | 검증 기준 충족 | 시간 만료 (최대 3일) |
| **상태 관리** | git + 파일시스템 | 세션 내 컨텍스트 |
| **사용 예** | "이 기능을 구현 완료하라" | "5분마다 배포 상태를 확인하라" |
| **비용** | 높음 (50회 반복 시 $50-100+) | 낮음-중간 |

정리하면, Ralph는 **수렴형**(하나의 목표를 향해 반복)이고, `/loop`는 **주기형**(정해진 간격으로 감시)입니다.

## 커뮤니티 검증 사례

Ralph Loop는 이론이 아니라 실전에서 검증된 패턴입니다.

Geoffrey Huntley는 3개월간 Ralph Loop를 실행하여 LLVM 컴파일러를 포함한 프로그래밍 언어 "Cursed"를 완성했습니다. Y Combinator 해커톤에서는 팀들이 하룻밤 사이 6개 이상의 저장소를 배포했고, 총 API 비용은 $297이었습니다.

Alibaba Cloud는 "ReAct에서 Ralph Loop로"라는 분석을 발표하며, 이 패턴을 AI 에이전트 아키텍처의 패러다임 전환으로 평가했습니다. The Register, LinearB, Dev Interrupted 등 주요 개발자 매체에서도 다뤘습니다.

Boris Cherny(Claude Code 창시자)의 실제 워크플로우도 Ralph Loop의 원리를 따릅니다. 5개의 병렬 로컬 인스턴스를 별도 git 체크아웃으로 실행하고, Plan Mode로 계획을 반복한 뒤 auto-accept 모드로 일괄 구현합니다.

## Ralph Loop와 함께 쓰는 패턴

Ralph Loop는 단독으로도 강력하지만, 다른 패턴과 조합하면 신뢰성이 올라갑니다. 커뮤니티가 검증한 최적의 레이어링 구조는 다음과 같습니다.

### 1. CLAUDE.md (기반 레이어)

모든 루프의 시작점입니다. 프로젝트 규약, 이전에 발생한 실수, 스타일 가이드를 담아 에이전트의 행동 범위를 제한합니다. Boris Cherny는 각 팀이 실수를 기록하는 `CLAUDE.md`를 유지하여 Claude가 동일한 실수를 반복하지 않도록 합니다.

### 2. TDD Red-Green-Refactor (구현 규율)

Ralph Loop 안에서 TDD 사이클을 적용하면 각 반복의 검증이 자동화됩니다. 테스트 출력이 에이전트의 피드백 신호가 됩니다. 에이전트가 "테스트 통과"를 달성하지 못하면 루프가 자동으로 재시작합니다.

모범 사례는 멀티 에이전트 분리입니다. 한 에이전트가 테스트를 작성하고, 다른 에이전트가 구현합니다. 같은 에이전트가 둘 다 하면 테스트가 구현에 맞춰 변형되는 "자기 축하 머신" 문제가 발생합니다.

### 3. Fresh Context (컨텍스트 위생)

컨텍스트 창 사용량이 70%를 넘으면 Claude는 정확성보다 간결성을 우선합니다. 85%를 넘으면 품질이 측정 가능하게 저하됩니다. Ralph Loop는 매 반복마다 새로운 컨텍스트로 시작하기 때문에 이 문제를 구조적으로 해결합니다.

### 4. Spec-Driven Development (방향 설정)

Ralph Loop의 효과는 프롬프트 품질에 비례합니다. 커뮤니티 데이터에 따르면 구체적인 스펙을 제공한 경우 62% 빠르게 수렴했고, 스코프 크리프(범위 확장)가 완전히 제거되었습니다.

세 단계 성숙도로 적용할 수 있습니다. Spec-first(코드 전에 스펙 작성), Spec-anchored(태스크 완료 후 스펙 업데이트), Spec-as-source(스펙이 코드의 진실의 원천이 되는 단계)입니다.

### 5. Agent Teams (병렬 확장)

태스크가 병렬화 가능하면 Ralph Loop를 단일 에이전트가 아닌 여러 에이전트 팀으로 확장합니다. 각 에이전트가 격리된 git worktree에서 독립적으로 작업하고, 결과물을 브랜치로 머지합니다.

Anthropic은 이 패턴으로 16개 에이전트가 약 2,000 세션에 걸쳐 100,000줄 규모의 Rust C 컴파일러를 구축한 사례를 발표했습니다.

## OODA Loop와의 관계

모든 AI 코딩 에이전트는 본질적으로 OODA Loop(Observe-Orient-Decide-Act)를 실행합니다. Ralph Loop의 차별점은 **종료 판단을 에이전트 내부가 아닌 외부 검증으로 대체**한다는 점입니다.

일반적인 에이전트 루프에서는 에이전트 자신이 "작업이 완료되었다"고 판단하면 멈춥니다. Ralph Loop에서는 그 판단을 테스트 결과, 린트 출력, 빌드 성공 같은 기계적 검증에 위임합니다.

Rangle.io의 분석에 따르면, vibe coding이 실패하는 주된 원인은 개발자가 OODA의 **Orient 단계를 건너뛰고 Act에만 집중**하기 때문입니다. Ralph Loop에서 이를 방지하는 방법은 풍부한 컨텍스트 파일(CLAUDE.md, PRD, 아키텍처 문서)을 프롬프트에 포함시키는 것입니다.

이 차이가 왜 중요할까요? 느리지만 올바른 방향의 루프가, 빠르지만 잘못된 방향의 루프를 이깁니다.

## 비용과 안전 관리

Ralph Loop의 가장 큰 리스크는 비용입니다. 제어 없이 실행하면 API 비용이 급격히 증가합니다.

필수 안전장치 세 가지가 있습니다.

**최대 반복 횟수 설정.** 무한 루프를 방지하는 가장 기본적인 안전장치입니다. 대부분의 구현체는 20-50회를 기본값으로 사용합니다.

**서킷 브레이커.** 연속으로 동일한 에러가 반복되면 루프를 중단합니다. 에이전트가 해결할 수 없는 문제에 갇혀 비용만 소모하는 상황을 방지합니다.

**레이트 리밋.** Anthropic 공식 플러그인은 반복 사이에 지연을 삽입하여 API 호출 속도를 제한합니다. 비용 추적과 함께 사용하면 예산 초과를 방지할 수 있습니다.

보안 측면에서도 주의가 필요합니다. Bruce Schneier는 에이전트 OODA 루프의 각 단계(Observe, Orient, Decide, Act)에 보안 취약점이 있다고 지적했습니다. 프롬프트 인젝션, 도구 혼동, 출력 조작 등이 가능하므로, Ralph Loop를 프로덕션 환경에서 사용할 때는 `--allowedTools`로 도구를 최소한으로 제한하고, 샌드박스 환경에서 실행하는 것을 권장합니다.

## 실전 적용: 단계별 시작 가이드

Ralph Loop를 처음 적용할 때는 작은 태스크부터 시작합니다.

### Step 1: 프롬프트 파일 작성

```markdown
# Task: 사용자 등록 API 구현

## 수락 기준
- POST /api/users 엔드포인트 구현
- 이메일 유효성 검사 통과
- 중복 이메일 등록 방지
- 모든 테스트 통과 (jest --coverage)
- 린트 에러 0개 (eslint)
- 커버리지 80% 이상

## 완료 조건
모든 수락 기준이 충족되면 "DONE"을 출력하십시오.
충족되지 않은 기준이 있으면 해당 항목을 수정하고 다시 검증하십시오.
```

이 프롬프트의 핵심은 **기계적으로 검증 가능한** 수락 기준입니다. "좋은 코드를 작성하라"는 검증 불가능합니다. "모든 테스트 통과, 린트 에러 0개"는 검증 가능합니다.

### Step 2: 루프 스크립트 실행

```bash
#!/bin/bash
MAX_ITERATIONS=15
PROMPT_FILE="prompt.md"

for i in $(seq 1 $MAX_ITERATIONS); do
  echo "=== Iteration $i / $MAX_ITERATIONS ==="

  OUTPUT=$(claude -p "$(cat $PROMPT_FILE)" \
    --allowedTools Edit,Bash,Read,Write,Grep,Glob 2>&1)

  echo "$OUTPUT" | tail -5

  if echo "$OUTPUT" | grep -q "DONE"; then
    echo "Task completed at iteration $i"
    git add -A && git commit -m "feat: complete user registration API (ralph loop, $i iterations)"
    exit 0
  fi
done

echo "Max iterations reached without completion"
exit 1
```

완료 시 자동으로 git commit을 생성하여 작업 결과를 보존합니다.

### Step 3: 결과 검증

루프가 종료된 후에도 수동 검증을 권장합니다. 자동 테스트가 모든 경우를 커버하지는 않기 때문입니다.

```bash
# 테스트 재실행
npm test -- --coverage

# 린트 확인
npx eslint src/

# git diff로 변경 사항 리뷰
git diff HEAD~1
```

## 전체 루프 패턴 비교표

Ralph Loop는 Claude Code에서 사용되는 여러 루프 패턴 중 하나입니다. 상황에 따라 적합한 패턴이 다릅니다.

| 패턴 | 자율도 | 비용 | 최적 사용처 |
|-----|-------|-----|-----------|
| **Ralph Loop** | 최고 | 높음 | 명확한 수락 기준이 있는 구현 태스크 |
| **TDD Red-Green-Refactor** | 높음 | 중간 | 기능 구현, 버그 수정 |
| **Plan-Code-Test** (공식) | 중간 | 낮음 | 일반 개발 워크플로우 |
| **Continuous Claude** | 높음 | 높음 | 대규모 리팩토링, 커버리지 확장 |
| **Spec-Driven Development** | 높음 | 중간 | 복잡한 기능, 야간 자율 구현 |
| **Agent Teams** | 최고 | 매우 높음 | 병렬화 가능한 대규모 작업 |
| **/loop 커맨드** | 중간 | 낮음 | 정기적 모니터링, 상태 점검 |
| **REPL (대화형)** | 낮음 | 낮음 | 탐색, 디버깅, 학습 |

이 패턴들은 상호 배타적이 아닙니다. 가장 효과적인 접근은 레이어링입니다. CLAUDE.md로 기반을 잡고, Plan Mode로 설계하고, TDD로 구현하고, Fresh Context로 리셋하고, Ralph Loop로 자율 실행하고, Agent Teams로 병렬 확장합니다.

## 다음 단계

Ralph Loop를 시작하려면 세 가지를 준비합니다.

첫째, 기계적으로 검증 가능한 수락 기준을 담은 프롬프트 파일을 작성합니다. 이것이 전체 품질의 80%를 결정합니다.

둘째, 안전장치를 갖춘 루프 스크립트를 준비합니다. 최대 반복 횟수, 서킷 브레이커, 비용 추적은 선택이 아니라 필수입니다.

셋째, 작은 태스크부터 시작합니다. 단일 API 엔드포인트, 유틸리티 함수 리팩토링처럼 스코프가 명확한 작업으로 패턴을 익힌 뒤 점진적으로 확장합니다.

오픈소스 구현체 중 `snarktank/ralph`가 가장 범용적이고, Anthropic 공식 플러그인이 가장 안정적입니다. 프로젝트 상황에 맞게 선택하면 됩니다.

---

**참고 자료**

- [Geoffrey Huntley - Everything is a Ralph Loop](https://ghuntley.com/loop/)
- [Anthropic - Best Practices for Claude Code](https://code.claude.com/docs/en/best-practices)
- [The Register - Ralph Wiggum Loop](https://www.theregister.com/2026/01/27/ralph_wiggum_claude_loops/)
- [Alibaba Cloud - From ReAct to Ralph Loop](https://www.alibabacloud.com/blog/from-react-to-ralph-loop)
- [LinearB - Mastering Ralph Loops](https://linearb.io/blog/ralph-loop-agentic-engineering-geoffrey-huntley)
- [snarktank/ralph (GitHub)](https://github.com/snarktank/ralph)
- [frankbria/ralph-claude-code (GitHub)](https://github.com/frankbria/ralph-claude-code)
- [AnandChowdhary/continuous-claude (GitHub)](https://github.com/AnandChowdhary/continuous-claude)
- [Anthropic - Effective Harnesses for Long-Running Agents](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents)
- [Boris Cherny Workflow - InfoQ](https://www.infoq.com/news/2026/01/claude-code-creator-workflow/)
