# Hugo SEO Content Pipeline

**Extracted:** 2026-03-28
**Context:** Hugo 블로그에서 SEO 최적화된 콘텐츠를 작성할 때

## Problem
AI가 리서치 없이 바로 글을 쓰면 generic한 콘텐츠가 나옴. 최적화 단계를 빠뜨리면 SEO 점수가 낮음.

## Solution
반드시 순차 파이프라인을 따름:

```
/research-serp → /article or /write → /optimize → /publish
```

각 단계의 산출물이 다음 단계의 입력:
- `research/` → SERP 분석 + 키워드 브리프
- `drafts/` → 초안 (draft: true)
- 최적화 에이전트 순차 실행: editor → keyword-mapper → meta-creator → seo-optimizer
- `published/` → 최종본 (draft: false)

## Front Matter Convention
```yaml
seo:
  primary_keyword: "..."
  secondary_keywords: ["...", "..."]
  word_count: integer
  quality_score: integer   # 0-100
  last_optimized: YYYY-MM-DD
  review_required: boolean
```

## When to Use
- 이 프로젝트에서 새 블로그 포스트 작성 시
- 기존 글 리라이트/최적화 시
- SEO 점수가 70 미만인 글 개선 시
