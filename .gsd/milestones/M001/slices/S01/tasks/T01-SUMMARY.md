---
status: done
started: 2026-03-22T21:22:00+09:00
completed: 2026-03-22T21:25:00+09:00
---

# T01 Summary: Fix article compliance gaps

## What was done

Three compliance gaps in `site/content/posts/study-motivation-scientific-methods.md` were fixed:

1. **`draft: false` → `draft: true`** — Articles must start as drafts per R004.
2. **Added 2 `[image:]` placeholders** — Inserted dopamine reward loop diagram placeholder after the 게임 vs 공부 subsection, and 66-day habit timeline placeholder before the phased roadmap subsections (R008).
3. **Updated `word_count: 3800` → `word_count: 6980`** — Corrected to actual body character count.

## Verification

All 5 checks passed:
- File exists ✅
- Frontmatter valid with `draft: true` ✅
- Image placeholders: 2 ✅
- Internal link CTAs: 2 ✅
- 7 strategies present ✅

## Commit

`dc1b57c` — fix(S01/T01): set draft:true, add image placeholders, update word_count
