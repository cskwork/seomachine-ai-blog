---
estimated_steps: 5
estimated_files: 6
skills_used: []
---

# T01: 톤 가이드 전면 재작성 + 검증 인프라 구축

**Slice:** S01 — 톤 가이드 수립 + 3 파일럿 리라이트
**Milestone:** M002

## Description

S02–S05 전체가 의존하는 톤 가이드 문서 2종(brand-voice.md, style-guide.md)을 전면 재작성한다. study-motivation 글을 목표 톤의 레퍼런스로 삼아 구체적 톤 패턴을 추출하고, 모호함 없는 Do/Don't 예시를 포함한 가이드를 작성한다. 동시에 파일럿 리라이트의 코드 블록 보존을 검증할 인프라(baseline + 스크립트)를 구축한다.

**핵심 결정사항 (가이드 작성 시 반영 필수):**
- D003: "실력 있는 선배" 경어체. 자신감 있고 단정적, 구어적 전환점 삽입, 이모지 없음, 과장 없음, "~인 것 같아요" 금지
- D004: 전면 리라이트 허용. 섹션 순서, 소제목, 도입부, 결론까지 자유 재구성. 코드 블록 내용만 절대 불변
- D005: 네이버 블로그 패턴 — 흥미 유발 도입부, 핵심 요약박스, 독자에게 질문, 섹션 연결 문장, 행동 유도 결론
- D006: 28개 글 전체 하나의 톤으로 통일

**study-motivation 글의 핵심 톤 패턴 (추출 대상):**
- 도입부: 독자 시나리오로 시작 ("매일 밤 다짐합니다...")
- 단정적 서술: "~입니다", "~합니다" (절대 "~인 것 같습니다")
- 데이터 인용 시: 구체적 수치를 자연스럽게 삽입 ("127개 연구, 77,560명")
- 미니스토리: 가상 인물로 구체적 상황 서술 ("민수는 고3 수험생이었습니다")
- 독자 참여: 직접적 질문("공부는 어떻습니까") 또는 지시("~하십시오")
- 결론: 즉시 실행 가능한 행동 제안 ("오늘 당장 할 수 있는 한 가지:")

## Steps

1. **study-motivation 글에서 톤 패턴 추출**: 위 핵심 패턴을 기반으로, 추가적인 문체 패턴(접속사 사용, 문장 리듬, 섹션 전환 방식)을 정리
2. **brand-voice.md 전면 재작성**: 톤 원칙(경어체 기본 규칙, 자신감 표현, 구어적 전환), 금지 표현 목록(최소 10개), Do/Don't 예시 문장(최소 5쌍), 독자 페르소나, 글 유형별 미세 조정 가이드(기술해설/비교분석/튜토리얼) 포함. 기존 내용(기술 용어 규칙, 대상 독자 등)은 새 톤에 맞게 통합
3. **style-guide.md 전면 재작성**: 글 구조 패턴(도입부 3가지 패턴, 섹션 전환 2가지 패턴, 결론 3가지 패턴), 문장 길이 기준, 소제목 패턴, 네이버 블로그 구조 요소(요약박스, 독자 질문, 행동 유도) 포함. 기존 포맷팅 규칙은 유지
4. **코드 블록 baseline 추출**: 3개 파일럿의 코드 블록을 추출하여 `scripts/baselines/`에 저장. ai-agent-trends(1개), claude-vs-gpt(2개), getting-started(17개)
5. **검증 스크립트 작성**: `scripts/verify-s01.sh` — (a) 코드 블록 diff, (b) YAML frontmatter 유효성(파싱 + date/tags 불변 확인), (c) 경어체 패턴 체크(해라체 잔존 탐지), (d) 구조 패턴 존재 확인(도입부/결론 존재), (e) SEO Machine 푸터 확인, (f) getting-started의 difficulty 필드 보존 확인

## Must-Haves

- [ ] brand-voice.md에 Do/Don't 예시 문장 최소 5쌍 포함
- [ ] brand-voice.md에 금지 표현 목록 최소 10개 포함
- [ ] style-guide.md에 도입부/결론 구조 패턴이 구체적 예시와 함께 기술됨
- [ ] scripts/baselines/에 3개 파일의 코드 블록 baseline 파일이 존재
- [ ] scripts/verify-s01.sh가 실행 가능하고, 현재 상태(리라이트 전)에서 baseline과 일치 확인 통과

## Verification

- `test -s context/brand-voice.md && wc -l < context/brand-voice.md` — 50줄 이상
- `test -s context/style-guide.md && wc -l < context/style-guide.md` — 50줄 이상
- `grep -c "Don't\|❌\|금지\|하지 않" context/brand-voice.md` — 10 이상 (금지 표현 목록)
- `test -f scripts/baselines/ai-agent-trends-codeblocks.txt && test -f scripts/baselines/claude-vs-gpt-codeblocks.txt && test -f scripts/baselines/getting-started-codeblocks.txt`
- `bash scripts/verify-s01.sh` — baseline diff 체크가 통과 (리라이트 전이므로 코드 블록 동일)

## Inputs

- `site/content/posts/study-motivation-scientific-methods.md` — 목표 톤의 레퍼런스. 이 글의 패턴을 톤 가이드에 코드화
- `context/brand-voice.md` — 현재 22줄. 전면 재작성 대상
- `context/style-guide.md` — 현재 17줄. 전면 재작성 대상
- `context/seo-guidelines.md` — 읽기 전용. SEO 제약 (H1 60자, 메타 150-160자) 확인용
- `site/content/posts/ai-agent-trends-2026.md` — 코드 블록 baseline 추출 대상
- `site/content/posts/claude-vs-gpt-comparison.md` — 코드 블록 baseline 추출 대상
- `site/content/posts/claude-code/claude-code-getting-started.md` — 코드 블록 baseline 추출 대상

## Expected Output

- `context/brand-voice.md` — 전면 재작성 완료 (50줄+, Do/Don't 5쌍+, 금지 표현 10개+)
- `context/style-guide.md` — 전면 재작성 완료 (50줄+, 구조 패턴 포함)
- `scripts/verify-s01.sh` — 실행 가능한 검증 스크립트
- `scripts/baselines/ai-agent-trends-codeblocks.txt` — 코드 블록 baseline
- `scripts/baselines/claude-vs-gpt-codeblocks.txt` — 코드 블록 baseline
- `scripts/baselines/getting-started-codeblocks.txt` — 코드 블록 baseline
