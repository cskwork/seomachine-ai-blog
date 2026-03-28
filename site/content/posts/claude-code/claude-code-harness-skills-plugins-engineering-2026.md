---
title: "Claude Code Harness 완전 정복: 가장 많이 쓰이는 스킬, 플러그인, 엔지니어링 패턴 총정리 (2026)"
date: 2026-03-28T19:30:00+09:00
draft: false
tags: ["Claude Code", "Harness", "MCP", "Skills", "Hooks", "Agent Orchestration", "Context Engineering"]
categories: ["Claude Code"]
description: "10개 리서치 에이전트를 병렬 실행해 Claude Code harness 생태계를 전수 조사했습니다. 가장 많이 쓰이는 스킬 TOP 8, MCP 플러그인 TOP 6, 5대 오케스트레이션 패턴, 훅 엔지니어링, 컨텍스트 관리 전략까지."
summary: "Claude Code harness의 모든 것. 스킬, 플러그인, 훅, 에이전트, 메모리, 컨텍스트 관리까지 10개 영역을 실전 데이터 기반으로 정리합니다."
ShowToc: true
TocOpen: true
seo:
  primary_keyword: "Claude Code harness"
  secondary_keywords: ["Claude Code skills", "Claude Code MCP 플러그인", "Claude Code hooks", "Claude Code agent orchestration", "Claude Code context engineering"]
  word_count: 0
  quality_score: 0
  last_optimized: null
  review_required: false
---

"Claude Code를 설치했는데, 왜 남들처럼 안 되죠?"

대부분 harness 설정의 차이입니다. Claude Code 자체는 엔진이고, harness가 차체입니다. 같은 엔진이라도 경주용 차체를 얹으면 성능이 완전히 달라집니다. 2026년 3월 현재, Everything Claude Code(ECC)는 113,000+ 스타, obra/superpowers는 119,000+ 스타를 기록하며 harness 생태계가 폭발적으로 성장하고 있습니다.

10개 리서치 에이전트를 병렬 실행해 GitHub, 공식 문서, 커뮤니티 포럼을 전수 조사했습니다. 이 글에서는 실전에서 가장 많이 쓰이는 스킬, 플러그인, 엔지니어링 패턴을 데이터 기반으로 정리합니다.

---

## Harness란 무엇인가

Claude Code의 harness는 AI 에이전트가 동작하는 전체 구성 환경을 뜻합니다. 단일 파일이 아니라, 7개 구성 요소가 하나의 시스템을 이룹니다.

```
┌─────────────────────────────────────────────────┐
│              Claude Code Harness                 │
│                                                  │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐      │
│  │ CLAUDE.md│  │settings. │  │ MEMORY.md│      │
│  │ (지침)   │  │json(설정)│  │ (기억)   │      │
│  └────┬─────┘  └────┬─────┘  └────┬─────┘      │
│       │              │              │            │
│  ┌────▼──────────────▼──────────────▼────┐      │
│  │         Hooks (결정론적 강제)           │      │
│  │  Pre/PostToolUse · Stop · Session     │      │
│  └────┬──────────────┬──────────────┬────┘      │
│       │              │              │            │
│  ┌────▼─────┐  ┌────▼─────┐  ┌────▼─────┐      │
│  │  Skills  │  │  Agents  │  │ Commands │      │
│  │ (방법론) │  │ (실행자) │  │ (워크플로)│      │
│  └──────────┘  └──────────┘  └──────────┘      │
│       │              │              │            │
│  ┌────▼──────────────▼──────────────▼────┐      │
│  │       MCP Servers (외부 통합)          │      │
│  │  Context7 · Playwright · GitHub · ... │      │
│  └───────────────────────────────────────┘      │
└─────────────────────────────────────────────────┘
```

각 구성 요소의 역할을 요약하면 다음과 같습니다.

| 구성 요소 | 역할 | 저장 위치 |
|-----------|------|----------|
| **CLAUDE.md** | 프로젝트 지침, 아키텍처 가이드 | 프로젝트 루트 |
| **settings.json** | 권한, 모델, 환경 설정 | `~/.claude/settings.json` |
| **MEMORY.md** | Claude가 스스로 쓰는 기억 | `~/.claude/projects/<hash>/memory/` |
| **Hooks** | 도구 실행 전후 자동 스크립트 | `settings.json` 내부 |
| **Skills** | 재사용 가능한 방법론 파일 | `.claude/skills/` |
| **Agents** | 특화된 역할의 서브에이전트 | `.claude/agents/` |
| **Commands** | 슬래시 커맨드 워크플로우 | `.claude/commands/` |

이 7가지를 이해하면 harness 엔지니어링의 80%를 파악한 것입니다.

---

## 가장 많이 쓰이는 스킬 TOP 8

리서치 결과, 커뮤니티에서 가장 많이 복제되고 설치되는 스킬을 정리했습니다.

### 1위: `/plan → /tdd → /code-review → /verify` 워크플로우 체인

단일 스킬이 아니라 4개 스킬의 조합입니다. 이 체인이 Claude Code harness에서 가장 많이 복제되는 패턴입니다. 동작 방식은 다음과 같습니다.

1. **`/plan`** -- 구현 계획을 세우고 사용자 승인을 기다립니다
2. **`/tdd`** -- 테스트를 먼저 쓰고(RED), 구현하고(GREEN), 리팩터링합니다(REFACTOR)
3. **`/code-review`** -- 코드 품질, 보안, 유지보수성을 검토합니다
4. **`/verify`** -- 빌드, 타입체크, 린트, 테스트를 한 번에 실행합니다

이 체인이 인기 있는 이유는 명확합니다. AI 에이전트가 스스로 갖지 못하는 **규율**을 강제하기 때문입니다. `/tdd`가 없으면 AI는 테스트 없이 코드를 쓰고, `/plan`이 없으면 승인 없이 바로 코딩에 들어갑니다.

### 2위: `find-skills` (418K 설치)

Claude Code에서 사용 가능한 스킬을 검색하고 설치하는 메타 스킬입니다. npm 레지스트리에서 418,000회 이상 설치되었습니다.

### 3위: `/simplify` (3개 병렬 리뷰 에이전트)

작성한 코드를 3개의 에이전트가 병렬로 리뷰합니다. 재사용성, 품질, 효율성을 각각 독립적으로 평가한 뒤 문제를 수정합니다.

### 4위: `/learn-eval` (패턴 추출 + 품질 게이트)

세션에서 재사용 가능한 패턴을 자동으로 추출하고, 품질 게이트를 통과한 것만 저장합니다. harness가 사용할수록 똑똑해지는 자기개선 루프의 핵심입니다.

### 5위: `/save-session` + `/resume-session`

세션 상태를 파일로 저장하고 다음 대화에서 복원합니다. 멀티데이 작업의 연속성을 보장합니다.

### 6위: `vercel-react-best-practices` (176K 설치)

Vercel과 React 프로젝트의 베스트 프랙티스를 강제하는 프론트엔드 전용 스킬입니다.

### 7위: `/strategic-compact` (컨텍스트 관리)

논리적 중단점에서 수동 컴팩션을 제안합니다. 임의의 자동 컴팩션 대신 작업 단계 사이의 자연스러운 시점에서 컨텍스트를 정리합니다.

### 8위: 언어별 테스트 스킬 (`/go-test`, `/rust-test`, `/kotlin-test` 등)

공통 `/tdd` 스킬을 각 언어의 관용적 패턴으로 확장합니다. Go는 table-driven 테스트, Rust는 `cargo-llvm-cov`, Kotlin은 Kotest + MockK를 사용합니다.

---

## 가장 많이 쓰이는 MCP 플러그인 TOP 6

MCP(Model Context Protocol)는 Claude Code를 외부 시스템과 연결하는 표준 프로토콜입니다. GitHub Stars 기준 상위 플러그인을 정리했습니다.

| 순위 | MCP 서버 | Stars | 용도 |
|------|---------|-------|------|
| 1 | **modelcontextprotocol/servers** | 82K | 공식 레퍼런스 (filesystem, GitHub, Slack, Postgres 등) |
| 2 | **upstash/context7** | 51K | 라이브러리 최신 문서를 실시간으로 조회 |
| 3 | **ChromeDevTools MCP** | 32K | Google의 Chrome DevTools 자동화 |
| 4 | **microsoft/playwright-mcp** | 30K | 브라우저 자동화 + E2E 테스트 |
| 5 | **github/github-mcp-server** | 28K | GitHub 이슈, PR, 코드 검색 통합 |
| 6 | **PrefectHQ/fastmcp** | 24K | 커스텀 MCP 서버를 빠르게 만드는 프레임워크 |

### 카테고리별 채택률

Browser/Testing 카테고리가 압도적 1위입니다. Playwright와 ChromeDevTools를 합치면 약 62,000 스타로, AI 코딩에서 브라우저 자동화의 수요가 얼마나 큰지 보여줍니다.

```
Browser/Testing  ████████████████████████  ~80K
Documentation    ███████████████████       ~55K
Developer Tools  ██████████████            ~40K
Design (Figma)   ██████                    ~18K
Cloud/Infra      █████                     ~14K
```

### Context7이 특별한 이유

Context7(51K Stars)은 AI 코딩 도구의 근본적 문제를 해결합니다. LLM의 훈련 데이터는 과거 시점에 고정되어 있어 라이브러리의 최신 API를 모릅니다. Context7은 공식 문서를 실시간으로 가져와 Claude의 컨텍스트에 주입합니다. 예를 들어 `/docs "Next.js 15"`라고 입력하면, 훈련 데이터 대신 최신 공식 문서를 기반으로 코드를 생성합니다.

---

## Hooks Engineering: 결정론적 강제의 기술

### Hooks의 핵심 원칙

CLAUDE.md가 "제안"한다면, Hooks는 "강제"합니다. 이것이 harness 엔지니어링에서 가장 중요한 구분입니다.

```
CLAUDE.md: "코드를 작성한 후 포매터를 실행해주세요" → AI가 무시할 수 있음
Hook:      PostToolUse에 prettier 실행 등록       → 100% 실행됨
```

Claude Code는 현재 21개의 라이프사이클 이벤트를 지원합니다. 가장 많이 사용되는 3가지를 살펴봅니다.

### PreToolUse: 도구 실행 전 검증

도구가 실행되기 전에 매번 작동합니다. Exit code로 제어합니다.

- **Exit 0**: 통과 (도구 실행 허용)
- **Exit 1**: 경고 (실행은 하되 메시지 표시)
- **Exit 2**: 차단 (도구 실행 중단)

실전에서 가장 많이 쓰이는 PreToolUse 패턴은 보안 게이트입니다.

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "command": "bash -c 'echo \"$CLAUDE_TOOL_INPUT\" | grep -qE \"(rm -rf|DROP TABLE|--force)\" && exit 2 || exit 0'"
      }
    ]
  }
}
```

이 훅은 `rm -rf`, `DROP TABLE`, `--force` 같은 위험한 명령이 포함되면 실행을 차단합니다.

### PostToolUse: 도구 실행 후 자동화

가장 인기 있는 용도는 자동 포매팅입니다. 파일을 편집할 때마다 자동으로 포매터가 실행됩니다.

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "command": "prettier --write $CLAUDE_FILE_PATHS"
      }
    ]
  }
}
```

### Stop: 세션 종료 시 최종 검증

Claude가 응답을 마칠 때 실행됩니다. 테스트 실행, 린트 체크, 빌드 검증 등 최종 품질 게이트로 사용합니다.

### 6대 프로덕션 패턴

| 패턴 | Hook 타입 | 용도 |
|------|----------|------|
| Auto Formatter | PostToolUse | 파일 수정 시 자동 포매팅 |
| Security Gate | PreToolUse (exit 2) | 위험한 명령 차단 |
| Test Runner | PostToolUse | 코드 변경 시 자동 테스트 |
| Branch Protection | PreToolUse | main 브랜치 직접 커밋 방지 |
| Pre-commit Check | PreToolUse (Bash) | 커밋 전 품질 검증 |
| Observability | Pre + PostToolUse | 에이전트 행동 로깅 |

### 성능 규칙: 200ms

각 Hook은 동기적으로 실행됩니다. 한 실무자가 95개의 Hook을 등록하고도 지연 없이 운영한 사례가 있지만, 각 Hook을 200ms 이내로 유지하는 것이 핵심입니다.

---

## Agent Orchestration: 5대 패턴

Claude Code의 에이전트는 `.claude/agents/` 디렉토리에 YAML frontmatter가 포함된 마크다운 파일로 정의됩니다. 리서치 결과, 5가지 오케스트레이션 패턴이 실전에서 사용되고 있습니다.

### 패턴 1: Sequential Chain (순차 체인)

에이전트가 순서대로 실행됩니다. 앞 에이전트의 출력이 다음 에이전트의 입력이 됩니다.

```
plan → tdd → code-review → security-review → commit
```

**적합한 상황**: 의존성이 있는 워크플로우. 기능 개발의 표준 프로세스입니다.

### 패턴 2: Parallel Fan-Out (병렬 팬아웃)

독립적인 에이전트들이 git worktree로 격리된 환경에서 동시에 실행됩니다.

```
┌─ Agent 1: Frontend (worktree A)
│
├─ Agent 2: Backend  (worktree B)
│
└─ Agent 3: Tests    (worktree C)
```

**적합한 상황**: 서로 독립적인 도메인의 병렬 작업. 이 글의 리서치도 이 패턴으로 수행했습니다 -- 10개 에이전트가 각각 다른 주제를 동시에 조사했습니다.

### 패턴 3: Agent Teams (에이전트 팀)

2026년 2월 Opus 4.6과 함께 도입된 TeammateTool을 사용합니다. P2P(피어 투 피어) 방식으로 에이전트들이 공유 태스크 리스트와 메시징을 통해 조정합니다.

**적합한 상황**: 대규모 크로스도메인 기능 개발.

### 패턴 4: DevFleet (자동 분해 + 디스패치)

자연어로 프로젝트를 설명하면, AI가 자동으로 미션 단위로 분해하고 각 워커에게 디스패치합니다.

```bash
/devfleet "사용자 인증 모듈을 OAuth2 + JWT로 재구축"
```

**적합한 상황**: 큰 프로젝트를 빠르게 병렬화하고 싶을 때.

### 패턴 5: Swarm Orchestration (스웜)

Agent Teams + 도메인별 라우팅의 결합입니다. 리서치 스웜, 구현 스웜, 품질 스웜이 각각 전문 영역을 담당합니다.

**적합한 상황**: 대규모 프로젝트의 전체 생명주기 관리.

### 모델 라우팅 전략

에이전트별로 다른 모델을 배정하는 것이 비용과 성능의 최적점입니다.

| 역할 | 권장 모델 | 이유 |
|------|----------|------|
| Orchestrator/Planner | Opus | 깊은 추론 필요 |
| Coder/Reviewer | Sonnet | 최고의 코딩 성능 |
| Lightweight Worker | Haiku | 90% 성능, 3x 비용 절감 |

---

## Settings.json: 5단계 스코프 시스템

Claude Code의 설정은 5단계로 계층화됩니다. 상위 스코프가 하위를 오버라이드합니다.

```
Enterprise (/etc/claude-code/managed-settings.json)
  └── Session (런타임 오버라이드)
       └── Project Shared (.claude/settings.json)
            └── Project Local (.claude/settings.local.json)
                 └── User Global (~/.claude/settings.json)
```

### 권한 모델의 핵심: deny → ask → allow

설정에서 가장 중요한 부분은 권한 제어입니다. 평가 순서가 중요합니다.

1. **deny** 목록을 먼저 확인 (매칭되면 즉시 차단)
2. **ask** 목록 확인 (매칭되면 사용자에게 확인 요청)
3. **allow** 목록 확인 (매칭되면 자동 허용)

```json
{
  "permissions": {
    "deny": ["Bash(rm -rf *)", "Bash(DROP TABLE)"],
    "ask": ["Bash(git push *)"],
    "allow": ["Read", "Glob", "Grep", "Bash(npm run *)"]
  }
}
```

커뮤니티 데이터에 따르면, `--dangerously-skip-permissions` 플래그를 사용한 사용자의 **32%가 의도치 않은 파일 수정**을 경험했습니다. 대신 위와 같이 세분화된 패턴 매칭을 사용하는 것이 안전합니다.

---

## CLAUDE.md Engineering: 적게 쓸수록 잘 동작한다

### 150-200개 명령어 한계

프론티어 LLM은 총 약 150-200개의 명령어를 따릅니다. Claude Code의 시스템 프롬프트가 이미 약 50개를 소비합니다. 따라서 CLAUDE.md에 넣을 수 있는 효과적인 명령어는 약 100-150개입니다.

**문제는 여기서 발생합니다.** 저가치 규칙을 하나 추가할 때마다, 모든 다른 규칙의 준수율이 균일하게 하락합니다. ETH Zurich의 연구에 따르면, 자동 생성된 CLAUDE.md는 수동 작성 대비 **20% 이상 더 많은 토큰**을 소비합니다.

### 3계층 구조

CLAUDE.md는 3개 레벨로 구성되며, 가장 구체적인 것이 우선합니다.

```
~/.claude/CLAUDE.md           ← 글로벌 (모든 프로젝트)
./CLAUDE.md                   ← 프로젝트 (이 레포만)
./.claude/CLAUDE.md           ← 개인 (나만, gitignore됨)
```

### Progressive Disclosure 패턴

모든 지식을 CLAUDE.md에 넣지 마세요. 대신 skills, rules, docs에 분산하고 필요할 때만 로드하게 합니다. 이 패턴으로 토큰 사용량을 **59% 절약**할 수 있습니다.

```
# CLAUDE.md (간결하게)
## Testing
- TDD 필수. 상세 절차는 .claude/skills/tdd-workflow.md 참조

## Architecture
- 레이어드 아키텍처. 상세는 docs/architecture.md 참조
```

### Mitchell Hashimoto의 반응적 구성 원칙

> "관찰된 실패에 대응해서만 설정을 추가하라. 선제적으로 추가하지 마라."

빈 CLAUDE.md에서 시작해서, Claude가 실수할 때마다 그 실수를 방지하는 규칙을 한 줄씩 추가합니다. 이것이 가장 효과적인 CLAUDE.md 운영법입니다.

---

## Memory System: 4계층 아키텍처

Claude Code의 메모리 시스템은 세션 간 연속성을 제공합니다.

### 4계층 구조

| 계층 | 작성자 | 지속성 | 용도 |
|------|--------|--------|------|
| **CLAUDE.md** | 인간 | 영구 | 프로젝트 지침, 아키텍처 |
| **MEMORY.md** | Claude | 영구 | 학습한 패턴, 선호도, 피드백 |
| **Session Memory** | Claude | 세션 내 | 현재 대화 컨텍스트 |
| **Auto Dream** | Claude | 주기적 | 메모리 통합, 중복 제거 |

### MEMORY.md의 인덱스 패턴

MEMORY.md 자체에는 내용을 쓰지 않습니다. 각 메모리를 별도 파일로 저장하고, MEMORY.md는 인덱스만 유지합니다. 세션 시작 시 첫 200줄/25KB만 로드되므로, 인덱스를 통한 on-demand 로딩이 핵심입니다.

```markdown
# MEMORY.md (인덱스만)
- [User role](user_role.md) — 시니어 백엔드 엔지니어, Go 전문
- [Testing feedback](feedback_testing.md) — 통합 테스트에 실제 DB 사용 필수
- [Auth rewrite](project_auth.md) — OAuth2 마이그레이션 진행 중
```

### 가장 가치 있는 메모리 타입: Feedback

4가지 메모리 타입(user, feedback, project, reference) 중 **feedback**이 가장 높은 ROI를 보입니다. "그렇게 하지 마"라는 수정 피드백을 저장하면, 같은 실수를 다시 하지 않습니다.

### Auto Dream: AI의 REM 수면

Auto Dream은 축적된 메모리를 주기적으로 통합합니다. 중복을 제거하고, 오래된 항목을 정리하고, 상대 날짜를 절대 날짜로 변환합니다. 한 사례에서 913개 세션의 메모리를 9분 만에 통합했습니다.

---

## Context Engineering: 1M 토큰 시대에도 관리가 필요한 이유

2026년 현재 Claude Code는 1M 토큰 컨텍스트 윈도우를 지원합니다. 그럼에도 컨텍스트 관리가 필요한 이유는 두 가지입니다.

1. **품질 저하**: 노이즈가 많으면 관련 정보를 찾는 정확도가 떨어집니다
2. **비용 증가**: 토큰 사용량에 비례하여 비용이 증가합니다

### context-mode 플러그인: 98% 압축

context-mode(mksglu/context-mode)는 가장 널리 쓰이는 컨텍스트 관리 MCP 플러그인입니다. 측정 결과, 315KB의 도구 출력을 5.4KB로 압축합니다 -- **98% 감소**입니다.

동작 원리는 다음과 같습니다.

1. 도구 출력을 격리된 서브프로세스(sandbox)에서 실행
2. SQLite FTS5(Full-Text Search)에 인덱싱
3. BM25 랭킹으로 관련 결과만 컨텍스트에 반환
4. 원본 데이터는 컴팩션 후에도 인덱스에서 검색 가능

### 7대 컨텍스트 엔지니어링 패턴

| 패턴 | 설명 | 효과 |
|------|------|------|
| **JIT 로딩** | 필요한 시점에만 파일을 읽음 | 불필요한 컨텍스트 방지 |
| **컴팩션** | 이전 메시지를 요약으로 대체 | 가역적 (요약은 비가역) |
| **샌드위치 패턴** | 핵심 지침을 시작과 끝에 배치 | 명령어 준수율 향상 |
| **서브에이전트 위임** | 복잡한 조사를 서브에이전트에게 | 부모 컨텍스트 보호 |
| **계층적 메모리** | Hot/Warm/Cold 데이터 분리 | 토큰 효율성 |
| **ACON 최적화** | 적응형 컨텍스트 조절 | 피크 26-54% 감소 |
| **스킬 Lazy Loading** | 호출된 스킬만 로드 | Progressive Disclosure |

### Spotify의 실전 교훈

Spotify는 Claude Code로 1,500+ PR을 머지한 경험에서 핵심 교훈을 공유했습니다.

> "파일 내용을 컨텍스트에서 제거하세요. 에이전트는 다시 읽을 수 있습니다."

분석을 위해 파일을 읽었다면, 그 내용이 컨텍스트에 남아 있을 필요가 없습니다. 에이전트는 필요할 때 다시 Read 도구를 호출할 수 있습니다.

---

## TDD/Testing: 서브에이전트 격리가 핵심

### 위상 오염 방지

harness 기반 TDD에서 가장 중요한 엔지니어링 원칙은 **서브에이전트 격리**입니다. 테스트를 작성하는 에이전트와 구현 코드를 작성하는 에이전트의 컨텍스트를 분리해야 합니다.

왜냐하면, 같은 컨텍스트에서 테스트와 구현을 모두 작성하면, 구현 방식에 맞춰 테스트를 작성하는 경향이 생기기 때문입니다. 분리하면 테스트가 진정한 "요구사항 검증"으로 기능합니다.

### 3대 검증 루프

| 패턴 | 특징 |
|------|------|
| **Anthropic 공식 2-agent** | initializer + coding agent, `claude-progress.txt`로 상태 공유 |
| **Ralph Loop** | 매 사이클마다 새 Claude 인스턴스 생성 (컨텍스트 오염 방지) |
| **AutoResearch** | 감지 → 수정 ONE thing → 커밋 → 에러 감소 확인 → keep/revert |

### 4단계 품질 게이트

```
PASS      → 변경 승인
CONCERNS  → 경고와 함께 승인
REWORK    → 수정 후 재검토 필요
FAIL      → 차단, 수정 필수
```

최대 5라운드까지 반복하며, 각 라운드에서 여러 에이전트가 다른 관점(보안, 성능, 일관성)으로 리뷰합니다.

---

## GitHub 생태계: 주요 Harness 레포

실전에서 참고할 수 있는 주요 레포를 Stars 순으로 정리합니다.

| 레포 | Stars | 특징 |
|------|-------|------|
| **openclaw/openclaw** | 339K | AI 어시스턴트 플랫폼 + 스킬 마켓플레이스 |
| **obra/superpowers** | 119K | 구성 가능한 스킬 프레임워크 + SDLC 방법론 |
| **affaan-m/everything-claude-code** | 113K | 종합 harness (28 에이전트, 119 스킬, 60 커맨드) |
| **hesreallyhim/awesome-claude-code** | 33K | 정식 awesome-list |
| **VoltAgent/awesome-claude-code-subagents** | 15K | 100+ 서브에이전트 정의 |
| **rohitg00/awesome-claude-code-toolkit** | 930 | 135 에이전트, 35 스킬, 42 커맨드 |

### 프로젝트별 철학 차이

- **obra/superpowers**: 스킬을 방법론으로 봅니다. 프레임워크에 의존하지 않는 포터블 스킬 파일
- **ECC**: 풀 시스템 접근. 스킬 + 인스팅트 + 메모리 + 보안까지 통합
- **Chachamaru127/claude-code-harness**: 자율 Plan-Work-Review 사이클 중심

---

## 실전 적용: 어디서부터 시작할까

harness 설정이 처음이라면, 다음 순서를 권장합니다.

### 1단계: 최소 구성 (10분)

```bash
# CLAUDE.md 생성 (빈 파일에서 시작)
echo "# Project\n\n## Build\nnpm run build\n\n## Test\nnpm test" > CLAUDE.md
```

### 2단계: 핵심 스킬 설치 (30분)

`/plan`, `/tdd`, `/code-review`, `/verify` 워크플로우 체인을 설치합니다. ECC를 통째로 설치하는 것보다, 필요한 스킬만 선택하는 것이 효과적입니다.

### 3단계: 첫 번째 Hook 추가 (15분)

포매터 자동 실행 Hook 하나만 추가해도 코드 품질이 눈에 띄게 개선됩니다.

### 4단계: MCP 서버 연결 (20분)

Context7 하나만 연결해도 라이브러리 문서 조회가 훈련 데이터에서 실시간 문서로 전환됩니다.

### 5단계: 반응적 확장

Claude가 실수할 때마다 CLAUDE.md에 규칙 한 줄을 추가합니다. 이것이 가장 효과적인 harness 성장 전략입니다.

---

## 마무리

Claude Code harness는 "AI를 더 잘 쓰기 위한 AI의 운영 환경"입니다. 핵심은 세 가지입니다.

1. **결정론적 강제**(Hooks)와 **자연어 가이드**(CLAUDE.md)를 구분하세요
2. **적게 시작하고 반응적으로 확장**하세요 (Mitchell Hashimoto 원칙)
3. **컨텍스트는 유한한 자원**입니다 -- 1M 토큰이라도 관리가 필요합니다

이 글에서 다룬 10개 영역의 상세 리서치 데이터는 각각 별도의 리서치 파일로 제공됩니다. 더 깊이 파고들고 싶은 영역이 있다면, 해당 리서치를 참고하세요.
