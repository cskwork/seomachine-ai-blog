---
estimated_steps: 4
estimated_files: 3
skills_used: []
---

# T01: essential-commands + tdd-workflow + custom-commands 리라이트

**Slice:** S02 — Claude Code 시리즈 리라이트 (9개)
**Milestone:** M002

## Description

코드 블록이 가장 많은 3개 파일(essential-commands 23블록, tdd-workflow 14블록, custom-commands 10블록, 총 47블록)을 리라이트한다. 모두 claude-code/ 하위 시리즈 글로, 해라체(~이다/한다)에서 경어체(~합니다/입니다)로 전환하고 brand-voice.md/style-guide.md 구조 패턴을 적용한다.

**핵심 제약:**
- 코드 블록(```...```) 내용 절대 불변. 코드 블록 앞뒤 설명 텍스트만 수정.
- frontmatter date/tags 불변. title/description 개선 허용.
- difficulty 필드 보존 (있는 파일만).
- seo 블록 추가 금지. SEO Machine 푸터 추가 금지.
- 해라체→경어체 전환 시 기계적 치환 금지. 문장 구조 재구성 필요.

**톤 레퍼런스:** `site/content/posts/claude-code/claude-code-getting-started.md` (S01 파일럿)

## Steps

1. `context/brand-voice.md`, `context/style-guide.md` 읽어 톤/구조 기준 확인
2. `claude-code-essential-commands.md` 리라이트 (23 code blocks): 도입부/결론/섹션연결 추가, 해라체→경어체, 코드 블록 보존. 리라이트 후 baseline diff.
3. `claude-code-tdd-workflow.md` 리라이트 (14 code blocks): 동일 패턴. 리라이트 후 baseline diff.
4. `claude-code-custom-commands.md` 리라이트 (10 code blocks): 동일 패턴. 리라이트 후 baseline diff.

## Must-Haves

- [ ] 3개 파일 전체 경어체 전환 완료, 해라체 잔존 없음
- [ ] 3개 파일 모두 흥미 유발 도입부 + 행동 유도 결론
- [ ] 코드 블록 47개 baseline diff 통과

## Verification

- `diff scripts/baselines/essential-commands-codeblocks.txt <(python scripts/extract_baselines_single.py site/content/posts/claude-code/claude-code-essential-commands.md)` — 동일
- `diff scripts/baselines/tdd-workflow-codeblocks.txt <(python scripts/extract_baselines_single.py site/content/posts/claude-code/claude-code-tdd-workflow.md)` — 동일
- `diff scripts/baselines/custom-commands-codeblocks.txt <(python scripts/extract_baselines_single.py site/content/posts/claude-code/claude-code-custom-commands.md)` — 동일

## Inputs

- `context/brand-voice.md` — 톤 기준
- `context/style-guide.md` — 문체/구조 기준
- `site/content/posts/claude-code/claude-code-getting-started.md` — 톤 레퍼런스 (S01 파일럿)
- `site/content/posts/claude-code/claude-code-essential-commands.md` — 리라이트 대상
- `site/content/posts/claude-code/claude-code-tdd-workflow.md` — 리라이트 대상
- `site/content/posts/claude-code/claude-code-custom-commands.md` — 리라이트 대상
- `scripts/baselines/essential-commands-codeblocks.txt` — baseline
- `scripts/baselines/tdd-workflow-codeblocks.txt` — baseline
- `scripts/baselines/custom-commands-codeblocks.txt` — baseline

## Expected Output

- `site/content/posts/claude-code/claude-code-essential-commands.md` — 경어체 리라이트 완료
- `site/content/posts/claude-code/claude-code-tdd-workflow.md` — 경어체 리라이트 완료
- `site/content/posts/claude-code/claude-code-custom-commands.md` — 경어체 리라이트 완료
