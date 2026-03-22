# S01 (Full Article Draft) — Research

**Date:** 2026-03-22
**Depth:** Light — well-established patterns, comprehensive research brief already exists

## Summary

S01 is straightforward content creation: write a 3,500-4,500자 Korean blog post about 공부 동기부여 방법 and save it as a Hugo markdown file. All inputs are ready — the research brief at `research/brief-study-motivation-methods-2026-03-22.md` provides the complete outline (7 strategies + 66일 roadmap + 응급 처방 + 오해 sections), all statistical data with sources, meta elements, and internal linking targets. The reference post `site/content/posts/ai-agent-trends-2026.md` shows the exact frontmatter structure and formatting conventions.

The only judgment calls are: (1) fitting 7 strategies + supporting sections within 3,500-4,500자, which requires concise treatment per strategy (~200-300자 each), and (2) selecting 2-3 CTA link targets from the internal-links-map that fit naturally in a non-tech self-improvement article.

## Recommendation

Write the article in a single task following the research brief outline exactly. Use the `ai-agent-trends-2026.md` frontmatter as the structural template. Keep each of the 7 strategies concise (focus on one key data point + one actionable step each) to stay within the 4,500자 ceiling. Place mini-stories at: (1) introduction/도입부, (2) middle strategy section, (3) near the 66일 roadmap. Use "프롬프트 엔지니어링 실전 가이드" and "AI 기반 SEO 콘텐츠 전략" as CTA targets since the brief already identifies them, plus optionally "AI 에이전트 기술 동향" for a third. Per D001, avoid forced AI connections — use "시스템적 사고" and "분석적 접근" as the light tech touch.

## Implementation Landscape

### Key Files

- `research/brief-study-motivation-methods-2026-03-22.md` — **Primary input.** Complete outline, 7 statistics, expert sources, meta elements preview, hook development, internal linking strategy. Use as-is; do not re-research.
- `site/content/posts/ai-agent-trends-2026.md` — **Frontmatter template.** Copy the YAML structure exactly: `title`, `date`, `draft`, `tags`, `categories`, `description`, `summary`, `ShowToc`, `TocOpen`, `seo` block (primary_keyword, secondary_keywords, word_count, quality_score, last_optimized, review_required).
- `context/brand-voice.md` — Tone rules: 경어체, 사실 기반, 이모지 미사용, 과장 없음, 기술 용어 영문 유지.
- `context/style-guide.md` — Format rules: 경어체(~합니다), 간결 문장, 기술 용어 첫 등장 시 영한 병기, 문단 2-4문장 MAX.
- `context/seo-guidelines.md` — H1 60자 이내, 키워드 밀도 1-2%, 내부 링크 3-5개, 메타 설명 150-160자.
- `context/internal-links-map.md` — CTA targets. Brief suggests: `/posts/prompt-engineering-practical-guide/` ("체계적 접근법" 맥락), `/posts/ai-seo-content-strategy/` ("시스템적 사고" 맥락).
- `.claude/commands/write.md` — Defines the full write workflow, quality requirements (hook types, APP formula, mini-stories 2-3, CTAs 2-3, paragraphs ≤4 sentences), and output frontmatter format.
- `context/writing-examples.md` — Template only (unfilled). No exemplar posts available; rely on `ai-agent-trends-2026.md` as the sole style reference.

### Frontmatter Spec (from reference post)

```yaml
---
title: "공부 동기부여 방법: 뇌과학이 증명한 7가지 실전 전략"
date: 2026-03-22
draft: true
tags: ["공부 동기부여", "학습 심리학", "도파민", "자기결정이론", "포모도로"]
categories: ["자기계발"]
description: "공부 의욕이 없을 때, 감정적 자극 대신 뇌과학과 심리학 연구가 증명한 동기부여 전략 7가지. 도파민 보상 시스템, 66일 습관 형성법, 포모도로 기법까지."
summary: "뇌과학과 심리학 연구 데이터가 증명한 공부 동기부여 7가지 실전 전략을 소개합니다."
ShowToc: true
TocOpen: true
seo:
  primary_keyword: "공부 동기부여 방법"
  secondary_keywords: ["공부 의욕 없을때", "도파민 공부법", "공부 습관 만들기"]
  word_count: 0
  quality_score: 0
  last_optimized: null
  review_required: false
---
```

Note: `word_count` should be updated to actual character count after writing. `draft: true` always.

### Content Structure (from brief outline, compressed for 자 budget)

| Section | Est. 자 | Key elements |
|---------|---------|-------------|
| 도입 (Hook + APP) | 300-400 | Hook from brief, mini-story #1 (수능 준비생), value proposition |
| H2: 공부 의욕 사라지는 이유 | 400-500 | 도파민 보상 시스템, 게임 vs 공부, Nature 2026 연구, [image: 도파민 보상 루프] |
| H2: 내재적 vs 외재적 동기 | 300-400 | SDT 3대 욕구, 메타분석 r=.298 vs r=.176 |
| H2: 7가지 전략 | 1,200-1,500 | ~200자/전략, 포모도로 r=0.72 강조, CTA #1 배치 |
| H2: 66일 로드맵 | 400-500 | 3단계, 7일 연속→3.6배 데이터, mini-story #2 (직장인 자격증), [image: 66일 타임라인] |
| H2: 응급 처방 5가지 | 300-400 | 5분 규칙 등, CTA #2 배치 |
| H2: 오해 3가지 | 300-400 | 시스템 vs 의지력, mini-story #3 (취준생) |
| 결론 | 200-300 | 핵심 요약, 마이크로 목표 CTA, CTA #3 배치 |
| **Total** | **3,400-4,400** | Within 3,500-4,500 target with minor adjustments |

### Mini-Stories Placement (R007)

1. **도입부** — 수능 준비생 who tries emotional motivation YouTube videos every night but burns out in 3 days. Discovers systematic approach instead.
2. **66일 로드맵 section** — 직장인 preparing for 정보처리기사 자격증, starts with 15분/day, reaches automated habit by day 50.
3. **오해 section** — 취준생 who over-plans study schedules perfectly but never executes. Learns "불완전한 실행 > 완벽한 계획".

All three use Korean context (수능, 자격증, 취업) per R007.

### CTA Placement (R006)

| Location | Target | Context |
|----------|--------|---------|
| After 전략 2-3 (포모도로) | `/posts/prompt-engineering-practical-guide/` | "체계적 접근법으로 문제를 분해하는 방법" |
| 응급 처방 section | `/posts/ai-seo-content-strategy/` | "시스템적 사고로 목표를 달성하는 전략" |
| 결론 | `/posts/ai-agent-trends-2026/` | "AI가 자율적으로 학습하는 원리" (optional 3rd) |

### Image Placeholders (R008)

- `[image: 도파민 보상 루프 다이어그램 - 게임의 즉각 보상 vs 공부의 지연 보상 비교]`
- `[image: 66일 습관 형성 타임라인 - 시작(1-7일) → 적응(8-21일) → 자동화(22-66일)]`

### Build Order

1. **Write the complete article** — single file `site/content/posts/study-motivation-scientific-methods.md` with frontmatter + body following the outline above.
2. **Measure character count** — `python -c "..."` on the body text (excluding frontmatter). Adjust if outside 3,500-4,500 range.
3. **Validate frontmatter** — confirm YAML parses correctly and matches reference post structure.

This is a single-task slice. No decomposition needed.

### Verification Approach

1. **File existence**: `ls site/content/posts/study-motivation-scientific-methods.md`
2. **Character count**: Strip frontmatter, count Korean characters. Must be 3,500-4,500.
   ```bash
   python3 -c "
   import re
   text = open('site/content/posts/study-motivation-scientific-methods.md').read()
   body = re.split(r'^---\s*$', text, maxsplit=2, flags=re.MULTILINE)[2]
   body_clean = re.sub(r'\s+', '', body)
   print(f'Character count: {len(body_clean)}')
   "
   ```
3. **Frontmatter validity**: Parse YAML and confirm all required fields exist.
   ```bash
   python3 -c "
   import yaml, re
   text = open('site/content/posts/study-motivation-scientific-methods.md').read()
   fm = re.split(r'^---\s*$', text, maxsplit=2, flags=re.MULTILINE)[1]
   data = yaml.safe_load(fm)
   required = ['title','date','draft','tags','categories','description','summary','ShowToc','TocOpen','seo']
   missing = [k for k in required if k not in data]
   print(f'Missing fields: {missing}' if missing else 'All fields present')
   "
   ```
4. **Content checks** (grep-based):
   - `grep -c '공부 동기부여' file` — primary keyword appears multiple times
   - `grep -c '\[image:' file` — ≥2 image placeholders
   - `grep -c '/posts/' file` — ≥2 internal link CTAs
   - Verify 7 strategies exist (7 H3s under the 전략 H2)

## Constraints

- 경어체 only (~합니다, ~입니다). No 반말.
- 이모지 금지 (brand-voice rule).
- 기술 용어 첫 등장 시 영한 병기: "자기결정이론(Self-Determination Theory, SDT)", "도파민(Dopamine)", "포모도로(Pomodoro)" etc.
- 문단 최대 4문장 (write command rule).
- `draft: true` always (publishing is a separate `/publish` step).
- D001 decision: light tech touch only. No forced AI references. Use "시스템적 사고", "과학적 접근", "분석적 프레임워크" as natural bridges to blog identity.

## Common Pitfalls

- **Character count overshoot** — 7 strategies + 66일 roadmap + 응급 처방 + 오해 is a lot of content. Each strategy must be tight (~200자: one stat + one actionable step). Cut H3 sub-headings within strategies if needed; use bold inline labels instead.
- **AI watermark phrases in Korean** — The content_scorer detects English AI phrases (landscape, leverage, seamless). For Korean, avoid: "오늘날", "~에 있어서", "살펴보겠습니다", "알아보도록 하겠습니다". Write direct, declarative Korean.
- **CTA forced feel** — The article is about study motivation, not AI. CTAs to AI blog posts must use bridging context ("체계적 사고", "시스템적 접근") not direct AI mentions. If a link feels forced, drop it.
