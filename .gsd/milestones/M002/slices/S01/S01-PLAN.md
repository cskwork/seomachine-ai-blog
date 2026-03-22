# S01: 톤 가이드 수립 + 3 파일럿 리라이트

**Goal:** brand-voice.md와 style-guide.md를 "실력 있는 선배" 톤으로 전면 재작성하고, 3개 대표 글(기술해설/비교분석/튜토리얼)을 새 톤으로 리라이트하여 S02–S05의 톤 기준점을 확립한다.

**Demo:** brand-voice.md와 style-guide.md에 구체적 Do/Don't 예시 문장이 포함되어 있고, 3개 파일럿 글을 아무 순서로 읽어도 같은 목소리("실력 있는 선배" 경어체)로 느껴진다. 코드 블록은 원본과 byte-identical하다. `bash scripts/verify-s01.sh`가 모든 체크를 통과한다.

## Must-Haves

- brand-voice.md 전면 재작성: 톤 원칙, 금지 표현 목록, 구체적 Do/Don't 예시 문장(최소 5쌍), 독자 페르소나 포함 (R017)
- style-guide.md 전면 재작성: 글 구조 패턴(도입부/섹션 전환/결론), 문장 길이 기준, 소제목 패턴, 네이버 블로그 구조 요소 (R017, R014)
- ai-agent-trends-2026.md 리라이트: 흥미 유발 도입부, 섹션 연결 문장, 행동 유도 결론 추가 (R012, R014)
- claude-vs-gpt-comparison.md 리라이트: 테이블 전후 맥락 서술 강화, 도입부/결론 추가 (R012, R014)
- claude-code-getting-started.md 리라이트: 해라체→경어체 전환, 서사적 흐름 보존, 17개 코드 블록 불변 (R012, R014)
- 3개 파일럿의 코드 블록 내용 byte-identical 보존 (D004): ai-agent 1개, claude-vs-gpt 2개, getting-started 17개
- frontmatter date, tags 불변 (D007). title, description은 개선 허용.
- SEO Machine 푸터: 있던 글(ai-agent, claude-vs-gpt)은 유지, 없던 글(getting-started)은 추가 금지

## Proof Level

- This slice proves: integration — 톤 가이드 문서와 실제 글 3종의 톤 정합성
- Real runtime required: no
- Human/UAT required: yes — 3개 파일럿을 읽었을 때 톤 일관성 체감 확인

## Verification

- `bash scripts/verify-s01.sh` — 코드 블록 보존, YAML 유효성, date/tags 불변, 구조 패턴 존재, 경어체 확인
- Manual review: 3개 파일럿을 읽었을 때 같은 목소리로 느껴지는지 확인

## Integration Closure

- Upstream surfaces consumed: none (first slice)
- New wiring introduced: `context/brand-voice.md`와 `context/style-guide.md`가 S02–S05의 유일한 톤 참조점. 3개 파일럿이 각 글 유형(기술해설/비교분석/튜토리얼)의 구체적 레퍼런스로 기능.
- What remains: S02(Claude Code 9개), S03(AI 기술 6개), S04(비교/전략/특수 8개), S05(study-motivation + 전체 QA)

## Tasks

- [x] **T01: 톤 가이드 전면 재작성 + 검증 인프라 구축** `est:1h`
  - Why: S02–S05 전체가 이 가이드 문서에 의존한다. 모호한 가이드는 톤 표류의 원인이므로 구체적 Do/Don't 예시가 필수. 검증 스크립트는 코드 블록 보존의 안전장치.
  - Files: `context/brand-voice.md`, `context/style-guide.md`, `scripts/verify-s01.sh`, `scripts/baselines/`
  - Do: study-motivation 글에서 톤 패턴을 추출(경어체 리듬, 서사 도입, 데이터 인용 방식, 독자 참여 패턴)하여 두 가이드를 전면 재작성. D003(문체 톤), D004(개선 깊이), D005(글 구성 패턴), D006(통일 범위) 반영. 3개 파일럿의 코드 블록 baseline을 추출하고 검증 스크립트를 작성. K001 주의: frontmatter 인덴테이션 관련 검증 포함.
  - Verify: `test -f context/brand-voice.md && test -f context/style-guide.md && test -f scripts/verify-s01.sh && ls scripts/baselines/*.txt | wc -l` (3 baseline files)
  - Done when: 가이드 문서가 각각 50줄 이상, Do/Don't 예시 최소 5쌍씩 포함, 검증 스크립트가 baseline 추출 완료

- [x] **T02: ai-agent-trends + claude-vs-gpt 전면 리라이트** `est:1h30m`
  - Why: 기술 해설(ai-agent-trends)과 비교 분석(claude-vs-gpt) 유형의 톤 레퍼런스를 확립. 두 글 모두 짧고(4.7K, 5.7K) 코드 블록이 적어(1개, 2개) 한 태스크로 처리 가능.
  - Files: `site/content/posts/ai-agent-trends-2026.md`, `site/content/posts/claude-vs-gpt-comparison.md`
  - Do: brand-voice.md/style-guide.md 기준으로 전면 리라이트. 각 글에 흥미 유발 도입부, 섹션 연결 문장, 행동 유도 결론 추가. 코드 블록 내용 불변. frontmatter title/description 개선, date/tags 불변. SEO Machine 푸터 유지. claude-vs-gpt의 테이블은 유지하되 전후 맥락 서술 강화.
  - Verify: `diff scripts/baselines/ai-agent-trends-codeblocks.txt <(awk '/^```/,/^```/' site/content/posts/ai-agent-trends-2026.md) && diff scripts/baselines/claude-vs-gpt-codeblocks.txt <(awk '/^```/,/^```/' site/content/posts/claude-vs-gpt-comparison.md)`
  - Done when: 두 글 모두 새 톤으로 리라이트되고 도입부/결론/섹션 연결이 있으며 코드 블록이 baseline과 동일

- [x] **T03: claude-code-getting-started 전면 리라이트** `est:1h`
  - Why: 튜토리얼 유형의 톤 레퍼런스 확립. 해라체→경어체 전환이 필요한 유일한 파일럿이며, 17개 코드 블록이 있어 전용 태스크로 분리.
  - Files: `site/content/posts/claude-code/claude-code-getting-started.md`
  - Do: brand-voice.md/style-guide.md 기준으로 리라이트. 해라체(~이다/한다)를 경어체(~입니다/합니다)로 전환하되 서사적 흐름 보존. 기계적 치환 금지—문장 구조 자체를 경어체에 맞게 재구성. 17개 코드 블록 내용 절대 불변. difficulty 필드 보존. seo 블록 추가 금지. SEO Machine 푸터 추가 금지.
  - Verify: `diff scripts/baselines/getting-started-codeblocks.txt <(awk '/^```/,/^```/' site/content/posts/claude-code/claude-code-getting-started.md)`
  - Done when: 전체 본문이 경어체이고 서사적 흐름이 보존되며 17개 코드 블록이 baseline과 byte-identical

- [x] **T04: 가이드–파일럿 정합성 검증 + 최종 보정** `est:30m`
  - Why: 톤 가이드와 실제 파일럿 글 사이 괴리를 발견하고 보정하는 마지막 루프. 이 검증 없이 S02에 넘기면 톤 표류 위험.
  - Files: `context/brand-voice.md`, `context/style-guide.md`, `site/content/posts/ai-agent-trends-2026.md`, `site/content/posts/claude-vs-gpt-comparison.md`, `site/content/posts/claude-code/claude-code-getting-started.md`
  - Do: 전체 검증 스크립트 실행. 3개 파일럿의 톤 일관성 크로스체크(같은 표현 패턴, 도입부/결론 구조 패턴). 가이드와 파일럿 사이 괴리 발견 시 가이드 보정. frontmatter word_count를 실제 본문 글자수로 갱신(quality_score는 0 유지 — K002/K003).
  - Verify: `bash scripts/verify-s01.sh`
  - Done when: 검증 스크립트 전체 통과, word_count가 실제 본문 반영, 3개 파일럿 간 톤 일관성 확인

## Files Likely Touched

- `context/brand-voice.md`
- `context/style-guide.md`
- `site/content/posts/ai-agent-trends-2026.md`
- `site/content/posts/claude-vs-gpt-comparison.md`
- `site/content/posts/claude-code/claude-code-getting-started.md`
- `scripts/verify-s01.sh`
- `scripts/baselines/ai-agent-trends-codeblocks.txt`
- `scripts/baselines/claude-vs-gpt-codeblocks.txt`
- `scripts/baselines/getting-started-codeblocks.txt`
