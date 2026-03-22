# SEO Machine — 공부 동기부여 블로그 포스트

## What This Is

AI Insights Lab 블로그에 "공부 동기부여 방법" 주제의 한국어 SEO 최적화 블로그 포스트를 작성하고 발행 준비하는 프로젝트. 뇌과학과 심리학 연구 데이터 기반의 과학적 접근법으로 차별화하며, 기존 AI/기술 블로그의 독자층 확장 콘텐츠로 기능한다.

## Core Value

뇌과학/심리학 연구 데이터에 기반한 7가지 실전 공부 동기부여 전략을 3,500-4,500자 한국어 블로그 포스트로 전달한다.

## Current State

리서치 브리프 완료 (research/brief-study-motivation-methods-2026-03-22.md). 키워드 분석, 경쟁사 분석, 아웃라인, 통계 데이터, 메타 요소 설계 모두 완료. 본문 작성 전 단계.

## Architecture / Key Patterns

- Hugo 기반 정적 블로그 (`site/content/posts/`)
- Hugo YAML frontmatter + 마크다운 본문
- 브랜드 가이드라인: `context/` 디렉토리
- 최적화 파이프라인: content_scorer.py + optimization agents
- 발행 경로: `drafts/` → `site/content/posts/` (draft: true)

## Capability Contract

See `.gsd/REQUIREMENTS.md` for the explicit capability contract.

## Milestone Sequence

- [ ] M001: 공부 동기부여 블로그 포스트 작성 및 최적화 — 리서치 브리프 기반으로 SEO 최적화된 한국어 블로그 포스트를 작성하고 품질 검증 완료
