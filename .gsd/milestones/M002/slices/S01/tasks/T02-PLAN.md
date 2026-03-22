---
estimated_steps: 4
estimated_files: 2
skills_used: []
---

# T02: ai-agent-trends + claude-vs-gpt 전면 리라이트

**Slice:** S01 — 톤 가이드 수립 + 3 파일럿 리라이트
**Milestone:** M002

## Description

기술 해설(ai-agent-trends-2026)과 비교 분석(claude-vs-gpt-comparison) 유형의 톤 레퍼런스를 확립한다. 두 글 모두 현재 경어체이지만 "사전식 정의 → 불릿/테이블 나열"의 기계적 구조를 "실력 있는 선배가 설명하는" 서사적 구조로 전면 리라이트한다.

**변경 범위 (D004):** 섹션 순서, 소제목, 도입부, 결론까지 자유 재구성. 코드 블록 내용만 절대 불변.

## Steps

1. **T01 산출물 확인**: `context/brand-voice.md`와 `context/style-guide.md`를 읽어 톤/구조 기준 파악
2. **ai-agent-trends-2026.md 리라이트**:
   - 도입부 추가: 현재 "AI 에이전트(AI Agent)는..."으로 시작하는 사전식 정의를 독자 시나리오 또는 트렌드 도입으로 교체
   - 섹션 전환: 각 섹션 사이에 연결 문장 삽입 ("이런 배경에서 주목받는 것이 바로...")
   - 결론: 행동 유도 결론 추가 ("지금 시작하려면...")
   - 코드 블록 1개 내용 불변 (```비용 최적화 전략:...``` 블록)
   - frontmatter: title과 description 개선 허용. date(2026-03-20), tags, categories, slug 불변
   - SEO Machine 푸터 유지 (*이 글은 [SEO Machine]... 워크스페이스를 활용하여 작성되었습니다.*)
   - seo: 블록의 word_count는 아직 갱신하지 않음 (T04에서 일괄 처리)
3. **claude-vs-gpt-comparison.md 리라이트**:
   - 도입부 추가: "어떤 모델을 쓸지 고민한 적 있으신가요?" 같은 독자 참여형 도입
   - 테이블 유지하되 전후에 맥락 서술 추가: "왜 이 비교가 중요한가", "실무에서 이 차이가 어떤 영향을 미치는가"
   - 섹션 연결 문장 삽입
   - 결론: 행동 유도 결론 강화 ("당신의 프로젝트에 맞는 선택은...")
   - 코드 블록 2개 내용 불변 (Python API 예시 2개)
   - frontmatter: title과 description 개선 허용. date(2026-03-17), tags, categories, slug 불변
   - SEO Machine 푸터 유지
   - seo: 블록의 word_count는 아직 갱신하지 않음 (T04에서 일괄 처리)
4. **코드 블록 보존 검증 실행**: baseline과 diff하여 불변 확인

**주의사항:**
- 코드 블록(```...```)의 내용은 1byte도 변경 금지. 코드 블록 앞뒤의 설명 텍스트만 수정.
- seo: 하위 필드의 2-space indent 보존 (K001). frontmatter 영역 수동 편집 시 주의.
- 글 유형별 미세 톤 차이: ai-agent-trends는 트렌드 해설이므로 약간 더 넓은 시야, claude-vs-gpt는 비교 분석이므로 실용적 판단 근거 중심.

## Must-Haves

- [ ] ai-agent-trends-2026.md에 흥미 유발 도입부가 있고 사전식 정의로 시작하지 않음
- [ ] ai-agent-trends-2026.md에 행동 유도 결론이 있음
- [ ] claude-vs-gpt-comparison.md에 흥미 유발 도입부가 있음
- [ ] claude-vs-gpt-comparison.md의 테이블이 보존되고 전후 맥락 서술이 추가됨
- [ ] 코드 블록 baseline diff 통과 (ai-agent 1개, claude-vs-gpt 2개)
- [ ] 두 글 모두 SEO Machine 푸터 유지

## Verification

- `diff scripts/baselines/ai-agent-trends-codeblocks.txt <(awk '/^```/,/^```/' site/content/posts/ai-agent-trends-2026.md)` — 출력 없음(동일)
- `diff scripts/baselines/claude-vs-gpt-codeblocks.txt <(awk '/^```/,/^```/' site/content/posts/claude-vs-gpt-comparison.md)` — 출력 없음(동일)
- `grep -q "SEO Machine" site/content/posts/ai-agent-trends-2026.md && grep -q "SEO Machine" site/content/posts/claude-vs-gpt-comparison.md` — 푸터 존재
- `head -50 site/content/posts/ai-agent-trends-2026.md | grep -v "^---" | grep -v "^$" | head -5` — 도입부 확인 (사전식 정의가 아닌 서사적 시작)

## Inputs

- `context/brand-voice.md` — T01에서 재작성된 톤 기준
- `context/style-guide.md` — T01에서 재작성된 문체 기준
- `site/content/posts/ai-agent-trends-2026.md` — 리라이트 대상 원본
- `site/content/posts/claude-vs-gpt-comparison.md` — 리라이트 대상 원본
- `scripts/baselines/ai-agent-trends-codeblocks.txt` — 코드 블록 baseline (T01 산출물)
- `scripts/baselines/claude-vs-gpt-codeblocks.txt` — 코드 블록 baseline (T01 산출물)

## Expected Output

- `site/content/posts/ai-agent-trends-2026.md` — 새 톤으로 전면 리라이트 완료
- `site/content/posts/claude-vs-gpt-comparison.md` — 새 톤으로 전면 리라이트 완료
