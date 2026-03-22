# Knowledge Register

<!-- Append-only. Read at the start of every unit. -->

| # | When | Category | Finding | Impact |
|---|------|----------|---------|--------|
| K001 | M001/S02 | bug-workaround | content_scrubber `_clean_whitespace` method collapses YAML indentation (e.g. `  primary_keyword` → `primary_keyword`). Always split content at `---` delimiters and scrub body only, never frontmatter. | Prevents frontmatter corruption on every scrub operation. |
| K002 | M001/S02 | scorer-limitation | content_scorer SEO dimension uses English-centric metrics: meta title character count (50-60 target) and word count (2,000 minimum). Korean characters display ~2x wider and Korean has higher character density. A well-written Korean article may score 65/100 on SEO dimension — this is expected, not a defect. | Prevents false optimization attempts on Korean content. |
| K003 | M001/S02 | scorer-limitation | content_scorer humanity dimension penalizes for "lacks contractions" (-10 points). Korean does not use English contractions. This is a false signal for Korean content. | Do not attempt to fix this score for Korean articles. |
| K004 | M001/S02 | dependency | content_scorer requires `textstat` pip package (`pip install textstat`). This is not in the default Python environment. | Install before running scorer in fresh environments. |
