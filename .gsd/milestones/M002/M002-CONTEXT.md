# M002: 블로그 전체 한국어 품질 개선

**Gathered:** 2026-03-22
**Status:** Ready for planning

## Project Description

AI Insights Lab 블로그의 28개 전체 포스트를 "실력 있는 선배가 설명하는" 통일 톤으로 리라이트. 어색한 한국어, 문법 오류, 기계적 AI 문체를 교정하고, 인기 네이버 블로그 수준의 독자 참여형 구조로 전면 재구성.

## Why This Milestone

현재 글들은 AI가 쓴 티가 확연히 남. "~합니다" "~입니다" 반복, 도입부→불릿→테이블→다음 섹션 기계적 패턴, 글마다 톤 불일치(~이다 체 vs ~습니다 체). 독자가 첫 두 문단에서 이탈할 가능성 높음. 기술 전문성은 있으나 읽히는 글이 아닌 상태.

## User-Visible Outcome

### When this milestone is complete, the user can:

- 28개 전체 블로그 글을 펼쳐서 하나의 통일된 목소리를 확인할 수 있다
- 아무 글이나 열어서 읽으면 끝까지 자연스럽게 읽힌다 — "AI가 쓴 것 같다" 느낌 없음
- 도입부가 흥미를 유발하고, 섹션 사이가 매끄럽게 연결되며, 결론이 행동을 유도한다

### Entry point / environment

- Entry point: site/content/posts/ 내 28개 .md 파일
- Environment: 로컬 파일시스템 (Hugo 빌드 확인은 선택적)
- Live dependencies involved: none

## Completion Class

- Contract complete means: 28개 파일이 모두 새 톤 가이드 기준에 맞게 리라이트됨, frontmatter 유효, 코드 블록 보존
- Integration complete means: brand-voice.md, style-guide.md가 새 기준 반영, 전체 글 톤 일관성 확인
- Operational complete means: none (정적 파일 수정)

## Final Integrated Acceptance

To call this milestone complete, we must prove:

- 28개 글 중 아무거나 3개를 랜덤으로 열어서 읽었을 때 톤이 일관되고 자연스러움
- 코드 블록, API 예시, 수치 데이터가 원본과 동일
- brand-voice.md, style-guide.md가 실제 글의 톤과 일치

## Risks and Unknowns

- **톤 정의의 모호성** — "실력 있는 선배"가 구체적으로 어떤 문장인지 파일럿에서 확정해야 함
- **study-motivation 글 품질 유지** — 이미 서사 품질이 높은 글을 톤 통일하면서 강점 희석 위험
- **코드 블록 손상** — 리라이트 중 코드 블록 내용이 변경되거나 마크다운 서식이 깨질 수 있음
- **K001 YAML 붕괴** — frontmatter 수정 시 인덴테이션이 무너질 수 있음 (content_scrubber 이슈)

## Existing Codebase / Prior Art

- `site/content/posts/` — 28개 블로그 포스트 (Hugo markdown)
- `context/brand-voice.md` — 현재 브랜드 보이스 가이드 (수정 대상)
- `context/style-guide.md` — 현재 스타일 가이드 (수정 대상)
- `context/seo-guidelines.md` — SEO 가이드라인 (참조, 수정 불필요)
- `site/content/posts/study-motivation-scientific-methods.md` — 이미 서사 품질 높은 참조 글
- `site/content/posts/designers-most-underrated-in-tech.md` — ~이다 체, 톤 전환 대상

> See `.gsd/DECISIONS.md` for all architectural and pattern decisions.

## Relevant Requirements

- R012 — 통일된 블로그 목소리 (핵심)
- R013 — 자연스러운 한국어
- R014 — 독자 참여형 구조
- R015 — SEO 메타 품질
- R016 — 기술 정확성 보존 (제약)
- R017 — 브랜드 가이드 정합성
- R018 — 글간 일관성

## Scope

### In Scope

- 28개 전체 글 본문 리라이트 (톤, 구조, 표현)
- frontmatter title, description 개선
- brand-voice.md, style-guide.md 업데이트
- 전체 글 톤/구조 일관성 QA
- 기존 SEO Machine 푸터 유지

### Out of Scope / Non-Goals

- 새 글 작성
- 이미지 제작/삽입
- Hugo 테마/레이아웃 변경
- 코드 블록 내용 수정
- slug, date, tags 변경
- 발행 상태(draft) 변경

## Technical Constraints

- Hugo YAML frontmatter 형식 유지 (K001 주의: YAML 인덴테이션 보존)
- 코드 블록 (```...```) 내용 절대 변경 금지
- 마크다운 서식 호환성 유지

## Integration Points

- `context/brand-voice.md` — 새 톤 기준 반영
- `context/style-guide.md` — 새 문체 기준 반영

## Open Questions

- 없음 — 논의 완료
