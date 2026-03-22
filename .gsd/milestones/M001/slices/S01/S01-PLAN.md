# S01: Full Article Draft

**Goal:** `site/content/posts/study-motivation-scientific-methods.md` exists with valid Hugo frontmatter, image placeholders, correct `draft: true`, and all R001-R008 requirements satisfied.
**Demo:** File passes all verification checks: frontmatter YAML valid with `draft: true`, ≥2 `[image:]` placeholders present, 2+ CTAs, 2+ mini-stories, 7 strategies with research citations.

## Must-Haves

- `draft: true` in frontmatter (R004)
- ≥2 `[image: ...]` placeholders at infographic positions (R008)
- `word_count` in frontmatter updated to actual character count (R004)
- 7가지 전략 with research data citations (R003)
- 2-3 내부 링크 CTAs (R006)
- 2-3 한국 상황 미니스토리 (R007)
- 경어체, no emoji, tech terms with English (R005)
- SEO keywords in frontmatter and body (R002)

## Verification

```bash
# 1. File exists
test -f site/content/posts/study-motivation-scientific-methods.md

# 2. Frontmatter validity — all required fields present, draft is true
python -c "
import re, yaml
text = open('site/content/posts/study-motivation-scientific-methods.md').read()
fm = re.split(r'^---\s*$', text, maxsplit=2, flags=re.MULTILINE)[1]
data = yaml.safe_load(fm)
assert data['draft'] == True, f'draft should be True, got {data[\"draft\"]}'
for k in ['title','date','tags','categories','description','summary','ShowToc','TocOpen','seo']:
    assert k in data, f'Missing field: {k}'
print('Frontmatter: PASS')
"

# 3. Image placeholders ≥2
python -c "
text = open('site/content/posts/study-motivation-scientific-methods.md').read()
count = text.count('[image:')
assert count >= 2, f'Image placeholders: {count}, need ≥2'
print(f'Image placeholders: {count} — PASS')
"

# 4. Internal link CTAs ≥2
python -c "
text = open('site/content/posts/study-motivation-scientific-methods.md').read()
count = text.count('/posts/')
assert count >= 2, f'Internal links: {count}, need ≥2'
print(f'Internal links: {count} — PASS')
"

# 5. 7 strategies exist (H3s under 7가지 전략 section)
python -c "
import re
text = open('site/content/posts/study-motivation-scientific-methods.md').read()
strategies = re.findall(r'^### 전략 \d', text, re.MULTILINE)
assert len(strategies) == 7, f'Strategies: {len(strategies)}, need 7'
print(f'Strategies: {len(strategies)} — PASS')
"
```

## Tasks

- [x] **T01: Fix article compliance gaps — frontmatter, image placeholders, word count** `est:20m`
  - Why: Article exists but has 3 requirement gaps — `draft: false` instead of `true` (R004), zero `[image:]` placeholders (R008), and incorrect `word_count` in frontmatter. All other requirements (R001-R003, R005-R007) are already satisfied.
  - Files: `site/content/posts/study-motivation-scientific-methods.md`
  - Do: (1) Change `draft: false` → `draft: true`. (2) Insert `[image: 도파민 보상 루프 다이어그램 - 게임의 즉각 보상 vs 공부의 지연 보상 비교]` after the 게임 vs 공부 subsection. (3) Insert `[image: 66일 습관 형성 타임라인 - 시작(1-7일) → 적응(8-21일) → 자동화(22-66일)]` before or after the 66일 로드맵 subsections. (4) Update `word_count` from 3800 to actual body character count.
  - Verify: Run the 5 verification checks from the Verification section above — all must PASS.
  - Done when: All 5 checks pass, file remains valid markdown.

## Files Likely Touched

- `site/content/posts/study-motivation-scientific-methods.md`
