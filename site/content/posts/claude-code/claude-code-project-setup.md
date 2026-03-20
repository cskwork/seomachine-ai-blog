---
title: "Claude Code로 첫 프로젝트 셋업하는 법: 규모별 최적 설정 가이드"
date: 2026-03-18
draft: false
tags: ["Claude Code", "프로젝트 설정", "CLAUDE.md", "settings.json"]
categories: ["Claude Code"]
description: "Claude Code 프로젝트 초기 설정 완벽 가이드. /init, CLAUDE.md, settings.json 설정법과 프로젝트 규모별 최적 구성을 다룹니다."
summary: "프로젝트 규모에 맞는 Claude Code 초기 설정 방법을 단계별로 안내합니다."
difficulty: "입문"
ShowToc: true
TocOpen: true
---

새 프로젝트를 시작할 때마다 개발 환경 설정에 상당한 시간을 쏟게 된다. Claude Code를 처음 도입하는 경우도 마찬가지다. 어디서부터 시작해야 할지, 어떤 파일을 만들어야 하는지, 프로젝트 규모에 따라 설정이 달라지는지 막막하게 느껴질 수 있다. 이 글에서는 Claude Code 프로젝트 초기 설정의 모든 것을 단계별로 설명한다.

## 프로젝트에서 Claude Code 시작하기

Claude Code를 프로젝트에 도입하는 방법은 단순하다. 터미널을 열고 프로젝트 루트 디렉토리로 이동한 뒤 `claude` 명령을 실행하면 된다.

```bash
cd /path/to/your-project
claude
```

첫 실행 순간부터 Claude Code는 현재 디렉토리를 적극적으로 파악하기 시작한다. Git 저장소라면 브랜치 정보, 최근 커밋 이력, 변경된 파일 목록을 자동으로 읽어들인다. 그리고 프로젝트 루트의 파일 구조를 훑어보며 어떤 종류의 프로젝트인지 추론한다. `package.json`이 있으면 Node.js 프로젝트로, `Cargo.toml`이 있으면 Rust 프로젝트로, `go.mod`가 있으면 Go 프로젝트로 인식하는 식이다.

이 자동 인식 과정은 Claude Code가 적절한 맥락 안에서 작동할 수 있도록 해준다. 별도의 설정 없이도 "현재 브랜치에서 변경된 파일이 뭐야?"라거나 "이 프로젝트의 진입점이 어디야?"와 같은 질문에 즉시 답할 수 있는 이유가 여기에 있다.

그러나 자동 인식에는 한계가 있다. 프로젝트 내부의 코딩 컨벤션, 빌드 명령, 테스트 실행 방법, 아키텍처 결정의 배경 같은 정보는 파일 구조만으로는 파악하기 어렵다. 이 정보를 Claude Code에게 전달하는 가장 효과적인 방법이 바로 `CLAUDE.md` 파일이다.

## /init으로 CLAUDE.md 자동 생성

CLAUDE.md를 처음부터 직접 작성하는 것은 번거롭다. Claude Code는 이 문제를 해결하기 위해 `/init` 명령을 제공한다.

```
> /init
```

이 명령을 실행하면 Claude Code가 프로젝트를 분석하고 초안 CLAUDE.md를 자동으로 생성한다. 분석 대상은 디렉토리 구조, 설정 파일들, README, 주요 소스 파일들이다. 생성되는 CLAUDE.md의 기본 구조는 다음과 같다.

```markdown
# Project Name

## Build & Development Commands
- `npm run dev` - 개발 서버 실행
- `npm run build` - 프로덕션 빌드
- `npm test` - 테스트 실행
- `npm run lint` - 린트 검사

## Architecture Overview
프로젝트 구조와 각 디렉토리의 역할 설명...

## Coding Conventions
코드 스타일, 네이밍 컨벤션, 파일 구성 원칙...

## Key Files and Directories
- `src/` - 소스 코드
- `tests/` - 테스트 파일
- `docs/` - 문서
```

자동 생성된 파일은 완성본이 아니다. 반드시 사람이 검토하고 수정해야 하는 부분이 있다. 특히 세 가지 영역에 주의를 기울여야 한다.

첫째, 빌드 및 테스트 명령이다. Claude Code가 추론한 명령이 실제와 다를 수 있다. 프로젝트에서 실제로 사용하는 명령을 정확히 기재해야 Claude Code가 빌드 오류나 테스트 실패를 만났을 때 올바르게 대응할 수 있다.

둘째, 코딩 컨벤션이다. 팀에서 합의한 스타일 가이드, 금지된 패턴, 선호하는 라이브러리 같은 정보는 자동 분석으로는 파악할 수 없다. 이 내용을 명시적으로 추가해야 Claude Code가 컨벤션을 벗어난 코드를 생성하지 않는다.

셋째, 아키텍처 결정의 배경이다. 왜 특정 패턴을 사용하는지, 왜 특정 라이브러리를 선택했는지 같은 맥락 정보는 Claude Code가 더 적절한 제안을 하도록 돕는다.

## .claude/ 디렉토리 구조 이해

프로젝트 루트에 `.claude/` 디렉토리를 만들면 프로젝트 전용 Claude Code 설정을 관리할 수 있다. 이 디렉토리 안에는 세 가지 주요 구성 요소가 들어간다.

### settings.json

프로젝트별 동작 설정을 담는 파일이다.

```json
{
  "allowedTools": [
    "Bash",
    "Read",
    "Write",
    "Edit",
    "Grep",
    "Glob"
  ],
  "mcpServers": {
    "postgres": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-postgres"],
      "env": {
        "POSTGRES_CONNECTION_STRING": "${POSTGRES_URL}"
      }
    }
  }
}
```

`allowedTools`는 Claude Code가 사용할 수 있는 도구 목록을 제한한다. 보안이 중요한 프로젝트에서는 이 목록을 최소화하는 것이 좋다. `mcpServers`는 MCP(Model Context Protocol) 서버 설정으로, 데이터베이스나 외부 서비스와의 연동을 정의한다.

### commands/ 디렉토리

프로젝트에서 반복적으로 사용하는 작업을 슬래시 커맨드로 등록할 수 있다. 각 `.md` 파일이 하나의 커맨드가 된다.

```
.claude/
  commands/
    deploy.md
    review.md
    migrate.md
```

예를 들어 `deploy.md` 파일에 배포 절차를 적어두면, 대화창에서 `/deploy`를 입력하는 것만으로 해당 절차를 수행할 수 있다. 팀 전체가 동일한 커맨드를 공유하기 때문에 프로세스 일관성을 확보하는 데 유용하다.

### agents/ 디렉토리

특화된 작업을 위한 커스텀 에이전트를 정의하는 공간이다. 에이전트는 특정 역할(예: 보안 검토, 성능 분석)에 맞게 시스템 프롬프트와 도구 세트가 구성된 독립적인 Claude 인스턴스다.

### 글로벌 설정 vs 프로젝트 설정

Claude Code의 설정은 두 계층으로 나뉜다. 홈 디렉토리의 `~/.claude/`는 모든 프로젝트에 적용되는 글로벌 설정이고, 프로젝트 루트의 `.claude/`는 해당 프로젝트에만 적용된다. 충돌이 발생할 경우 프로젝트 설정이 글로벌 설정보다 우선된다. 개인 개발 환경의 기본값은 글로벌 설정에, 프로젝트 고유의 요구사항은 프로젝트 설정에 두는 것이 일반적인 관례다.

## 컨텍스트 범위 제어

Claude Code에는 `.gitignore`처럼 파일을 제외하는 별도 설정 파일이 없다. 대신 Claude가 불필요한 파일에 시간을 쏟지 않도록 유도하는 전략이 있다.

첫째, CLAUDE.md에 핵심 디렉토리를 명시한다. Claude가 어디를 봐야 하는지 안내하면 관련 없는 디렉토리를 탐색하는 시간이 줄어든다.

```markdown
## Key Directories
- `src/` - 핵심 소스 코드 (여기에 집중)
- `tests/` - 테스트 파일
- `docs/` - 문서

## 무시해도 되는 디렉토리
- `node_modules/`, `dist/`, `build/` - 빌드 산출물
- `data/raw/` - 대용량 데이터 (분석 불필요)
```

둘째, 대화 중 검색이나 탐색을 요청할 때 범위를 명시한다. "전체 프로젝트에서 검색해줘"보다 "src/ 안에서 검색해줘"가 더 빠르고 정확하다.

셋째, `settings.json`의 `allowedTools` 설정으로 Claude가 사용할 수 있는 도구의 범위를 조절할 수 있다. 보안이 중요한 프로젝트에서는 특정 명령만 허용하여 민감한 파일에 대한 접근을 제한한다.

## 실무 인사이트: 프로젝트 규모별 최적 설정

설정의 복잡도는 프로젝트 규모에 비례해야 한다. 과도한 설정은 유지 보수 부담만 늘릴 뿐이고, 부족한 설정은 Claude Code의 효과를 반감시킨다.

### 소규모 프로젝트 (파일 수십 개)

개인 사이드 프로젝트나 소규모 유틸리티 프로젝트에서는 최소한의 설정으로도 충분하다. CLAUDE.md는 20~30줄 이내로 유지하고, 핵심 명령과 가장 중요한 컨벤션만 기재한다.

```markdown
# My Tool

## Commands
- `npm run dev` - 개발 서버
- `npm test` - 테스트
- `npm run build` - 빌드

## Stack
- Node.js 20, TypeScript 5, Vitest

## Key Convention
- 함수형 스타일 선호, 클래스 사용 최소화
- 에러는 Result 타입으로 처리
```

Claude Code가 읽어야 할 파일이 많지 않기 때문에 컨텍스트 오염 위험이 낮다.

### 중규모 프로젝트 (파일 수백 개)

팀 단위로 개발하는 서비스 프로젝트에서는 CLAUDE.md의 역할이 훨씬 중요해진다. 새 팀원이 프로젝트를 이해하는 용도로도 활용할 수 있도록 아키텍처 개요를 충분히 담아야 한다.

```markdown
# Service Name

## Architecture
- Frontend: React 18 + Vite (src/frontend/)
- Backend: Fastify + Prisma (src/backend/)
- 공유 타입: packages/shared/

## Commands
- `pnpm dev` - 전체 개발 서버 (frontend + backend 동시)
- `pnpm test` - 전체 테스트
- `pnpm test:unit` - 단위 테스트만
- `pnpm test:e2e` - E2E 테스트 (Playwright)
- `pnpm build` - 프로덕션 빌드

## Key Directories
- `src/backend/routes/` - API 엔드포인트
- `src/backend/services/` - 비즈니스 로직
- `src/backend/repositories/` - 데이터 접근 레이어
- `src/frontend/components/` - UI 컴포넌트
- `src/frontend/hooks/` - 커스텀 훅

## Coding Conventions
- Repository 패턴 엄수: 비즈니스 로직은 services/에만
- API 응답은 반드시 { success, data, error } 형태
- 컴포넌트는 200줄 미만으로 유지
- 테스트 커버리지 80% 이상 유지
```

이 규모에서는 CLAUDE.md에 핵심 디렉토리와 무시해도 되는 디렉토리를 명시하는 것이 중요하다. Claude Code가 관련 없는 파일을 읽느라 컨텍스트를 낭비하는 것을 방지할 수 있다.

### 대규모 모노레포

수십 개의 패키지가 하나의 저장소에 공존하는 모노레포에서는 단일 CLAUDE.md만으로는 효과적인 안내가 어렵다. 핵심 전략은 컨텍스트 분산이다.

루트의 CLAUDE.md에는 전체 저장소의 구조와 공통 규칙만 담는다. 각 패키지 디렉토리에는 해당 패키지에 특화된 CLAUDE.md를 별도로 작성한다.

```
monorepo/
  CLAUDE.md              # 전체 구조, 공통 명령
  packages/
    api/
      CLAUDE.md          # API 패키지 전용 설정
    web/
      CLAUDE.md          # 웹 패키지 전용 설정
    shared/
      CLAUDE.md          # 공유 라이브러리 설정
```

모노레포에서 Claude Code를 사용할 때는 작업할 패키지를 명시적으로 지정하는 습관이 중요하다. "전체 저장소에서 버그 찾아줘"보다 "packages/api에서 인증 관련 버그 찾아줘"처럼 범위를 좁혀서 요청해야 한다.

CLAUDE.md에 작업 범위를 명시하는 것도 효과적이다. "현재 작업 대상은 packages/api이고, packages/shared도 참조할 수 있다"처럼 안내하면 Claude가 관련 없는 패키지를 탐색하지 않는다.

---

초기 설정에 투자하는 시간은 반드시 회수된다. CLAUDE.md를 잘 작성해두면 매번 같은 컨텍스트를 반복해서 설명하지 않아도 되고, 핵심 디렉토리를 명시하면 Claude Code가 중요한 파일에 집중할 수 있다. 프로젝트가 성장함에 따라 이 설정 파일들도 함께 발전시켜 나가는 것이 장기적으로 가장 효율적인 접근 방식이다.

## 관련 글

- [CLAUDE.md 작성법 심화](/posts/claude-code/claude-code-claude-md-guide/) - CLAUDE.md를 효과적으로 작성하는 고급 기법과 실전 예제
- [Claude Code 시작하기](/posts/claude-code/claude-code-getting-started/) - Claude Code의 기본 개념과 설치, 첫 사용 방법
