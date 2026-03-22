# M001: 공부 동기부여 블로그 포스트 작성 및 최적화

**Vision:** 리서치 브리프 기반으로 뇌과학/심리학 연구 데이터를 인용한 SEO 최적화 한국어 블로그 포스트를 작성하고, 품질 검증 및 최적화를 완료하여 발행 준비 상태로 만든다.

## Success Criteria

- 3,500-4,500자 한국어 블로그 포스트가 `site/content/posts/study-motivation-scientific-methods.md`에 존재
- Hugo frontmatter가 유효하고 기존 포스트와 동일한 구조
- 7가지 과학적 전략이 연구 데이터와 함께 서술됨
- 2-3개 한국 상황 미니스토리 포함
- 내부 링크 CTA 2-3개 자연스럽게 배치
- content_scorer.py 품질 점수 ≥70
- AI 워터마크 스크러빙 완료

## Key Risks / Unknowns

- content_scorer.py의 한국어 콘텐츠 호환성 — Flesch 점수가 한국어에 정확하지 않을 수 있음
- 3,500-4,500자 목표 내에서 7개 전략 모두 충분한 깊이로 다루는 균형

## Proof Strategy

- 한국어 품질 점수 호환성 → S02에서 실제 점수 실행 후 결과 확인으로 증명
- 글자 수 균형 → S01에서 실제 작성 후 글자 수 측정으로 증명

## Verification Classes

- Contract verification: 파일 존재, frontmatter 유효성, 글자 수, content_scorer.py 점수
- Integration verification: none
- Operational verification: none
- UAT / human verification: 최종 콘텐츠 품질은 사용자가 읽고 판단

## Milestone Definition of Done

This milestone is complete only when all are true:

- S01 아티클 초안이 모든 요건 (글자 수, 미니스토리, CTA, 이미지 플레이스홀더)을 충족
- S02 스크러빙 및 품질 검증 완료 (점수 ≥70)
- 최적화 보고서가 `drafts/reports/study-motivation-scientific-methods/`에 생성됨
- 파일이 Hugo 빌드 가능한 상태

## Requirement Coverage

- Covers: R001, R002, R003, R004, R005, R006, R007, R008, R009, R010, R011
- Partially covers: none
- Leaves for later: none
- Orphan risks: none

## Slices

- [x] **S01: Full Article Draft** `risk:low` `depends:[]`
  > After this: `site/content/posts/study-motivation-scientific-methods.md`에 3,500-4,500자 한국어 블로그 포스트 초안이 존재하며, Hugo frontmatter, 7가지 전략, 미니스토리, CTA, 이미지 플레이스홀더가 모두 포함됨.

- [x] **S02: Optimize & Finalize** `risk:low` `depends:[S01]`
  > After this: 아티클이 AI 워터마크 스크러빙 완료, content_scorer.py 점수 ≥70 달성, 최적화 에이전트 보고서가 `drafts/reports/study-motivation-scientific-methods/`에 생성됨.

## Boundary Map

### S01 → S02

Produces:
- `site/content/posts/study-motivation-scientific-methods.md` — Hugo frontmatter + 3,500-4,500자 한국어 마크다운 본문

Consumes:
- `research/brief-study-motivation-methods-2026-03-22.md` — 리서치 브리프 (아웃라인, 데이터, 메타 요소)
- `context/` — 브랜드 보이스, 스타일, SEO 가이드

### S02

Produces:
- 스크러빙된 아티클 파일 (in-place 수정)
- `drafts/reports/study-motivation-scientific-methods/` — SEO, meta, keyword, link 보고서
- frontmatter에 quality_score 업데이트

Consumes from S01:
- `site/content/posts/study-motivation-scientific-methods.md` — 초안 아티클
