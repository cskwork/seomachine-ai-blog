---
title: "CLAUDE.md 작성법: AI에게 프로젝트를 이해시키는 기술"
date: 2026-03-17
draft: false
tags: ["Claude Code", "CLAUDE.md", "프로젝트 설정", "컨텍스트"]
categories: ["Claude Code"]
description: "효과적인 CLAUDE.md 작성법을 실전 템플릿과 함께 설명합니다. 좋은 예시와 나쁜 예시 비교, 프로젝트 유형별 템플릿을 제공합니다."
summary: "CLAUDE.md 하나로 Claude Code의 코드 품질이 달라집니다. 작성 원칙과 실전 템플릿을 공유합니다."
difficulty: "중급"
ShowToc: true
TocOpen: true
---

## CLAUDE.md가 중요한 이유

Claude Code를 처음 사용하다 보면 비슷한 상황을 반복적으로 경험하게 된다. 새 대화를 시작할 때마다 "이 프로젝트는 TypeScript를 쓰고, 테스트는 Jest로 작성하며, 에러 처리는 커스텀 AppError 클래스를 통해서만 해야 합니다"라고 설명하는 것이다. 대화가 길어져 컨텍스트가 초기화될 때도 마찬가지다. 같은 내용을 계속 반복해서 입력하는 것은 시간 낭비이며, 빠뜨린 내용이 있으면 Claude가 프로젝트 규칙에 어긋나는 코드를 생성하기도 한다.

CLAUDE.md는 이 문제를 근본적으로 해결하는 파일이다. Claude Code가 어떤 프로젝트 디렉토리를 열면 가장 먼저 읽는 파일이 바로 이것이다. 여기에 프로젝트의 핵심 정보, 규칙, 컨벤션을 잘 정리해두면 Claude는 매번 새 대화를 시작할 때마다 그 내용을 자동으로 참조한다.

이것을 비유로 설명하면, 신입 개발자에게 온보딩 문서를 건네주는 것과 같다. 경험 많은 팀에서는 새로운 팀원이 합류했을 때 "이 프로젝트에서 쓰는 패턴은 이렇고, 이 파일은 절대 건드리지 말고, 빌드는 이렇게 하면 됩니다"라는 문서를 미리 준비해둔다. CLAUDE.md가 바로 그 역할을 한다. 잘 작성된 문서를 받은 개발자가 첫날부터 팀 규칙에 맞는 코드를 작성하듯, CLAUDE.md를 잘 작성해두면 Claude도 처음부터 프로젝트 컨텍스트에 맞는 코드를 생성한다.

CLAUDE.md가 없거나 부실하게 작성되어 있으면 어떻게 될까. Claude는 범용적인 코드를 생성한다. 일반적으로 널리 쓰이는 패턴을 따르지만, 프로젝트 고유의 규칙은 알 수 없다. 어느 파일에서는 async/await를 쓰고 다른 파일에서는 프로미스 체이닝을 쓰는 식으로 일관성이 무너지기 쉽다. 그 결과 코드 리뷰와 수정 작업이 늘어나고, 결국 AI를 쓰는 효율이 오히려 떨어지게 된다.

---

## 효과적인 CLAUDE.md 구조

좋은 CLAUDE.md는 크게 다섯 가지 요소를 담는다. 각 요소가 무엇을 담아야 하는지, 그리고 왜 그것이 중요한지 살펴보자.

### Project Overview

가장 먼저 오는 것은 프로젝트 한 줄 요약이다. "이 프로젝트는 무엇인가"에 대한 답을 한두 문장으로 명확히 써야 한다. 그 다음에 기술 스택을 나열한다.

중요한 것은 구체성이다. "React 앱"이라고 쓰는 것과 "Next.js 14 App Router 기반 전자상거래 프론트엔드. TypeScript, Tailwind CSS, Zustand 상태 관리"라고 쓰는 것은 Claude가 생성하는 코드의 품질에서 큰 차이를 만든다. 버전 정보도 중요하다. Next.js 13과 14는 라우팅 방식이 다르고, React 17과 18은 동시성 기능 차이가 있다. Claude는 버전별 API 차이를 알고 있으므로 정확한 버전을 명시해줄수록 적합한 코드를 생성한다.

### 아키텍처 설명

프로젝트 디렉토리 구조와 각 디렉토리의 역할을 설명한다. 모든 디렉토리를 나열할 필요는 없다. 핵심 디렉토리만 짚으면 된다. 여기서 중요한 것은 역할 경계를 명확히 하는 것이다. 예를 들어 "비즈니스 로직은 services/ 계층에서만 다룬다", "데이터베이스 쿼리는 반드시 repositories/ 계층을 통해서만 실행한다"와 같이 계층 간 책임을 명확히 기술하면 Claude가 새 기능을 추가할 때 올바른 위치에 코드를 생성한다.

데이터 흐름도 간략히 기술하면 도움이 된다. "요청이 들어오면 route 핸들러가 받아 service를 호출하고, service는 repository를 통해 데이터를 가져온다"는 식으로 흐름을 적어두면 Claude가 새 엔드포인트를 만들 때 이 패턴을 따르게 된다.

### 코딩 컨벤션

이 섹션이 CLAUDE.md에서 가장 가치 있는 부분이다. 팀마다, 프로젝트마다 고유한 컨벤션이 있다. 네이밍 규칙, 파일 구조, 에러 처리 방식, API 응답 형태 같은 것들이다. 이것을 명시적으로 적지 않으면 Claude는 일반적인 관행을 따르는데, 그것이 이 프로젝트의 기존 코드와 다를 수 있다.

"이 프로젝트에서는 X 패턴을 사용한다"는 형태로 쓰는 것이 효과적이다. 예를 들면 이렇다.

- 모든 API 응답은 `{ success: boolean, data: T | null, error: string | null }` 형태를 따른다
- 커스텀 에러는 반드시 `AppError` 클래스를 상속해 생성한다
- 컴포넌트 파일명은 PascalCase, 유틸리티 함수 파일명은 camelCase
- CSS 클래스는 Tailwind만 사용하고, 별도 CSS 파일 생성 금지

이런 규칙이 명시되어 있으면 Claude는 기존 코드와 일관성 있는 코드를 생성한다.

### 빌드/테스트/린트 명령

이 부분은 간단하지만 매우 중요하다. 정확한 명령어를 그대로 적어야 한다. "테스트 실행"이라고 쓰지 말고 `npm test` 또는 `pytest tests/ -v`처럼 실제로 터미널에서 실행하는 명령을 그대로 기재한다.

CI 파이프라인에서 사용하는 명령과 동일하게 맞추는 것이 좋다. Claude가 코드를 작성한 후 "테스트를 실행해보겠습니다"라고 할 때 여기 적힌 명령을 사용하기 때문이다. 명령이 잘못되어 있으면 Claude가 스스로 검증하는 과정에서 오류가 생긴다.

### 주의사항

절대로 해서는 안 되는 것들을 명시한다. 이 섹션은 작성하기 어색할 수 있지만, 실제로 사고를 예방하는 데 큰 역할을 한다. 예를 들면 다음과 같은 것들이다.

- `.env` 파일은 절대 커밋하지 않는다
- `database/migrations/` 디렉토리의 파일은 직접 수정하지 않는다 (마이그레이션 파일 새로 생성)
- `src/generated/` 디렉토리는 자동 생성 파일이므로 직접 편집하지 않는다
- 프로덕션 데이터베이스에 직접 연결하는 코드를 작성하지 않는다

Claude는 이런 제약 조건을 모르면 선의로 "도움이 되는" 코드를 생성하다가 실수를 유발할 수 있다. 명확히 금지 사항을 적어두면 그런 위험을 예방한다.

---

## 계층 구조

CLAUDE.md는 한 곳에만 두는 파일이 아니다. 여러 레벨에 걸쳐 계층 구조를 이루며, 하위 파일이 상위 파일을 오버라이드한다.

**글로벌 설정** (`~/.claude/CLAUDE.md`)은 모든 프로젝트에 공통으로 적용된다. 개인 선호 설정, 항상 사용하는 도구, 평소 코딩 스타일 같은 것을 여기에 담는다. 예를 들어 "나는 항상 TypeScript를 선호하며, 함수형 프로그래밍 스타일을 즐겨 사용한다"는 내용이나, 모든 프로젝트에서 지키는 보안 규칙 등이 해당된다.

**프로젝트 루트** (`프로젝트명/CLAUDE.md`)는 해당 프로젝트에만 적용된다. 프로젝트 고유의 아키텍처, 컨벤션, 빌드 명령이 여기에 들어간다. 대부분의 내용은 이 파일에 담기게 된다.

**하위 디렉토리** (`src/api/CLAUDE.md` 등)는 특정 모듈이나 패키지에만 적용되는 규칙을 담는다. 모노레포 구조나 마이크로프론트엔드처럼 하나의 레포에 성격이 다른 여러 모듈이 공존할 때 특히 유용하다. 예를 들어 `packages/admin/CLAUDE.md`에는 어드민 패널에만 해당하는 컴포넌트 구조나 권한 관련 규칙을 담을 수 있다.

우선순위는 가장 가까운 파일이 높다. 글로벌 설정에 "TypeScript를 선호한다"고 되어 있어도, 프로젝트 루트에 "이 프로젝트는 Python으로만 작성한다"고 되어 있으면 Python을 따른다.

---

## 좋은 예시 vs 나쁜 예시

실제 코드만큼 예시가 잘 보여주는 것은 없다. 나쁜 예시와 좋은 예시를 직접 비교해보자.

### 나쁜 예시

```markdown
# My Project
이 프로젝트는 React 앱입니다.
TypeScript를 사용합니다.
```

이것이 왜 나쁜가. 정보가 너무 추상적이다. "React 앱"이라는 정보는 Claude가 이미 파일을 보면 알 수 있는 것이다. 버전 정보가 없고, 어떤 라우터를 쓰는지, 상태 관리는 어떻게 하는지, 테스트는 어떻게 실행하는지 아무런 정보가 없다. 이 CLAUDE.md를 읽은 후에도 Claude는 범용적인 코드를 생성할 수밖에 없다.

### 좋은 예시

```markdown
# E-Commerce API

Express.js + TypeScript REST API. PostgreSQL + Prisma ORM.
Node.js 20, Express 4.18, Prisma 5.x.

## 빌드/테스트
- Build: `npm run build`
- Test: `npm test` (Jest, 80%+ coverage required)
- Lint: `npm run lint` (ESLint + Prettier)
- Type check: `npm run typecheck`

## 아키텍처
- `src/routes/` - API 엔드포인트 라우터 (RESTful)
- `src/services/` - 비즈니스 로직 (여기서만 처리)
- `src/repositories/` - 데이터 접근 계층 (Prisma 쿼리는 여기서만)
- `src/middleware/` - 인증, 에러 핸들링, 요청 검증
- `src/types/` - 공유 TypeScript 타입 정의

## 규칙
- 모든 API 응답은 `{ success: boolean, data: T | null, error: string | null }` 형태
- 에러는 반드시 `AppError` 클래스를 상속해 throw
- DB 쿼리는 반드시 repository 계층에서만 실행
- 컨트롤러(route 핸들러)에 비즈니스 로직 작성 금지

## 주의사항
- .env 파일 절대 커밋 금지
- `prisma/migrations/` 파일 직접 수정 금지 (마이그레이션 재생성)
- `src/generated/` 자동 생성 파일 편집 금지
```

차이가 분명하다. 버전이 명시되어 있고, 정확한 명령어가 있으며, 각 디렉토리의 역할 경계가 명확하다. Claude는 이 파일을 읽고 나면 "DB 쿼리는 repository에서만" 같은 규칙을 실제로 따르는 코드를 생성한다.

---

## 실전 템플릿 3가지

### 1. 프론트엔드 (Next.js)

```markdown
# [프로젝트명] Frontend

Next.js 14 App Router + TypeScript + Tailwind CSS.
상태 관리: Zustand. 데이터 페칭: TanStack Query v5.

## 명령
- Dev: `npm run dev`
- Build: `npm run build`
- Test: `npm test` (Vitest + Testing Library)
- Lint: `npm run lint`

## 디렉토리
- `app/` - Next.js App Router 페이지 및 레이아웃
- `components/` - 재사용 가능한 UI 컴포넌트
- `components/ui/` - 기본 UI 원자 컴포넌트 (Button, Input 등)
- `lib/` - 유틸리티, 헬퍼 함수
- `store/` - Zustand 스토어 정의
- `hooks/` - 커스텀 React 훅

## 컨벤션
- 컴포넌트: 함수형 컴포넌트 + 화살표 함수
- 파일명: PascalCase (컴포넌트), camelCase (유틸)
- CSS: Tailwind 클래스만 사용, 별도 CSS 파일 금지
- 이미지: next/image 컴포넌트 필수 사용
- 링크: next/link 컴포넌트 필수 사용

## 주의사항
- `app/` 디렉토리의 Server Component에서는 브라우저 API 사용 금지
- 클라이언트 전용 코드는 파일 최상단에 'use client' 지시어 추가
- 환경변수: 클라이언트 노출 변수만 NEXT_PUBLIC_ 접두사 사용
```

### 2. 백엔드 API (FastAPI)

```markdown
# [프로젝트명] API

FastAPI + Python 3.11. PostgreSQL + SQLAlchemy 2.0 + Alembic.
인증: JWT (python-jose). 비동기: asyncio 전용.

## 명령
- Dev: `uvicorn app.main:app --reload`
- Test: `pytest tests/ -v --cov=app --cov-report=term`
- Lint: `ruff check . && mypy app/`
- Migration: `alembic upgrade head`

## 디렉토리
- `app/routers/` - API 라우터 (엔드포인트 정의)
- `app/services/` - 비즈니스 로직
- `app/repositories/` - 데이터 접근 (SQLAlchemy 쿼리)
- `app/schemas/` - Pydantic 요청/응답 스키마
- `app/models/` - SQLAlchemy ORM 모델
- `app/core/` - 설정, 보안, 의존성

## 컨벤션
- 모든 라우터 함수는 async
- 의존성 주입은 FastAPI Depends() 패턴 사용
- 응답 스키마는 반드시 response_model에 명시
- DB 세션은 항상 컨텍스트 매니저로 관리

## 주의사항
- alembic/versions/ 파일 직접 수정 금지
- .env 파일 커밋 금지 (settings.py는 pydantic-settings 사용)
- ORM 모델에 비즈니스 로직 작성 금지
```

### 3. 풀스택 (Next.js + Prisma)

```markdown
# [프로젝트명]

Next.js 14 풀스택 앱. App Router + API Routes.
DB: PostgreSQL + Prisma 5. 인증: NextAuth.js v5.

## 명령
- Dev: `npm run dev`
- Build: `npm run build`
- Test: `npm test` (Jest + Testing Library)
- E2E: `npm run test:e2e` (Playwright)
- DB migrate: `npx prisma migrate dev`
- DB studio: `npx prisma studio`

## 디렉토리
- `app/(auth)/` - 인증 관련 페이지
- `app/(dashboard)/` - 로그인 후 페이지
- `app/api/` - API 라우트
- `lib/actions/` - Server Actions (폼 처리)
- `lib/db/` - Prisma 클라이언트 + 쿼리 헬퍼
- `components/` - 공유 UI 컴포넌트
- `prisma/schema.prisma` - DB 스키마

## 컨벤션
- 데이터 변경: Server Actions 우선 사용 (API Route 대신)
- 데이터 조회: Server Component에서 직접 Prisma 쿼리
- 클라이언트 상태: React useState/useReducer (외부 라이브러리 최소화)
- 에러 처리: error.tsx + notFound() 패턴

## 주의사항
- prisma/migrations/ 직접 수정 금지
- NextAuth 세션에서 가져온 userId를 신뢰하고 추가 검증 없이 DB 쿼리 금지
- 클라이언트 컴포넌트에서 Prisma 직접 import 금지 (보안)
- NEXTAUTH_SECRET 환경변수 필수 (없으면 서버 시작 거부)
```

---

## 관련 글

CLAUDE.md는 Claude Code를 잘 활용하기 위한 기반 설정이다. 이것을 잘 갖춰두면 그 위에서 더 많은 것을 할 수 있다.

- [Claude Code 프로젝트 셋업](/posts/claude-code/claude-code-project-setup/): CLAUDE.md 외에 프로젝트를 처음 설정할 때 해야 할 것들을 다룬다. 디렉토리 구조 설계부터 초기 컨텍스트 구성까지.
- [Claude Code 컨텍스트 관리](/posts/claude-code/claude-code-context-management/): 긴 작업을 진행할 때 컨텍스트 창을 효율적으로 관리하는 방법. CLAUDE.md와 함께 사용하면 더 긴 작업도 일관성 있게 수행할 수 있다.
