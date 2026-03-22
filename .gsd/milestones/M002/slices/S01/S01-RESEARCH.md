# S01: 톤 가이드 수립 + 3 파일럿 리라이트 — Research

**Date:** 2026-03-22
**Depth:** Targeted — known domain (Korean content editing), moderately complex tone definition

## Summary

S01의 핵심은 두 가지다: (1) 나머지 25개 글의 리라이트 기준이 되는 톤 가이드 문서 2종(brand-voice.md, style-guide.md) 확정, (2) 각 글 유형의 레퍼런스가 되는 파일럿 3종 리라이트. 현재 28개 포스트의 톤은 세 가지로 분열되어 있다—경어체 교과서 문체(ai-agent-trends, claude-vs-gpt 등 대다수), 해라체 실용문(getting-started 등 Claude Code 시리즈), 해라체 오피니언(designers). 파일럿은 이 세 유형을 하나의 통일 톤("실력 있는 선배" 경어체)으로 수렴시키는 작업이다.

가장 큰 리스크는 톤 정의의 모호성이다. "실력 있는 선배"를 구체적 문장 패턴, 금지 표현, 구조 패턴으로 코드화하지 않으면 S02–S04에서 톤이 표류한다. study-motivation 글이 이미 목표 톤의 가장 가까운 레퍼런스이므로, 이를 기준점으로 삼아 톤 원칙을 추출해야 한다.

## Recommendation

**brand-voice.md, style-guide.md를 먼저 전면 재작성한 뒤, 그 기준으로 3개 파일럿을 리라이트한다.** 가이드 문서가 먼저 확정되어야 파일럿 리라이트 결과를 가이드와 대조 검증할 수 있고, S02–S04 슬라이스가 가이드만 읽고 작업할 수 있다.

3개 파일럿은 서로 독립적이므로 병렬 작업 가능하다. 단, 가이드 문서 확정 후에 시작해야 한다.

## Implementation Landscape

### Key Files

**수정 대상:**
- `context/brand-voice.md` — 현재 22줄. 톤 원칙, 금지 표현, 구어적 전환 패턴, 독자 페르소나 등을 D003/D006 기준으로 전면 재작성. S02–S05 전 슬라이스의 입력 파일.
- `context/style-guide.md` — 현재 22줄. 글 구조 패턴(도입부/섹션 전환/결론), 문장 길이 기준, 소제목 패턴, 네이버 블로그 구조 요소를 D004/D005 기준으로 전면 재작성. S02–S05 전 슬라이스의 입력 파일.
- `site/content/posts/ai-agent-trends-2026.md` — 기술 해설 레퍼런스. 4,781 bytes. 코드 블록 1개 (의사코드 리스트). 현재 톤: 경어체 교과서 문체. 불릿→테이블→불릿 반복 구조. 도입부 없이 바로 "AI 에이전트란 무엇인가"로 시작. SEO Machine 푸터 있음.
- `site/content/posts/claude-vs-gpt-comparison.md` — 비교 분석 레퍼런스. 5,699 bytes. 코드 블록 2개 (Python API 예시). 현재 톤: 경어체 교과서 문체. 테이블 3개 연속. 도입부 없이 바로 "비교의 기준"으로 시작. SEO Machine 푸터 있음.
- `site/content/posts/claude-code/claude-code-getting-started.md` — 튜토리얼 레퍼런스. 11,718 bytes. 코드 블록 17개 (bash, json, 터미널 출력). 현재 톤: **해라체**(~이다/~한다). 이미 서사적 흐름이 있으나 경어체로 전환 필요. SEO Machine 푸터 **없음**. `difficulty: "입문"` 필드 있음. `seo:` 블록 **없음**.

**읽기 전용 레퍼런스:**
- `site/content/posts/study-motivation-scientific-methods.md` — 목표 톤의 가장 가까운 레퍼런스. 20,224 bytes. 경어체 + 서사적 도입부 + 미니스토리 + 데이터 인용 + 행동 유도 결론. 이 글의 패턴을 톤 가이드에 코드화해야 함.
- `site/content/posts/designers-most-underrated-in-tech.md` — 해라체→경어체 전환의 레퍼런스 (D006). 이 글 자체는 S04에서 리라이트하지만, 톤 전환 원칙 수립 시 참고.
- `context/seo-guidelines.md` — SEO 구조 제약 (H1 60자, 메타 150-160자, 내부 링크 3-5개). 변경 불필요하나 리라이트 시 준수해야 함.

### Tone Analysis: Current State

| 파일 | 문체 | 도입부 | 구조 | 코드 블록 | 푸터 |
|------|------|--------|------|-----------|------|
| ai-agent-trends | 경어체 ~합니다 | 없음 (바로 정의) | 불릿→테이블 반복 | 1개 의사코드 | SEO Machine ✓ |
| claude-vs-gpt | 경어체 ~합니다 | 없음 (바로 기준 나열) | 테이블 3연속 | 2개 Python | SEO Machine ✓ |
| getting-started | **해라체 ~이다/한다** | 있음 (What + Why) | 서사적 흐름 | 17개 bash/json | **없음** |
| study-motivation (ref) | 경어체 ~합니다 | 공감형 시나리오 | 서사+데이터+스토리 | 1개 공식 | 없음 |
| designers (ref) | **해라체 ~이다** | 강한 주장 | 오피니언 에세이 | 0 | 없음 |

### Tone Gap Analysis

**ai-agent-trends (기술 해설):** 가장 전형적인 "AI가 쓴 글" 패턴. 도입부가 "AI 에이전트(AI Agent)는..."으로 시작하는 사전식 정의. 모든 섹션이 한 문단 설명 → 불릿 리스트 or 테이블. 독자에게 말 거는 부분이 전혀 없음. 전면 재구성 필요.

**claude-vs-gpt (비교 분석):** 테이블 의존도가 극도로 높음 (5개 테이블). 비교 분석 자체는 가치 있으나, 텍스트 흐름 없이 테이블을 나열하면 카탈로그처럼 읽힘. 각 비교 항목에 "왜 이 차이가 중요한가"라는 맥락 서술이 필요.

**getting-started (튜토리얼):** 이미 서사적 흐름과 실용 팁이 있어 톤 가이드에 가장 가까움. 그러나 해라체(~이다/한다)를 경어체(~입니다/합니다)로 전환해야 함. 이 전환이 서사적 강점을 희석하지 않도록 주의.

### Build Order

**Phase 1: 톤 가이드 문서 (brand-voice.md + style-guide.md)**
- study-motivation 글에서 톤 패턴을 추출하여 코드화
- D003 (문체 톤), D004 (개선 깊이), D005 (글 구성 패턴), D006 (통일 범위) 결정사항 반영
- 구체적 Do/Don't 예시 문장 포함 (모호성 방지의 핵심)
- 이 문서가 S02–S05의 유일한 톤 참조점

**Phase 2: 파일럿 리라이트 3종 (병렬 가능)**
- `ai-agent-trends-2026.md` — 기술 해설 유형 레퍼런스. 도입부 재설계, 구조 재배치, 독자 참여 요소 삽입.
- `claude-vs-gpt-comparison.md` — 비교 분석 유형 레퍼런스. 테이블 의존 줄이기, 맥락 서술 강화, 흥미 유발 도입부 추가.
- `claude-code-getting-started.md` — 튜토리얼 유형 레퍼런스. 해라체→경어체 전환, 서사적 흐름 보존.

**Phase 3: 가이드-파일럿 정합성 검증**
- 3개 파일럿이 가이드 문서와 일치하는지 크로스체크
- 필요시 가이드 문서를 파일럿 경험 기반으로 보정

### Verification Approach

**1. 코드 블록 보존 검증 (자동화 가능):**
- 리라이트 전후로 각 파일의 코드 블록(```...```)을 추출하여 diff
- ai-agent-trends: 1개 블록, claude-vs-gpt: 2개 블록, getting-started: 17개 블록
- 코드 블록 내용이 1byte라도 달라지면 실패

**2. Frontmatter 유효성 (자동화 가능):**
- YAML 파싱 성공 여부
- slug, date, tags 변경 없음 확인 (D007)
- title, description은 변경 허용
- K001 주의: frontmatter 영역의 인덴테이션 보존

**3. 톤 일관성 (수동 검증):**
- 3개 파일럿을 랜덤 순서로 읽었을 때 같은 목소리로 느껴지는지
- 해라체 문장(~이다/~한다)이 getting-started에서 완전히 경어체로 전환됐는지
- study-motivation과 톤이 자연스럽게 호환되는지

**4. 구조 패턴 검증:**
- 각 글에 흥미 유발 도입부가 있는지
- 섹션 사이 연결 문장이 있는지
- 행동 유도 결론이 있는지
- SEO Machine 푸터 유지 여부 확인 (있던 글은 유지)

## Constraints

- **코드 블록 절대 불변** — ```...``` 내부는 1byte도 변경 금지 (D004)
- **YAML frontmatter 인덴테이션** — K001: `seo:` 하위 필드의 2-space indent 보존. `sed`나 스크럽 도구가 frontmatter를 건드리지 않도록 분리 처리.
- **slug/date/tags 불변** — D007: URL 보존을 위해 slug와 date 변경 금지.
- **SEO 제약** — seo-guidelines.md: H1 60자, 메타 150-160자, 내부 링크 3-5개.
- **getting-started의 `difficulty` 필드** — 다른 파일에 없는 커스텀 필드. 보존해야 함.
- **getting-started의 `seo:` 블록 부재** — 다른 파일과 frontmatter 구조가 다름. 추가하지 않음 (scope 외).

## Common Pitfalls

- **경어체 전환 시 서사 강점 희석** — getting-started는 해라체이지만 서사적 흐름이 우수함. 기계적으로 "~이다"를 "~입니다"로 치환하면 리듬이 깨짐. 문장 구조 자체를 경어체에 맞게 재구성해야 함.
- **톤 가이드의 추상성** — "자신감 있게 쓴다"는 실행 불가능한 지시. "~인 것 같습니다"를 "~입니다"로 쓴다, "아마도"를 "실제로"로 바꾼다 같은 구체적 Do/Don't 예시가 없으면 S02–S04에서 톤이 표류함.
- **테이블 과잉 제거** — claude-vs-gpt의 테이블 5개를 무조건 줄이면 비교 분석의 핵심 가치가 사라짐. 테이블은 유지하되, 테이블 전후에 맥락 서술("왜 이 비교가 중요한가")을 추가하는 방향.
- **SEO Machine 푸터 일관성** — ai-agent-trends와 claude-vs-gpt에는 있고 getting-started에는 없음. 리라이트 시 있는 글은 유지, 없는 글에 새로 추가하지 않음 (scope 외).
- **frontmatter의 word_count/quality_score** — 현재 값이 리라이트 전 기준. 리라이트 후 정확한 값으로 갱신해야 하나, 자동 스코어링은 K002/K003 한계로 의미 없음. word_count만 수동 갱신하고 quality_score는 0으로 둠.

## Open Risks

- **톤 가이드 1차 버전의 완성도** — 파일럿 3종을 리라이트한 뒤 가이드와 실제 글 사이 괴리가 발견될 수 있음. Phase 3에서 가이드를 보정하는 루프가 필요하며, 이로 인해 가이드가 S02 착수 전에 한 번 더 수정될 수 있음.
- **getting-started의 코드 블록 밀도** — 17개 코드 블록이 본문 곳곳에 삽입되어 있어, 구조 재배치 시 코드 블록 위치가 문맥과 어긋날 수 있음. 코드 블록 앞뒤의 설명 문맥을 반드시 함께 이동해야 함.
