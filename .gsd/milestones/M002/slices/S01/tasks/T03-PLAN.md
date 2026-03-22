---
estimated_steps: 3
estimated_files: 1
skills_used: []
---

# T03: claude-code-getting-started 전면 리라이트

**Slice:** S01 — 톤 가이드 수립 + 3 파일럿 리라이트
**Milestone:** M002

## Description

튜토리얼 유형의 톤 레퍼런스를 확립한다. 이 글은 현재 해라체(~이다/한다)로 작성되어 있으며, 이미 서사적 흐름과 실용 팁이 잘 갖춰져 있다. 경어체(~입니다/합니다)로 전환하되 서사적 강점을 보존하는 것이 핵심 과제다.

**이 파일의 특수성:**
- 17개 코드 블록 — 가장 많은 코드 블록을 포함. 모두 byte-identical 보존 필수
- `difficulty: "입문"` — 다른 글에 없는 커스텀 frontmatter 필드. 반드시 보존
- `seo:` 블록 없음 — 다른 글과 frontmatter 구조가 다름. 추가하지 않음
- SEO Machine 푸터 없음 — 원본에 없으므로 추가하지 않음
- `claude-code/` 하위 디렉토리에 위치 — 경로 주의

**해라체→경어체 전환 시 주의사항:**
기계적 치환("~이다"→"~입니다")은 절대 금지. 해라체와 경어체는 문장 리듬이 근본적으로 다르다. 예시:
- ❌ "Claude Code는 반대입니다." (기계적 치환 — 어색)
- ✅ "Claude Code는 접근 방식이 다릅니다." (경어체에 맞는 자연스러운 재구성)

## Steps

1. **T01 산출물 확인**: `context/brand-voice.md`와 `context/style-guide.md`를 읽어 톤/구조 기준 파악. 특히 튜토리얼 유형의 미세 조정 가이드 확인
2. **getting-started.md 리라이트**:
   - 전체 본문을 경어체(~입니다/합니다)로 전환. 문장 구조 자체를 경어체 리듬에 맞게 재구성
   - 서사적 흐름 보존: 원본의 "What is → Install → First Task → Permission → Mistakes → Next" 흐름은 이미 우수. 대폭 변경하지 않되, 도입부와 결론을 brand-voice.md/style-guide.md 기준에 맞게 강화
   - 도입부: 현재 "Claude Code란 무엇인가"를 독자 시나리오 또는 경험 기반 도입으로 보강. 예: "처음 터미널에서 AI와 대화한다는 게 어색하게 느껴질 수 있습니다."
   - 결론: 현재 마지막 문단("Claude Code가 처음에는 낯설 수 있다...")을 행동 유도형으로 보강
   - 섹션 연결: 각 --- 구분선 전후에 자연스러운 연결 문장 확인/보강
   - **17개 코드 블록**: 절대 불변. 코드 블록 바로 앞뒤의 설명 텍스트만 경어체로 수정
   - frontmatter: title과 description 개선 허용. date(2026-03-20), tags, categories 불변. `difficulty: "입문"` 보존. seo 블록 추가 금지
3. **코드 블록 보존 검증**: baseline과 diff하여 17개 블록 전체 불변 확인

## Must-Haves

- [ ] 전체 본문에 해라체 문장(~이다, ~한다, ~했다)이 남아 있지 않음 (코드 블록 내부 제외)
- [ ] 서사적 흐름이 보존됨: 도입→설치→실습→권한→실수→다음단계
- [ ] 17개 코드 블록 내용이 baseline과 byte-identical
- [ ] frontmatter의 `difficulty: "입문"` 필드 보존
- [ ] seo 블록 추가되지 않음
- [ ] SEO Machine 푸터 추가되지 않음
- [ ] 도입부가 독자 참여형으로 보강됨
- [ ] 결론이 행동 유도형으로 보강됨

## Verification

- `diff scripts/baselines/getting-started-codeblocks.txt <(awk '/^```/,/^```/' site/content/posts/claude-code/claude-code-getting-started.md)` — 출력 없음(동일)
- `grep -q 'difficulty:' site/content/posts/claude-code/claude-code-getting-started.md` — difficulty 필드 존재
- `! grep -q '^seo:' site/content/posts/claude-code/claude-code-getting-started.md` — seo 블록 없음
- `! grep -q 'SEO Machine' site/content/posts/claude-code/claude-code-getting-started.md` — 푸터 없음

## Inputs

- `context/brand-voice.md` — T01에서 재작성된 톤 기준
- `context/style-guide.md` — T01에서 재작성된 문체 기준
- `site/content/posts/claude-code/claude-code-getting-started.md` — 리라이트 대상 원본
- `scripts/baselines/getting-started-codeblocks.txt` — 17개 코드 블록 baseline (T01 산출물)

## Expected Output

- `site/content/posts/claude-code/claude-code-getting-started.md` — 경어체 톤으로 전면 리라이트 완료
