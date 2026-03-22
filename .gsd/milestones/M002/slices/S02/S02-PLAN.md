# S02: Claude Code 시리즈 리라이트 (9개)

**Goal:** Claude Code 시리즈 9개 글을 brand-voice.md/style-guide.md 기준의 통일 톤("실력 있는 선배" 경어체)으로 전면 리라이트한다. 코드 블록 80개 전체가 원본과 byte-identical하게 보존된다.

**Demo:** 9개 글 중 아무 3개를 랜덤으로 열어도 S01 파일럿(getting-started)과 같은 톤/구조로 읽힌다. `bash scripts/verify-s02.sh`가 전체 통과한다.

## Must-Haves

- 9개 글 전체가 경어체(~합니다/~입니다)로 통일, 해라체 잔존 없음
- 각 글에 흥미 유발 도입부, 섹션 연결 문장, 행동 유도 결론 존재
- 코드 블록 80개 전체 byte-identical 보존 (baseline diff)
- frontmatter date/tags 불변 (D007). title/description 개선 허용.
- difficulty 필드 보존 (있는 글만)
- seo 블록 미추가, SEO Machine 푸터 미추가 (원본에 없음)

## Proof Level

- This slice proves: contract — 톤 가이드 문서 기준으로 시리즈 전체 리라이트
- Real runtime required: no
- Human/UAT required: yes — 랜덤 3개 글 읽기

## Verification

- `bash scripts/verify-s02.sh` — 코드 블록 보존(9파일), frontmatter 불변, 구조 패턴 존재, 경어체 확인
- Manual review: 랜덤 3개 + getting-started(S01 파일럿)을 읽었을 때 톤 일관성

## Tasks

- [ ] **T01: essential-commands + tdd-workflow + custom-commands 리라이트** `est:2h`
  - Why: 코드 블록이 가장 많은 3개(23+14+10=47블록)를 먼저 처리. 코드 밀도가 높아 블록 보존에 가장 주의 필요.
  - Files: `site/content/posts/claude-code/claude-code-essential-commands.md`, `site/content/posts/claude-code/claude-code-tdd-workflow.md`, `site/content/posts/claude-code/claude-code-custom-commands.md`
  - Do: brand-voice.md/style-guide.md 기준 전면 리라이트. 해라체→경어체 전환. 도입부/결론/섹션연결 추가. 코드 블록 내용 절대 불변. S02 baseline 추출 스크립트 및 검증 스크립트 작성.
  - Verify: `python scripts/extract_baselines_single.py [file]`로 각 파일 코드 블록 추출 후 baseline diff
  - Done when: 3개 파일 경어체 전환 완료, 코드 블록 baseline diff 통과

- [ ] **T02: project-setup + hooks-automation + multi-agent + mcp-servers + claude-md-guide 리라이트** `est:2h`
  - Why: 중간 코드 밀도 5개(9+7+7+5+5=33블록). 같은 패턴 반복이므로 한 태스크로 배치 처리.
  - Files: `site/content/posts/claude-code/claude-code-project-setup.md`, `site/content/posts/claude-code/claude-code-hooks-automation.md`, `site/content/posts/claude-code/claude-code-multi-agent.md`, `site/content/posts/claude-code/claude-code-mcp-servers.md`, `site/content/posts/claude-code/claude-code-claude-md-guide.md`
  - Do: brand-voice.md/style-guide.md 기준 전면 리라이트. 해라체→경어체 전환. 도입부/결론/섹션연결 추가. 코드 블록 내용 절대 불변.
  - Verify: 각 파일 코드 블록 baseline diff
  - Done when: 5개 파일 경어체 전환 완료, 코드 블록 baseline diff 통과

- [ ] **T03: context-management 리라이트 + 전체 검증** `est:1h`
  - Why: 코드 블록 0개인 유일한 파일. 리라이트 후 S02 전체 검증(9개 파일 일괄). word_count 갱신 불필요(seo 블록 없음).
  - Files: `site/content/posts/claude-code/claude-code-context-management.md`, `scripts/verify-s02.sh`
  - Do: context-management 리라이트. 그 후 9개 전체 검증 스크립트 작성 및 실행.
  - Verify: `bash scripts/verify-s02.sh`
  - Done when: 검증 스크립트 전체 통과, 9개 파일 톤 일관성 확인

## Files Likely Touched

- `site/content/posts/claude-code/claude-code-essential-commands.md`
- `site/content/posts/claude-code/claude-code-tdd-workflow.md`
- `site/content/posts/claude-code/claude-code-custom-commands.md`
- `site/content/posts/claude-code/claude-code-project-setup.md`
- `site/content/posts/claude-code/claude-code-hooks-automation.md`
- `site/content/posts/claude-code/claude-code-multi-agent.md`
- `site/content/posts/claude-code/claude-code-mcp-servers.md`
- `site/content/posts/claude-code/claude-code-claude-md-guide.md`
- `site/content/posts/claude-code/claude-code-context-management.md`
- `scripts/verify-s02.sh`
- `scripts/baselines/*-codeblocks.txt` (9 files, already extracted)
