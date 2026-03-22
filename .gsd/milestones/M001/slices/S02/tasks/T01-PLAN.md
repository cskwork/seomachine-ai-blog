---
estimated_steps: 3
estimated_files: 1
skills_used: []
---

# T01: Run scrubber and scorer, update frontmatter

**Slice:** S02 — Optimize & Finalize
**Milestone:** M001

## Description

Run the content scrubber (R010) and content scorer (R009) on the article, then update frontmatter fields to reflect actual results. Critical: the scrubber's `_clean_whitespace` method damages YAML indentation, so scrub only the article body, not the frontmatter.

## Steps

1. **Scrub article body only**: Read the file, split at YAML frontmatter `---` delimiters into 3 parts (empty, frontmatter, body). Run `ContentScrubber.scrub()` on the body part only. Rejoin and write back.

   ```python
   import sys, re
   sys.path.insert(0, 'data_sources/modules')
   from content_scrubber import ContentScrubber

   text = open('site/content/posts/study-motivation-scientific-methods.md', 'r', encoding='utf-8').read()
   parts = re.split(r'^---\s*$', text, maxsplit=2, flags=re.MULTILINE)
   # parts[0] = empty before first ---, parts[1] = frontmatter, parts[2] = body

   scrubber = ContentScrubber()
   cleaned_body, stats = scrubber.scrub(parts[2])
   print('Scrub stats:', stats)

   result = parts[0] + '---\n' + parts[1] + '---' + cleaned_body
   open('site/content/posts/study-motivation-scientific-methods.md', 'w', encoding='utf-8').write(result)
   ```

2. **Run content scorer**: Score the article and capture the composite score.

   ```python
   import sys, re, yaml
   sys.path.insert(0, 'data_sources/modules')
   from content_scorer import ContentScorer

   content = open('site/content/posts/study-motivation-scientific-methods.md', 'r', encoding='utf-8').read()
   fm = re.split(r'^---\s*$', content, maxsplit=2, flags=re.MULTILINE)[1]
   data = yaml.safe_load(fm)

   scorer = ContentScorer()
   meta = {
       'meta_title': data.get('title', ''),
       'meta_description': data.get('description', ''),
       'primary_keyword': data.get('seo', {}).get('primary_keyword', ''),
   }
   result = scorer.score(content, meta)
   print(scorer.format_report(result))
   ```

3. **Update frontmatter**: Set `quality_score` to the actual composite score (rounded to nearest 0.5) and `last_optimized` to `2026-03-22`. Use the `edit` tool for precise replacement of just those two YAML values.

## Must-Haves

- [ ] Scrubber ran on body only — frontmatter YAML indentation preserved
- [ ] `quality_score` in frontmatter matches actual scorer output (±1)
- [ ] `last_optimized` is set to today's date

## Verification

```bash
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
assert abs(fm_score - result['composite_score']) <= 1, f'FM score {fm_score} != actual {result[\"composite_score\"]}'
assert data['seo']['last_optimized'] is not None, 'last_optimized not set'
print(f'Score: {result[\"composite_score\"]} (FM: {fm_score}), last_optimized: {data[\"seo\"][\"last_optimized\"]} — ALL PASS')
"
```

## Inputs

- `site/content/posts/study-motivation-scientific-methods.md` — article from S01

## Expected Output

- `site/content/posts/study-motivation-scientific-methods.md` — scrubbed article with updated `quality_score` and `last_optimized`
