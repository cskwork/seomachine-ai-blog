---
estimated_steps: 4
estimated_files: 5
skills_used: []
---

# T04: 가이드–파일럿 정합성 검증 + 최종 보정

**Slice:** S01 — 톤 가이드 수립 + 3 파일럿 리라이트
**Milestone:** M002

## Description

3개 파일럿 리라이트 결과를 톤 가이드와 크로스체크하고, 괴리가 있으면 가이드를 보정한다. 코드 블록 보존, frontmatter 유효성, 톤 일관성을 전체 검증 스크립트로 확인하고, frontmatter의 word_count를 실제 본문 글자수로 갱신한다.

## Steps

1. **전체 검증 스크립트 실행**: `bash scripts/verify-s01.sh`를 실행하여 코드 블록 보존, YAML 유효성, date/tags 불변, 경어체 패턴, 구조 패턴(도입부/결론), SEO Machine 푸터, difficulty 필드를 일괄 검증. 실패 항목이 있으면 해당 파일을 수정
2. **톤 일관성 크로스체크**: 3개 파일럿의 도입부, 결론, 섹션 전환 방식을 나란히 비교. brand-voice.md에 정의된 패턴(Do/Don't, 금지 표현)과 대조. 불일치 항목 발견 시:
   - 파일럿 쪽이 더 나은 패턴이면 → brand-voice.md 또는 style-guide.md를 보정
   - 가이드 기준이 맞으면 → 해당 파일럿 텍스트를 보정
3. **frontmatter word_count 갱신**: 3개 파일럿의 실제 본문 글자수(frontmatter와 코드 블록 제외)를 카운트하여 frontmatter의 `word_count` 값 갱신. `quality_score`는 0으로 유지 (K002/K003: Korean content에 대해 영어 기반 스코어가 오해를 유발). getting-started에는 seo 블록이 없으므로 word_count 갱신 불필요
4. **최종 검증**: 보정 후 `bash scripts/verify-s01.sh` 재실행하여 전체 통과 확인

**주의사항:**
- K001: frontmatter의 seo: 하위 필드 2-space indent 보존
- getting-started에 seo 블록을 추가하지 않음 (word_count 갱신 대상 아님)
- word_count 값은 정수로 기입 (소수점 없음)

## Must-Haves

- [ ] `bash scripts/verify-s01.sh` 전체 통과
- [ ] ai-agent-trends와 claude-vs-gpt의 frontmatter word_count가 실제 본문 글자수 반영
- [ ] 3개 파일럿의 톤이 brand-voice.md 기준과 정합
- [ ] 보정이 발생한 경우, 보정 내역이 커밋 메시지에 기록될 수 있도록 명확히 파악됨

## Verification

- `bash scripts/verify-s01.sh` — 모든 체크 통과
- `grep 'word_count:' site/content/posts/ai-agent-trends-2026.md` — 값이 실제 글자수와 근사 (±50)
- `grep 'word_count:' site/content/posts/claude-vs-gpt-comparison.md` — 값이 실제 글자수와 근사 (±50)

## Inputs

- `context/brand-voice.md` — T01에서 재작성된 톤 기준 (보정 가능)
- `context/style-guide.md` — T01에서 재작성된 문체 기준 (보정 가능)
- `site/content/posts/ai-agent-trends-2026.md` — T02에서 리라이트된 결과
- `site/content/posts/claude-vs-gpt-comparison.md` — T02에서 리라이트된 결과
- `site/content/posts/claude-code/claude-code-getting-started.md` — T03에서 리라이트된 결과
- `scripts/verify-s01.sh` — T01에서 작성된 검증 스크립트
- `scripts/baselines/ai-agent-trends-codeblocks.txt` — T01에서 추출된 baseline
- `scripts/baselines/claude-vs-gpt-codeblocks.txt` — T01에서 추출된 baseline
- `scripts/baselines/getting-started-codeblocks.txt` — T01에서 추출된 baseline

## Expected Output

- `context/brand-voice.md` — 보정 반영 (변경 없을 수도 있음)
- `context/style-guide.md` — 보정 반영 (변경 없을 수도 있음)
- `site/content/posts/ai-agent-trends-2026.md` — word_count 갱신 + 톤 보정 (필요시)
- `site/content/posts/claude-vs-gpt-comparison.md` — word_count 갱신 + 톤 보정 (필요시)
- `site/content/posts/claude-code/claude-code-getting-started.md` — 톤 보정만 (필요시, word_count 갱신 없음)
