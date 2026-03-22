# M001: 공부 동기부여 블로그 포스트 작성 및 최적화

**Gathered:** 2026-03-22
**Status:** Ready for planning

## Project Description

AI Insights Lab 블로그에 "공부 동기부여 방법" 주제의 한국어 SEO 최적화 블로그 포스트를 작성한다. 뇌과학과 심리학 연구 데이터 기반의 과학적 접근법으로 감정적 팩폭 중심 경쟁 콘텐츠와 차별화한다. 독자층 확장 콘텐츠로, 기술 블로그 정체성은 시스템적 사고와 분석적 접근법을 통해 간접적으로 드러낸다.

## Why This Milestone

리서치 브리프가 완료되어 즉시 본문 작성이 가능한 상태이다. "공부 동기부여 방법"은 검색량이 높은 키워드이며, AI/기술 블로그의 독자층을 자기계발 관심 개발자/PM으로 확장할 수 있는 전략적 콘텐츠이다.

## User-Visible Outcome

### When this milestone is complete, the user can:

- `site/content/posts/study-motivation-scientific-methods.md`에서 발행 준비 완료된 3,500-4,500자 한국어 블로그 포스트를 확인
- `drafts/reports/study-motivation-scientific-methods/`에서 SEO/meta/keyword/link 최적화 보고서 확인
- `/publish` 명령어로 즉시 WordPress에 발행

### Entry point / environment

- Entry point: Hugo 마크다운 파일 (`site/content/posts/`)
- Environment: 로컬 파일시스템 (Hugo 빌드)
- Live dependencies involved: none (발행 단계에서만 WordPress API 필요)

## Completion Class

- Contract complete means: 아티클 파일 존재, frontmatter 유효, 품질 점수 ≥70, 스크러빙 완료
- Integration complete means: 기존 내부 링크 맵과 호환, Hugo 빌드 가능
- Operational complete means: none (발행은 별도 `/publish` 단계)

## Final Integrated Acceptance

To call this milestone complete, we must prove:

- `site/content/posts/study-motivation-scientific-methods.md` 파일이 유효한 Hugo frontmatter + 3,500-4,500자 한국어 본문을 포함
- content_scorer.py 품질 점수 ≥70
- AI 워터마크 스크러빙 완료

## Risks and Unknowns

- 품질 점수 70 미달 시 수동 수정 필요 — content_scorer.py는 한국어 콘텐츠에 최적화되지 않았을 수 있음
- 내부 링크 타겟 포스트의 실제 존재 여부 — internal-links-map.md 기준으로 연결하되, 실제 URL은 발행 후 확인 필요

## Existing Codebase / Prior Art

- `research/brief-study-motivation-methods-2026-03-22.md` — 완료된 리서치 브리프 (아웃라인, 통계, 경쟁 분석, 메타 요소)
- `context/brand-voice.md` — 톤 및 메시징 가이드
- `context/style-guide.md` — 문체 및 포맷팅 규칙
- `context/seo-guidelines.md` — SEO 구조 규칙
- `context/internal-links-map.md` — 내부 링크 매핑
- `.claude/commands/write.md` — 글쓰기 워크플로우 및 품질 기준
- `site/content/posts/ai-agent-trends-2026.md` — 기존 포스트 형식 참조

## Relevant Requirements

- R001 — 3,500-4,500자 한국어 블로그 포스트 작성
- R002 — "공부 동기부여 방법" SEO 최적화
- R003 — 뇌과학/심리학 연구 데이터 인용
- R004-R008 — 포맷, 브랜드 보이스, CTA, 미니스토리, 이미지 플레이스홀더
- R009-R011 — 품질 점수, 스크러빙, 최적화 보고서

## Scope

### In Scope

- 리서치 브리프 기반 3,500-4,500자 한국어 블로그 포스트 본문 작성
- Hugo YAML frontmatter 포함
- 7가지 전략 + 66일 로드맵 + 응급 처방 + 오해 섹션
- 2-3개 한국 상황 미니스토리
- 2-3개 내부 링크 CTA
- 이미지 플레이스홀더
- AI 워터마크 스크러빙
- content_scorer.py 품질 검증
- 최적화 에이전트 보고서 생성

### Out of Scope / Non-Goals

- WordPress 발행 (별도 `/publish` 단계)
- 실제 인포그래픽 이미지 제작
- 외부 백링크 구축
- GA4/GSC 성과 추적

## Technical Constraints

- Hugo YAML frontmatter 필수 (기존 포스트와 동일 구조)
- 경어체 (~합니다, ~입니다)
- 기술 용어 첫 등장 시 영문 + 한국어 병기
- 이모지 미사용
- 키워드 밀도 1-2%
- 문단당 최대 4문장

## Integration Points

- `context/internal-links-map.md` — CTA 내부 링크 타겟
- `data_sources/modules/content_scorer.py` — 품질 점수 평가
- `.claude/commands/scrub.md` — AI 워터마크 제거

## Open Questions

- content_scorer.py의 한국어 Flesch 점수 계산 정확도 — 런타임에 확인 후 필요 시 점수 기준 조정
