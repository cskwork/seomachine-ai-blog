# M002: 블로그 전체 한국어 품질 개선

**Vision:** AI Insights Lab 블로그 28개 전체 포스트를 "실력 있는 선배가 설명하는" 통일 톤으로 리라이트. 어색한 한국어, 문법 오류, 기계적 AI 문체를 교정하고, 인기 네이버 블로그 수준의 독자 참여형 구조로 전면 재구성.

## Success Criteria

- 28개 글 전체가 통일된 톤으로 자연스러운 한국어로 읽힌다
- 아무 글이나 3개를 랜덤으로 열어서 톤/구조가 일관된다
- 도입부가 흥미를 유발하고 결론이 행동을 유도한다
- 코드 블록, API 예시, 수치 데이터가 원본과 동일하다
- brand-voice.md, style-guide.md가 새 기준을 반영한다

## Key Risks / Unknowns

- 톤 정의의 모호성 — 파일럿 없이 28개를 바로 리라이트하면 중간에 톤이 표류할 수 있음
- study-motivation 글 품질 유지 — 이미 서사 품질이 높아 톤 통일 시 강점 희석 위험

## Proof Strategy

- 톤 정의의 모호성 → retire in S01 by proving 3개 파일럿 글이 명확한 톤 기준을 확립
- study-motivation 품질 유지 → retire in S05 by proving 톤 통일 후에도 서사 강점 보존

## Verification Classes

- Contract verification: 각 글의 frontmatter 유효성, 코드 블록 보존, 파일 존재 확인
- Integration verification: brand-voice.md와 실제 글 톤의 정합성
- Operational verification: none
- UAT / human verification: 랜덤 3개 글 읽기 테스트

## Milestone Definition of Done

This milestone is complete only when all are true:

- 28개 글 전체가 새 톤으로 리라이트됨
- frontmatter title, description이 새 톤에 맞게 수정됨
- brand-voice.md, style-guide.md가 새 기준 반영
- 전체 글 톤/구조 일관성 QA 통과
- 코드 블록/기술 정보 정확성 보존 확인

## Requirement Coverage

- Covers: R012, R013, R014, R015, R016, R017, R018
- Partially covers: R004 (frontmatter 형식 유지), R005 (브랜드 보이스 재정의)
- Leaves for later: none
- Orphan risks: none

## Slices

- [x] **S01: 톤 가이드 수립 + 3 파일럿 리라이트** `risk:high` `depends:[]`
  > After this: 톤 가이드 문서 완성 + 3개 대표 글(기술해설/비교분석/튜토리얼)이 새 톤으로 리라이트됨. brand-voice.md, style-guide.md 업데이트 완료.

- [ ] **S02: Claude Code 시리즈 리라이트 (9개)** `risk:low` `depends:[S01]`
  > After this: Claude Code 시리즈 9개 글(getting-started, essential-commands, project-setup, claude-md-guide, context-management, custom-commands, hooks-automation, mcp-servers, tdd-workflow)이 통일 톤으로 리라이트됨.

- [ ] **S03: AI 기술 해설 리라이트 (6개)** `risk:low` `depends:[S01]`
  > After this: AI 기술 해설 6개 글(multi-agent, mcp-introduction, rag-pipeline, prompt-engineering, llm-cost-optimization, ai-code-review)이 통일 톤으로 리라이트됨.

- [ ] **S04: 비교/전략/디자인/특수글 리라이트 (8개)** `risk:medium` `depends:[S01]`
  > After this: 비교분석 2개(fine-tuning-vs-rag, langchain-vs-llamaindex), 전략/가이드 2개(ai-seo-content-strategy, ai-hack-camp), 디자인 3개(designers, claude-code-reshaping, figma-mcp-playbook, claude-code-to-figma), 멀티에이전트(multi-agent-architecture — S03과 분류 조정 가능) 등 8개 글이 통일 톤으로 리라이트됨.

- [ ] **S05: study-motivation 보정 + 전체 QA** `risk:low` `depends:[S02,S03,S04]`
  > After this: study-motivation 글이 톤 통일되면서 서사 강점 보존. 28개 전체 글의 톤/구조 일관성 최종 검증 완료.

## Boundary Map

### S01 → S02, S03, S04, S05

Produces:
- `context/brand-voice.md` — 새 톤 기준 정의 (톤 원칙, 금지 표현, 구조 패턴)
- `context/style-guide.md` — 새 문체 기준 (문장 길이, 전환 패턴, 도입부/결론 패턴)
- 3개 파일럿 리라이트 — 톤의 구체적 레퍼런스
  - `ai-agent-trends-2026.md` (기술 해설 레퍼런스)
  - `claude-vs-gpt-comparison.md` (비교 분석 레퍼런스)
  - `claude-code-getting-started.md` (튜토리얼 레퍼런스)

Consumes: nothing (first slice)

### S02 → S05

Produces:
- Claude Code 시리즈 9개 글 리라이트 완료
  - `claude-code-essential-commands.md`
  - `claude-code-project-setup.md`
  - `claude-code-claude-md-guide.md`
  - `claude-code-context-management.md`
  - `claude-code-custom-commands.md`
  - `claude-code-hooks-automation.md`
  - `claude-code-mcp-servers.md`
  - `claude-code-multi-agent.md`
  - `claude-code-tdd-workflow.md`

Consumes from S01:
- brand-voice.md 톤 기준
- style-guide.md 문체 기준
- `claude-code-getting-started.md` 파일럿 → 시리즈 내 톤 기준점

### S03 → S05

Produces:
- AI 기술 해설 6개 글 리라이트 완료
  - `multi-agent-architecture.md`
  - `mcp-introduction.md`
  - `rag-pipeline-design.md`
  - `prompt-engineering-practical-guide.md`
  - `llm-cost-optimization.md`
  - `ai-code-review-automation.md`

Consumes from S01:
- brand-voice.md 톤 기준
- style-guide.md 문체 기준
- `ai-agent-trends-2026.md` 파일럿 → 기술 해설 톤 기준점

### S04 → S05

Produces:
- 비교/전략/디자인/특수글 8개 리라이트 완료
  - `fine-tuning-vs-rag.md`
  - `langchain-vs-llamaindex.md`
  - `ai-seo-content-strategy.md`
  - `ai-hack-camp-2026-application-guide.md`
  - `designers-most-underrated-in-tech.md`
  - `claude-code-reshaping-design-process.md`
  - `figma-mcp-claude-code-designer-playbook.md`
  - `claude-code-to-figma-code-to-canvas.md`

Consumes from S01:
- brand-voice.md 톤 기준
- style-guide.md 문체 기준
- `claude-vs-gpt-comparison.md` 파일럿 → 비교 분석 톤 기준점

### S05

Produces:
- `study-motivation-scientific-methods.md` 톤 보정
- 28개 전체 글 톤/구조 일관성 QA 보고서

Consumes from S02, S03, S04:
- 리라이트된 26개 글 (파일럿 3개 + 시리즈 9개 + 해설 6개 + 특수 8개)
- S01의 톤 기준 문서
