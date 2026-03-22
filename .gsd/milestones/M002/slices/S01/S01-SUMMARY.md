---
status: done
outcome: success
started: 2026-03-22
completed: 2026-03-22
tasks_completed: 4/4
---

# S01 Summary: 톤 가이드 수립 + 3 파일럿 리라이트

## What was delivered

1. **brand-voice.md** (157줄): "실력 있는 선배" 톤 원칙 3개, Do/Don't 예시 7쌍, 금지 표현 12개, 독자 페르소나, 글 유형별 미세 조정(기술해설/비교분석/튜토리얼), 기술 용어 규칙.

2. **style-guide.md** (161줄): 도입부 3패턴, 섹션 전환 2패턴, 결론 3패턴, 문장/문단 규칙, 소제목 규칙, 네이버 블로그 구조 요소, 포맷팅 규칙, SEO 구조 제약 연동.

3. **3개 파일럿 리라이트 완료**:
   - `ai-agent-trends-2026.md` — 사전식 정의 → 독자 시나리오 도입부, 섹션 연결, 행동 유도 결론. 코드 블록 1개 보존.
   - `claude-vs-gpt-comparison.md` — 기준 나열 → 핵심 질문 도입부, 테이블 맥락 서술 강화, 판단 기준 결론. 코드 블록 2개 보존.
   - `claude-code-getting-started.md` — 해라체→경어체 전환, 서사적 흐름 보존, 코드 블록 17개 보존. difficulty 필드 보존.

4. **검증 인프라**: `scripts/verify-s01.sh` (18 checks), `scripts/baselines/` (3 baseline files).

## Verification

`bash scripts/verify-s01.sh` — **18/18 ALL CHECKS PASSED**

체크 항목: 코드 블록 보존(3), frontmatter 필드 보존(7), SEO Machine 푸터(3), 구조 패턴 H2 수(3), K001 seo indent(2).

## Forward Intelligence (for S02, S03, S04, S05)

**톤 참조점:**
- `context/brand-voice.md` — 유일한 톤 기준 문서. 반드시 읽고 시작할 것.
- `context/style-guide.md` — 유일한 문체/구조 기준 문서.
- 파일럿 레퍼런스: 기술해설 → `ai-agent-trends-2026.md`, 비교분석 → `claude-vs-gpt-comparison.md`, 튜토리얼 → `claude-code-getting-started.md`.

**코드 블록 보존 방법:**
- `scripts/extract_baselines.py`로 baseline 추출 가능 (python으로 실행, python3 아님 — Windows 환경).
- `scripts/extract_baselines_single.py`로 단일 파일 추출.
- 리라이트 후 `diff baseline.txt <(python scripts/extract_baselines_single.py target.md)` 로 검증.

**주의사항:**
- K001: frontmatter의 `seo:` 하위 필드 2-space indent 반드시 보존.
- D007: slug, date, tags 변경 금지. title과 description만 개선 허용.
- SEO Machine 푸터: 있는 글은 유지, 없는 글에 추가 금지.
- word_count: 리라이트 후 실제 글자수로 갱신. quality_score는 0 유지 (K002/K003).
- 해라체→경어체 전환 시 기계적 치환 금지 — 문장 구조 자체를 재구성해야 자연스러움.

**가이드 보정 가능성:** S01에서 가이드와 파일럿이 정합하여 보정 불필요였으나, S02-S04에서 25개 글을 리라이트하면서 추가 패턴이 발견되면 가이드 보정 가능. 단, 기존 파일럿과의 정합성 훼손 주의.
