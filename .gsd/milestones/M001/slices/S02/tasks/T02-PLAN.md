---
estimated_steps: 5
estimated_files: 5
skills_used: []
---

# T02: Generate optimization reports

**Slice:** S02 — Optimize & Finalize
**Milestone:** M001

## Description

Generate 4 optimization reports in `drafts/reports/study-motivation-scientific-methods/` covering SEO analysis, meta element analysis, keyword analysis, and internal link analysis. Each report must contain actual analysis data from the article, not stubs. Use content_scorer.py dimension data and direct article analysis to populate reports.

## Steps

1. **Create report directory**: `mkdir -p drafts/reports/study-motivation-scientific-methods/`

2. **Generate SEO analysis report** (`seo-analysis.md`): Run content_scorer.py and extract the `seo` dimension data. Include: H1/H2 structure check, keyword in first 100 words, meta title/description length assessment, word count, overall SEO score with recommendations.

3. **Generate meta analysis report** (`meta-analysis.md`): Extract and evaluate frontmatter meta elements. Include: title tag (length, keyword presence), meta description (length, keyword presence, call-to-action), slug, tags, categories. Compare against SEO guidelines (H1 60자, meta description 150-160자).

4. **Generate keyword analysis report** (`keyword-analysis.md`): Calculate keyword density for primary keyword "공부 동기부여 방법" and secondary keywords. Include: keyword counts, density percentages, placement locations (H1, H2, body, meta), recommendations for density optimization.

5. **Generate internal link analysis report** (`internal-link-analysis.md`): Inventory all internal links in the article. Include: link count, anchor text, target URLs, contextual relevance assessment, comparison against `context/internal-links-map.md` for additional opportunities.

## Must-Haves

- [ ] `drafts/reports/study-motivation-scientific-methods/seo-analysis.md` exists with actual scorer data
- [ ] `drafts/reports/study-motivation-scientific-methods/meta-analysis.md` exists with frontmatter evaluation
- [ ] `drafts/reports/study-motivation-scientific-methods/keyword-analysis.md` exists with density calculations
- [ ] `drafts/reports/study-motivation-scientific-methods/internal-link-analysis.md` exists with link inventory

## Verification

```bash
# All 4 reports exist and are non-empty
python -c "
import os
report_dir = 'drafts/reports/study-motivation-scientific-methods'
expected = ['seo-analysis.md', 'meta-analysis.md', 'keyword-analysis.md', 'internal-link-analysis.md']
for f in expected:
    path = os.path.join(report_dir, f)
    assert os.path.exists(path), f'Missing: {path}'
    size = os.path.getsize(path)
    assert size > 200, f'{f} too small ({size} bytes)'
    print(f'{f}: {size} bytes — OK')
print('All reports present — PASS')
"
```

## Inputs

- `site/content/posts/study-motivation-scientific-methods.md` — the article to analyze
- `context/internal-links-map.md` — internal link targets for link analysis
- `context/seo-guidelines.md` — SEO rules for compliance checking

## Expected Output

- `drafts/reports/study-motivation-scientific-methods/seo-analysis.md`
- `drafts/reports/study-motivation-scientific-methods/meta-analysis.md`
- `drafts/reports/study-motivation-scientific-methods/keyword-analysis.md`
- `drafts/reports/study-motivation-scientific-methods/internal-link-analysis.md`
