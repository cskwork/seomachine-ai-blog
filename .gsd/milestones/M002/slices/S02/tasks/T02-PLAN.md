---
estimated_steps: 5
estimated_files: 5
skills_used: []
---

# T02: project-setup + hooks-automation + multi-agent + mcp-servers + claude-md-guide 리라이트

**Slice:** S02 — Claude Code 시리즈 리라이트 (9개)
**Milestone:** M002

## Description

중간 코드 밀도 5개 파일(project-setup 9블록, hooks-automation 7블록, multi-agent 7블록, mcp-servers 5블록, claude-md-guide 5블록, 총 33블록)을 리라이트한다. T01과 동일한 변환 패턴: 해라체→경어체, 도입부/결론/섹션연결 추가, 코드 블록 보존.

**핵심 제약:** T01과 동일. 코드 블록 불변, date/tags 불변, seo/푸터 미추가.

**톤 레퍼런스:** getting-started (S01 파일럿) + T01에서 리라이트된 3개 파일

## Steps

1. `context/brand-voice.md`, `context/style-guide.md` 읽어 톤/구조 기준 확인
2. `claude-code-project-setup.md` 리라이트 (9 blocks). baseline diff.
3. `claude-code-hooks-automation.md` 리라이트 (7 blocks). baseline diff.
4. `claude-code-multi-agent.md` 리라이트 (7 blocks). baseline diff.
5. `claude-code-mcp-servers.md` 리라이트 (5 blocks). baseline diff. 이어서 `claude-code-claude-md-guide.md` 리라이트 (5 blocks). baseline diff.

## Must-Haves

- [ ] 5개 파일 전체 경어체 전환 완료
- [ ] 5개 파일 모두 흥미 유발 도입부 + 행동 유도 결론
- [ ] 코드 블록 33개 baseline diff 통과

## Verification

- 각 파일별 `diff scripts/baselines/{name}-codeblocks.txt <(python scripts/extract_baselines_single.py {filepath})` — 모두 동일
- 파일별 name: project-setup, hooks-automation, multi-agent, mcp-servers, claude-md-guide

## Inputs

- `context/brand-voice.md` — 톤 기준
- `context/style-guide.md` — 문체/구조 기준
- `site/content/posts/claude-code/claude-code-project-setup.md` — 리라이트 대상
- `site/content/posts/claude-code/claude-code-hooks-automation.md` — 리라이트 대상
- `site/content/posts/claude-code/claude-code-multi-agent.md` — 리라이트 대상
- `site/content/posts/claude-code/claude-code-mcp-servers.md` — 리라이트 대상
- `site/content/posts/claude-code/claude-code-claude-md-guide.md` — 리라이트 대상
- `scripts/baselines/project-setup-codeblocks.txt` — baseline
- `scripts/baselines/hooks-automation-codeblocks.txt` — baseline
- `scripts/baselines/multi-agent-codeblocks.txt` — baseline
- `scripts/baselines/mcp-servers-codeblocks.txt` — baseline
- `scripts/baselines/claude-md-guide-codeblocks.txt` — baseline

## Expected Output

- `site/content/posts/claude-code/claude-code-project-setup.md` — 경어체 리라이트 완료
- `site/content/posts/claude-code/claude-code-hooks-automation.md` — 경어체 리라이트 완료
- `site/content/posts/claude-code/claude-code-multi-agent.md` — 경어체 리라이트 완료
- `site/content/posts/claude-code/claude-code-mcp-servers.md` — 경어체 리라이트 완료
- `site/content/posts/claude-code/claude-code-claude-md-guide.md` — 경어체 리라이트 완료
