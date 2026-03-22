---
estimated_steps: 4
estimated_files: 1
skills_used: []
---

# T01: Fix article compliance gaps — frontmatter, image placeholders, word count

**Slice:** S01 — Full Article Draft
**Milestone:** M001

## Description

The article `site/content/posts/study-motivation-scientific-methods.md` already exists with comprehensive content covering all 7 strategies, research citations, mini-stories, and CTAs. Three compliance gaps remain:

1. **`draft: false`** must be changed to **`draft: true`** (R004 — articles start as drafts; publishing is a separate step)
2. **Zero `[image:]` placeholders** — need ≥2 placeholders at infographic positions (R008)
3. **`word_count: 3800`** in frontmatter is incorrect — actual body character count is ~6,891 and must be updated

## Steps

1. **Fix `draft` field**: In the YAML frontmatter, change `draft: false` to `draft: true`.

2. **Insert image placeholder #1**: After the subsection "### 게임에는 빠지고 공부에는 안 빠지는 이유" (after the 민수 mini-story paragraph, before "### 2026년 Nature 연구가 밝힌 동기의 브레이크"), insert on its own line:
   ```
   [image: 도파민 보상 루프 다이어그램 - 게임의 즉각 보상 vs 공부의 지연 보상 비교]
   ```

3. **Insert image placeholder #2**: After the heading "## 공부 습관 만들기: 66일 습관 형성 로드맵" and its introductory paragraph (the Phillippa Lally reference), before "### 1-7일: 시작 단계", insert on its own line:
   ```
   [image: 66일 습관 형성 타임라인 - 시작(1-7일) → 적응(8-21일) → 자동화(22-66일)]
   ```

4. **Update `word_count`**: After inserting the image placeholders, measure the actual body character count (excluding frontmatter and whitespace) using:
   ```bash
   python -c "
   import re
   text = open('site/content/posts/study-motivation-scientific-methods.md').read()
   body = re.split(r'^---\s*$', text, maxsplit=2, flags=re.MULTILINE)[2]
   body_clean = re.sub(r'\s+', '', body)
   print(len(body_clean))
   "
   ```
   Update the `word_count` value in frontmatter to this number.

## Must-Haves

- [ ] `draft: true` in frontmatter
- [ ] ≥2 `[image: ...]` placeholders in article body
- [ ] `word_count` in frontmatter matches actual body character count (±50)

## Verification

Run these checks — all must pass:

```bash
# 1. File exists
test -f site/content/posts/study-motivation-scientific-methods.md && echo "PASS: file exists"

# 2. Frontmatter valid, draft is true
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
assert count >= 2, f'Image placeholders: {count}, need >=2'
print(f'Image placeholders: {count} — PASS')
"

# 4. Internal link CTAs ≥2
python -c "
text = open('site/content/posts/study-motivation-scientific-methods.md').read()
count = text.count('/posts/')
assert count >= 2, f'Internal links: {count}, need >=2'
print(f'Internal links: {count} — PASS')
"

# 5. 7 strategies exist
python -c "
import re
text = open('site/content/posts/study-motivation-scientific-methods.md').read()
strategies = re.findall(r'^### 전략 \d', text, re.MULTILINE)
assert len(strategies) == 7, f'Strategies: {len(strategies)}, need 7'
print(f'Strategies: {len(strategies)} — PASS')
"
```

## Inputs

- `site/content/posts/study-motivation-scientific-methods.md` — existing article with 3 compliance gaps

## Expected Output

- `site/content/posts/study-motivation-scientific-methods.md` — fixed article with `draft: true`, 2 image placeholders, correct `word_count`
