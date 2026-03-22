# SEO Machine — AI Insights Lab 블로그

## What This Is

AI Insights Lab 기술 블로그. Hugo 기반 정적 사이트에 AI/개발 관련 한국어 포스트 28개가 발행되어 있다. SEO Machine 워크스페이스(커스텀 커맨드 + 에이전트)로 콘텐츠를 리서치, 작성, 최적화, 발행하는 파이프라인을 갖추고 있다.

## Core Value

AI/기술 주제를 한국어로 읽히는 글로 전달한다. "실력 있는 선배가 설명하는" 톤으로, 전문성은 유지하되 독자가 끝까지 읽는 글.

## Current State

- 28개 포스트 발행 완료 (site/content/posts/)
- M001에서 study-motivation 글 작성+최적화 진행 중
- 기존 글들은 AI 생성 냄새가 나는 기계적 문체, 톤 불일치, 네이버 블로그 수준의 가독성 부족 상태
- brand-voice.md, style-guide.md 가이드라인 존재하나 새 톤 기준 미반영

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
- [ ] M002: 블로그 전체 한국어 품질 개선 — 28개 전체 글의 어색한 표현, 문법, 구조를 인기 네이버 블로그 수준으로 리라이트
