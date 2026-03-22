---
title: "Claude Code로 TDD 워크플로우 구축하기: AI와 함께하는 테스트 주도 개발"
date: 2026-03-15
draft: false
tags: ["Claude Code", "TDD", "테스트", "Jest", "워크플로우"]
categories: ["Claude Code"]
description: "Claude Code와 TDD를 결합한 개발 워크플로우. Red-Green-Refactor 사이클을 AI와 함께 실습하며, 흔한 함정과 해결법을 다룹니다."
summary: "Claude Code로 TDD를 실천하는 구체적인 방법과, AI와 TDD를 할 때 주의해야 할 함정을 다룹니다."
difficulty: "중급"
ShowToc: true
TocOpen: true
---

테스트 주도 개발(TDD)은 대부분의 개발자가 필요성은 알면서도 실제로 적용하기 어려워하는 방법론이다. 테스트를 먼저 작성한다는 원칙은 단순하지만, 막상 빈 파일 앞에 앉으면 구현부터 손이 간다. Claude Code를 쓰면서 이 습관이 바뀌었다. AI가 테스트 작성의 마찰을 낮춰주면서 Red-Green-Refactor 사이클을 자연스럽게 지킬 수 있게 됐다.

이 글에서는 Express API를 TDD로 구현하는 전 과정을 실제 대화 흐름과 함께 보여주고, AI와 TDD를 병행할 때 주의해야 할 세 가지 함정을 다룬다.

## Claude Code와 TDD가 잘 맞는 이유

TDD의 핵심은 사이클이다. 테스트 작성, 실패 확인, 구현, 통과 확인, 리팩토링. 이 사이클을 유지하려면 파일 편집, 터미널 실행, 오류 해석을 빠르게 반복해야 한다. Claude Code는 이 모든 작업을 한 세션에서 처리한다.

구체적으로 어떤 점이 다른가:

**테스트 작성의 장벽이 낮아진다.** 기존 TDD의 가장 큰 장애물은 "테스트를 먼저 작성하기 귀찮다"는 심리적 저항이다. Claude Code에게 "이 기능의 테스트를 먼저 작성해줘"라고 지시하면 describe 블록, it 블록, 모킹 설정까지 갖춘 테스트 파일이 생성된다. 직접 작성하는 것보다 10배 빠르다.

**에러 메시지를 즉시 해석한다.** 테스트 실행 후 나오는 스택 트레이스를 복사해 설명을 요청하면 어느 부분이 왜 실패했는지 명확히 짚어준다. 에러 메시지 해석에 쓰는 시간이 사라진다.

**파일 간 맥락을 유지한다.** 테스트 파일을 보면서 구현 파일을 작성하고, 타입 정의를 참조하면서 모킹 코드를 조정하는 작업이 하나의 흐름으로 이어진다. 여러 파일을 오가며 복사 붙여넣기하는 번거로움이 없다.

**리팩토링 단계에서 적극적으로 제안한다.** 테스트가 통과된 상태에서 "리팩토링할 부분이 있으면 제안해줘"라고 물으면 중복 코드, 함수 분리 기회, 네이밍 개선점을 목록으로 제시한다.

## 실습: Express API 엔드포인트를 TDD로 구현

사용자 등록 엔드포인트(`POST /api/users`)를 TDD로 구현하는 과정을 단계별로 따라가 보자.

### Step 1: RED - 테스트 먼저 작성

먼저 요구사항을 명확히 정의하고 테스트 작성을 요청한다.

**사용자 입력:**
```
POST /api/users 엔드포인트의 Jest 테스트를 먼저 작성해줘.
이메일 유효성 검사, 중복 체크, 성공 응답을 테스트해야 해.
아직 구현은 하지 말고 테스트 파일만 만들어줘.
```

Claude Code가 생성하는 테스트 파일(`__tests__/users.test.ts`):

```typescript
import request from 'supertest';
import { app } from '../src/app';
import { db } from '../src/db';

describe('POST /api/users', () => {
  beforeEach(async () => {
    await db('users').truncate();
  });

  afterAll(async () => {
    await db.destroy();
  });

  describe('이메일 유효성 검사', () => {
    it('이메일 형식이 아닌 경우 400을 반환해야 한다', async () => {
      const res = await request(app)
        .post('/api/users')
        .send({ email: 'not-an-email', password: 'Password1!' });

      expect(res.status).toBe(400);
      expect(res.body).toMatchObject({
        error: '유효하지 않은 이메일 형식입니다.',
      });
    });

    it('이메일이 없는 경우 400을 반환해야 한다', async () => {
      const res = await request(app)
        .post('/api/users')
        .send({ password: 'Password1!' });

      expect(res.status).toBe(400);
      expect(res.body).toMatchObject({
        error: '이메일은 필수 항목입니다.',
      });
    });
  });

  describe('중복 이메일 처리', () => {
    it('이미 존재하는 이메일이면 409를 반환해야 한다', async () => {
      await db('users').insert({
        email: 'existing@example.com',
        password_hash: 'hashed',
      });

      const res = await request(app)
        .post('/api/users')
        .send({ email: 'existing@example.com', password: 'Password1!' });

      expect(res.status).toBe(409);
      expect(res.body).toMatchObject({
        error: '이미 사용 중인 이메일입니다.',
      });
    });
  });

  describe('성공 케이스', () => {
    it('유효한 요청이면 201과 생성된 사용자 정보를 반환해야 한다', async () => {
      const res = await request(app)
        .post('/api/users')
        .send({ email: 'new@example.com', password: 'Password1!' });

      expect(res.status).toBe(201);
      expect(res.body).toMatchObject({
        id: expect.any(Number),
        email: 'new@example.com',
      });
      expect(res.body).not.toHaveProperty('password_hash');
    });
  });
});
```

### Step 2: RED 확인

테스트를 실행해 실패를 확인한다. 이 단계를 건너뛰면 안 된다. 테스트가 처음부터 통과한다면 테스트 자체가 잘못 작성된 것이다.

**사용자 입력:**
```
테스트 실행해서 실패하는지 확인해줘.
```

```bash
npm test -- --testPathPattern=users
```

```
FAIL __tests__/users.test.ts
  POST /api/users
    이메일 유효성 검사
      x 이메일 형식이 아닌 경우 400을 반환해야 한다 (23ms)
      x 이메일이 없는 경우 400을 반환해야 한다 (5ms)
    중복 이메일 처리
      x 이미 존재하는 이메일이면 409를 반환해야 한다 (8ms)
    성공 케이스
      x 유효한 요청이면 201과 생성된 사용자 정보를 반환해야 한다 (6ms)

Tests: 4 failed, 4 total
```

4개 모두 실패. 예상된 결과다. 이제 구현을 시작할 준비가 됐다.

### Step 3: GREEN - 최소 구현

여기서 중요한 것은 "최소 구현"이다. 테스트를 통과하는 데 필요한 코드만 작성하고, 그 이상은 하지 않는다.

**사용자 입력:**
```
테스트를 통과하는 최소한의 구현 코드를 작성해줘.
과도한 추상화 없이 테스트 통과에 집중해줘.
```

생성되는 라우트 핸들러(`src/routes/users.ts`):

```typescript
import { Router, Request, Response } from 'express';
import { db } from '../db';
import bcrypt from 'bcrypt';

const router = Router();

const EMAIL_REGEX = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

router.post('/', async (req: Request, res: Response) => {
  const { email, password } = req.body;

  if (!email) {
    return res.status(400).json({ error: '이메일은 필수 항목입니다.' });
  }

  if (!EMAIL_REGEX.test(email)) {
    return res.status(400).json({ error: '유효하지 않은 이메일 형식입니다.' });
  }

  const existing = await db('users').where({ email }).first();
  if (existing) {
    return res.status(409).json({ error: '이미 사용 중인 이메일입니다.' });
  }

  const password_hash = await bcrypt.hash(password, 10);
  const [id] = await db('users').insert({ email, password_hash });

  return res.status(201).json({ id, email });
});

export default router;
```

### Step 4: GREEN 확인

**사용자 입력:**
```
테스트 다시 실행해줘.
```

```
PASS __tests__/users.test.ts
  POST /api/users
    이메일 유효성 검사
      v 이메일 형식이 아닌 경우 400을 반환해야 한다 (18ms)
      v 이메일이 없는 경우 400을 반환해야 한다 (4ms)
    중복 이메일 처리
      v 이미 존재하는 이메일이면 409를 반환해야 한다 (12ms)
    성공 케이스
      v 유효한 요청이면 201과 생성된 사용자 정보를 반환해야 한다(15ms)

Tests: 4 passed, 4 total
```

4개 모두 통과. 이제 리팩토링 단계로 넘어간다.

### Step 5: REFACTOR

테스트가 통과된 상태를 유지하면서 코드 품질을 개선한다. 리팩토링 후에도 테스트는 여전히 통과해야 한다.

**사용자 입력:**
```
리팩토링할 부분이 있으면 제안해줘.
테스트는 건드리지 말고 구현 코드만.
```

Claude Code의 제안:

- 이메일 유효성 검사 로직을 별도의 `validators/email.ts`로 분리
- 중복 체크와 사용자 생성 로직을 `repositories/UserRepository.ts`로 이동
- 에러 응답 형식을 전역 에러 핸들러 미들웨어로 통일
- `bcrypt.hash`의 saltRounds를 환경 변수로 외부화

리팩토링 후 `npm test`를 다시 실행해 4개 테스트가 여전히 통과하는지 확인한다. 이것이 테스트의 안전망 역할이다. 리팩토링이 기존 동작을 깨뜨렸는지 즉시 알 수 있다.

## CLAUDE.md에 TDD 규칙 설정하기

프로젝트 루트의 `CLAUDE.md`에 TDD 규칙을 명시해두면 Claude Code가 매 세션마다 이 규칙을 따른다. 한 번 설정해두면 "테스트 먼저 작성해줘"라고 매번 말할 필요가 없다.

```markdown
## 개발 규칙

### TDD 원칙
- 모든 새 기능은 TDD로 구현한다
- 테스트를 먼저 작성하고 실패를 확인한 후 구현 코드를 작성한다
- 구현 코드 작성 전 반드시 테스트 실행 결과(FAIL)를 보고받는다
- 테스트 커버리지 80% 이상을 유지한다

### 테스트 구조
- 테스트 파일은 `__tests__/` 디렉토리에 위치한다
- 테스트 파일명은 구현 파일명에 `.test.ts`를 붙인다
- 각 테스트는 단일 동작만 검증한다 (one assertion per test 권장)

### 금지 사항
- 테스트 없이 구현 코드를 작성하지 않는다
- 하드코딩으로 테스트를 통과시키지 않는다
- 구현이 잘못됐을 때 테스트를 수정하지 않는다
```

이 규칙이 있으면 Claude Code는 새 기능 구현 요청을 받았을 때 자동으로 테스트 파일 생성부터 시작한다.

## 실무 인사이트: AI와 TDD를 할 때의 3가지 함정

Claude Code와 TDD를 함께 쓰면서 반복적으로 마주치는 패턴이 있다. 미리 알아두면 시간을 절약할 수 있다.

### 함정 1: 하드코딩으로 테스트 통과

가장 자주 마주치는 문제다. 테스트에 구체적인 값이 있으면 AI가 그 값을 그대로 반환하는 코드를 작성해 테스트를 통과시키는 경우가 있다.

예를 들어 `it('1 + 1은 2여야 한다', () => expect(add(1, 1)).toBe(2))`라는 테스트에 `function add() { return 2; }`를 작성하는 식이다. 테스트는 통과하지만 `add(2, 3)`은 여전히 틀린 상태다.

**해결 방법:** 명시적으로 지시한다.

```
하드코딩으로 특정 테스트 케이스 값을 반환하지 말고,
실제 로직으로 구현해줘.
구현 후 내가 추가할 새 테스트 케이스도 통과할 수 있어야 해.
```

또는 테스트 작성 단계에서 경계값 테스트를 미리 포함시켜 하드코딩할 수 없게 만드는 것이 더 근본적인 해결책이다.

### 함정 2: 테스트 커버리지만 높이기

커버리지 수치는 높은데 실제로 중요한 케이스를 놓치는 경우다. "커버리지를 80%로 높여줘"라고만 요청하면 AI는 가장 쉽게 채울 수 있는 테스트를 추가한다. 그 결과 happy path만 촘촘히 테스트되고 엣지 케이스는 빠지게 된다.

**해결 방법:** 커버리지와 함께 엣지 케이스를 명시적으로 요청한다.

```
테스트를 추가할 때 다음 케이스도 포함해줘:
- 빈 문자열, null, undefined 입력
- 최댓값/최솟값 경계
- 네트워크 오류, 타임아웃 시나리오
- 동시 요청 처리
```

### 함정 3: 테스트를 구현에 맞추기

테스트가 실패했을 때 구현이 아니라 테스트를 수정하는 역방향 패턴이다. "테스트가 너무 엄격한 것 같은데 느슨하게 수정해줘"라는 요청은 TDD의 핵심 원칙을 위반한다.

이 함정은 주로 구현이 복잡해 테스트대로 구현하기 어려울 때 발생한다. AI는 사용자 요청을 따르므로, 요청 방식을 바꿔야 한다.

**해결 방법:** 프레임을 명확히 한다.

```
테스트가 명세다. 테스트가 맞고 구현이 틀린 것으로 가정하고,
구현 코드를 테스트에 맞게 수정해줘.
테스트 파일은 수정하지 않는다.
```

이 지시가 있으면 Claude Code는 테스트를 수정하지 않고 구현 방향을 재검토한다.

## 마무리

Claude Code와 TDD의 조합은 단순히 "AI가 테스트 코드를 대신 써주는 것"이 아니다. AI가 Red-Green-Refactor 사이클의 각 단계를 명확히 구분하게 도와주고, 테스트 작성의 심리적 장벽을 낮춰 TDD를 실제로 지속할 수 있게 만드는 것이다.

처음에는 "테스트 먼저 작성해줘", "실패 확인해줘", "최소 구현만 해줘", "리팩토링 제안해줘"를 매번 입력해야 하지만, `CLAUDE.md`에 규칙을 정의하면 이 흐름이 자동화된다. 일주일만 지속해보면 테스트 없이 구현 코드를 작성하는 것이 오히려 불안해지기 시작한다.

## 관련 글

- [Claude Code 필수 명령어](/posts/claude-code/claude-code-essential-commands/) - 자주 쓰는 명령어와 단축키 모음
- [Claude Code Hooks 자동화](/posts/claude-code/claude-code-hooks-automation/) - 테스트 자동 실행 훅 설정하기
- [Claude Code 프로젝트 설정](/posts/claude-code/claude-code-project-setup/) - CLAUDE.md와 초기 환경 구성
