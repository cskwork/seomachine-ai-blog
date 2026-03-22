---
estimated_steps: 3
estimated_files: 2
skills_used: []
---

# T03: context-management 리라이트 + S02 전체 검증

**Slice:** S02 — Claude Code 시리즈 리라이트 (9개)
**Milestone:** M002

## Description

코드 블록이 0개인 context-management를 리라이트하고, S02 전체 9개 파일에 대한 검증 스크립트를 작성·실행한다.

## Steps

1. `claude-code-context-management.md` 리라이트: 해라체→경어체, 도입부/결론/섹션연결 추가. 코드 블록 0개이므로 baseline diff는 빈 파일과 비교.
2. `scripts/verify-s02.sh` 작성: S02 9개 파일 전체에 대해 — (a) 코드 블록 baseline diff, (b) frontmatter date 불변, (c) seo 블록 미존재, (d) SEO Machine 푸터 미존재, (e) H2 3개 이상.
3. `bash scripts/verify-s02.sh` 실행하여 전체 통과 확인. 실패 시 해당 파일 수정.

## Must-Haves

- [ ] context-management 경어체 전환 완료
- [ ] verify-s02.sh 전체 통과
- [ ] 9개 파일 톤 일관성 확인

## Verification

- `bash scripts/verify-s02.sh` — ALL CHECKS PASSED

## Inputs

- `context/brand-voice.md` — 톤 기준
- `context/style-guide.md` — 문체/구조 기준
- `site/content/posts/claude-code/claude-code-context-management.md` — 리라이트 대상
- `scripts/baselines/context-management-codeblocks.txt` — baseline (빈 파일)
- T01, T02에서 리라이트된 8개 파일 — 검증 대상

## Expected Output

- `site/content/posts/claude-code/claude-code-context-management.md` — 경어체 리라이트 완료
- `scripts/verify-s02.sh` — S02 전체 검증 스크립트
