# S02: Optimize & Finalize

**Goal:** Article passes content_scorer.py ≥70, AI watermarks scrubbed, optimization reports generated in `drafts/reports/study-motivation-scientific-methods/`.
**Demo:** `quality_score` in frontmatter reflects actual scorer output ≥70. Scrub stats show 0 watermarks (content is clean). Four optimization reports exist in the reports directory.

## Must-Haves

- AI watermark scrubbing executed on article body (R010)
- content_scorer.py composite score ≥70, reflected in frontmatter `quality_score` (R009)
- Optimization reports in `drafts/reports/study-motivation-scientific-methods/` (R011): SEO analysis, meta analysis, keyword analysis, internal link analysis

## Verification

```bash
# 1. Quality score in frontmatter matches scorer output and is ≥70
python -c "
import sys, re, yaml
sys.path.insert(0, 'data_sources/modules')
from content_scorer import ContentScorer

content = open('site/content/posts/study-motivation-scientific-methods.md').read()
fm = re.split(r'^---\s*$', content, maxsplit=2, flags=re.MULTILINE)[1]
data = yaml.safe_load(fm)

scorer = ContentScorer()
meta = {
    'meta_title': data.get('title', ''),
    'meta_description': data.get('description', ''),
    'primary_keyword': data.get('seo', {}).get('primary_keyword', ''),
}
result = scorer.score(content, meta)
fm_score = data.get('seo', {}).get('quality_score', 0)

assert result['composite_score'] >= 70, f'Score {result[\"composite_score\"]} < 70'
assert abs(fm_score - result['composite_score']) <= 1, f'Frontmatter score {fm_score} != actual {result[\"composite_score\"]}'
print(f'Quality score: {result[\"composite_score\"]} (frontmatter: {fm_score}) — PASS')
"

# 2. Reports directory has ≥4 report files
python -c "
import os
report_dir = 'drafts/reports/study-motivation-scientific-methods'
files = [f for f in os.listdir(report_dir) if f.endswith('.md')]
assert len(files) >= 4, f'Reports: {len(files)}, need ≥4'
print(f'Reports: {len(files)} — PASS')
for f in sorted(files):
    print(f'  - {f}')
"

# 3. Scrub was executed (frontmatter last_optimized is set)
python -c "
import re, yaml
text = open('site/content/posts/study-motivation-scientific-methods.md').read()
fm = re.split(r'^---\s*$', text, maxsplit=2, flags=re.MULTILINE)[1]
data = yaml.safe_load(fm)
lo = data.get('seo', {}).get('last_optimized')
assert lo is not None, 'last_optimized not set'
print(f'last_optimized: {lo} — PASS')
"
```

## Tasks

- [x] **T01: Run scrubber and scorer, update frontmatter** `est:15m`
  - Why: Satisfies R009 (quality score ≥70) and R010 (AI watermark scrubbing). Must scrub body only (not frontmatter — the scrubber's whitespace cleanup damages YAML indentation). Update `quality_score` and `last_optimized` in frontmatter.
  - Files: `site/content/posts/study-motivation-scientific-methods.md`
  - Do: (1) Run content_scrubber on article body only (split at frontmatter `---` delimiters, scrub part 3, rejoin). (2) Run content_scorer.py to get composite score. (3) Update frontmatter `quality_score` to actual score and `last_optimized` to today's date.
  - Verify: `python -c "..."` — frontmatter quality_score matches scorer output and is ≥70.
  - Done when: Frontmatter reflects actual quality score ≥70, last_optimized is set, scrub has been run.

- [x] **T02: Generate optimization reports** `est:20m`
  - Why: Satisfies R011 — optimization agent reports must exist in `drafts/reports/study-motivation-scientific-methods/`. These provide SEO, meta, keyword, and internal link analysis visibility.
  - Files: `drafts/reports/study-motivation-scientific-methods/seo-analysis.md`, `drafts/reports/study-motivation-scientific-methods/meta-analysis.md`, `drafts/reports/study-motivation-scientific-methods/keyword-analysis.md`, `drafts/reports/study-motivation-scientific-methods/internal-link-analysis.md`
  - Do: Generate 4 report files analyzing the article's SEO health, meta elements, keyword usage, and internal linking. Use content_scorer.py dimension data, keyword density calculations, and link inventory to populate each report with actual data.
  - Verify: `ls drafts/reports/study-motivation-scientific-methods/*.md | wc -l` returns ≥4.
  - Done when: Four report files exist with actual analysis data (not stubs).

## Files Likely Touched

- `site/content/posts/study-motivation-scientific-methods.md`
- `drafts/reports/study-motivation-scientific-methods/seo-analysis.md`
- `drafts/reports/study-motivation-scientific-methods/meta-analysis.md`
- `drafts/reports/study-motivation-scientific-methods/keyword-analysis.md`
- `drafts/reports/study-motivation-scientific-methods/internal-link-analysis.md`
