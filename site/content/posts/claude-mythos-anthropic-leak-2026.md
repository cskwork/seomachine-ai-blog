---
title: "Claude Mythos 유출 정리: Anthropic이 만든 역대 최강 AI 모델의 모든 것"
date: 2026-03-29
draft: false
tags: ["Claude Mythos", "Anthropic", "AI 모델 유출", "Capybara", "사이버보안 AI", "AI 최신 뉴스 2026", "Claude Opus 후속 모델"]
categories: ["AI 동향"]
description: "2026년 3월 26일 데이터 유출로 드러난 Anthropic의 차세대 AI 모델 Claude Mythos(코드명 Capybara). 유출 경위, 핵심 성능, 사이버보안 논란, 시장 반응까지 검증된 정보만 정리했습니다."
summary: "Anthropic의 CMS 설정 오류로 유출된 Claude Mythos는 Opus 위의 새로운 4번째 티어 모델입니다. 코딩, 추론, 사이버보안에서 '극적으로 높은' 성능을 보이며, 사이버보안주 급락을 촉발했습니다."
ShowToc: true
TocOpen: true
seo:
  primary_keyword: "Claude Mythos"
  secondary_keywords: ["Claude Mythos 유출", "Anthropic Capybara", "Claude Mythos 성능", "Claude Mythos 출시일", "사이버보안 AI 모델"]
  word_count: 0
  quality_score: 0
  last_optimized: null
  review_required: false
---

2026년 3월 26일, AI 업계에서 올해 가장 큰 사건이 터졌습니다. Anthropic의 콘텐츠 관리 시스템(CMS) 설정 오류로 약 3,000건의 미공개 자료가 암호화 없이 공개 검색이 가능한 상태로 노출된 것입니다. 그 안에는 아직 발표하지 않은 차세대 모델 **Claude Mythos**의 드래프트 블로그 포스트가 포함되어 있었습니다.

Fortune이 독점 보도한 이 사건 이후 Anthropic은 모델의 존재를 공식 확인했습니다. 유출된 내용과 Anthropic의 공식 성명, 그리고 이후 보도를 종합해 검증된 팩트만 정리합니다.

## 유출 경위: 어떻게 드러났나

LayerX Security의 보안 연구원 Roy Paz와 캠브리지 대학교의 Alexandre Pauwels가 독립적으로 이 노출을 발견했습니다. Anthropic의 CMS에 설정 오류가 있었고, 약 3,000건의 미발행 블로그 자산이 암호화 없이 공개 검색 가능한 데이터 저장소에 방치되어 있었습니다.

흥미로운 점은 같은 내용의 드래프트 블로그 포스트가 두 버전으로 발견되었다는 것입니다. 하나는 "Mythos"라는 이름을, 다른 하나는 "Capybara"라는 이름을 사용했습니다. Anthropic이 모델명을 최종 결정하지 못한 상태에서 유출이 발생한 것으로 보입니다.

Anthropic은 이를 "인적 오류(human error)"로 인정하고, 유출된 문서는 "발행을 검토 중이던 초기 드래프트"라고 설명했습니다.

## Claude Mythos란 무엇인가

Anthropic의 공식 성명은 이렇습니다.

> "We're developing a general purpose model with meaningful advances in reasoning, coding, and cybersecurity. Given the strength of its capabilities, we're being deliberate about how we release it. We consider this model a step change and the most capable we've built to date."

핵심을 정리하면 다음과 같습니다.

### 새로운 4번째 티어: Capybara

기존 Claude 라인업은 Haiku(경량) – Sonnet(균형) – Opus(최고 성능) 3단계 구조였습니다. Mythos는 Opus 위에 새로운 **Capybara 티어**를 추가합니다. 기존 모델을 대체하는 것이 아니라 상위 티어를 신설하는 구조입니다.

| 티어 | 포지션 | 대표 모델 |
|------|--------|----------|
| Haiku | 경량·빠른 응답 | Claude Haiku 4.5 |
| Sonnet | 균형 성능 | Claude Sonnet 4.6 |
| Opus | 깊은 추론 | Claude Opus 4.6 |
| **Capybara** | **최상위 성능** | **Claude Mythos** |

### 확인된 성능 지표

유출된 드래프트에 따르면 Claude Mythos는 [Claude Opus 4.6](/posts/ai-model-releases-2026/) 대비 다음 영역에서 "극적으로 높은(dramatically higher)" 점수를 기록했습니다.

- **소프트웨어 코딩**: 기존 최고 수준이었던 Opus 4.6(SWE-Bench Verified 80.8%)을 크게 상회
- **학술 추론**: 복잡한 다단계 추론 능력에서 압도적 향상
- **사이버보안**: "현재 다른 어떤 AI 모델보다 사이버 역량에서 크게 앞서 있다"

유출 문서에서 언급된 6대 핵심 역량은 다음과 같습니다.

1. 자동 취약점 발견
2. 초고난도 다단계 추론
3. 대규모 코드베이스 리팩토링
4. 엔터프라이즈 보안 감사
5. 고급 에이전트 워크플로우
6. 제로데이 취약점 식별

### 미확인 정보: 10조 파라미터

일부 매체(Geeky Gadgets 등)는 Mythos의 파라미터 수가 약 **10조(10 trillion)**에 달한다고 보도했습니다. 사실이라면 GPT-4의 추정치(약 1.7조)의 6배에 달하는 규모입니다. 다만 **Anthropic이 이 수치를 공식 확인한 적은 없습니다.** 훈련 비용은 약 100억 달러로 추정되고 있으나 이 역시 미확인입니다.

## 사이버보안 논란: 왜 시장이 흔들렸나

Claude Mythos를 둘러싼 가장 큰 논란은 사이버보안 역량입니다. 유출된 드래프트의 원문은 이렇습니다.

> "It presages an upcoming wave of models that can exploit vulnerabilities in ways that far outpace the efforts of defenders."

방어자의 노력을 훨씬 능가하는 속도로 취약점을 공격할 수 있는 모델의 물결이 다가오고 있다는 경고입니다. Stifel의 애널리스트 Adam Borg는 이 모델이 "일반 해커를 국가 수준의 공격자로 격상시킬 수 있는 궁극의 해킹 도구"가 될 가능성을 언급했습니다.

### 시장 반응

유출 소식이 전해진 3월 27일, 사이버보안 관련 주식이 일제히 하락했습니다.

| 종목 | 하락폭 |
|------|--------|
| CrowdStrike (CRWD) | –7% |
| Palo Alto Networks (PANW) | –6% |
| Zscaler (ZS) | –4.5% |
| Tenable | –9% |
| SentinelOne | –6% |
| Okta | –7% |
| iShares Cybersecurity ETF | –4.5% |

비트코인과 소프트웨어 주식도 동반 하락하면서, AI 모델 하나의 유출이 금융 시장 전체에 파급 효과를 미친 이례적인 사례가 되었습니다.

그런데 여기서 아이러니한 상황이 있습니다. "전례 없는 사이버보안 위협"을 제기하는 모델의 존재가 정작 **기본적인 보안 설정 미스로 유출**되었다는 점입니다. Hacker News에서도 이 점이 가장 많이 지적되었습니다.

## 출시 일정과 가격: 언제, 얼마에 쓸 수 있나

### 현재 상태

- **일반 공개 아님**: Claude.ai, API 어디에서도 접근 불가
- **제한적 얼리 액세스**: 사이버 방어 분야 조직 중심으로 소규모 테스트 중
- **Anthropic 공식 입장**: "신중하게 출시할 것(being deliberate about how we release it)"

### 예상 가격

공식 가격은 없습니다. Anthropic은 "서빙에 매우 비용이 많이 들고, 고객에게도 매우 비쌀 것"이라고 밝혔습니다. 기존 티어 간 약 5배의 가격 배수를 적용하면 다음과 같이 추정됩니다.

| 티어 | 입력 ($/M 토큰) | 출력 ($/M 토큰) |
|------|----------------|----------------|
| Opus 4.6 | $15 | $75 |
| **Capybara (추정)** | **$30–75** | **$150–375** |

### 출시 시점 예측

Polymarket 예측 시장에서는 2026년 6월 30일까지 공개될 확률을 **75%**로 보고 있습니다. 일부 분석가는 Anthropic의 IPO 시점(2026년 10월경 추정)에 맞출 가능성도 언급합니다.

## Claude Opus 4.6과의 차이

Claude Mythos는 Opus 4.6의 단순 업그레이드가 아닙니다. 기존 최상위 모델 위에 완전히 새로운 티어를 신설한 것입니다. [기존 AI 모델 비교 분석](/posts/ai-model-releases-2026/)에서 다뤘던 Opus 4.6이 이미 SWE-Bench 80.8%, GPQA Diamond 91.3%로 코딩과 추론에서 최고 수준이었습니다.

Mythos는 이 수치를 "극적으로" 상회한다고 합니다. 구체적 벤치마크 수치는 아직 공개되지 않았지만, 코딩과 추론 외에 사이버보안이라는 새로운 축이 추가된 것이 가장 큰 차별점입니다.

| 비교 항목 | Claude Opus 4.6 | Claude Mythos |
|-----------|-----------------|---------------|
| 티어 | Opus (3번째) | Capybara (4번째) |
| 코딩 | SWE-Bench 80.8% | "극적으로 높음" (수치 미공개) |
| 추론 | GPQA Diamond 91.3% | "극적으로 높음" (수치 미공개) |
| 사이버보안 | 일반 수준 | "모든 AI 모델 중 최고" |
| 가격 | $15/$75 per M tokens | 2–5배 이상 (추정) |
| 공개 상태 | 정식 출시 | 비공개 테스트 중 |

## AI 경쟁 구도에 미치는 영향

Mythos가 공개되면 [GPT-5.4, Gemini 3.1 Pro와의 경쟁 구도](/posts/ai-model-releases-2026/)가 크게 변합니다. 이미 Opus 4.6이 코딩에서 GPT-5.4를 근소하게 앞서고 있었는데, Mythos는 그 격차를 결정적으로 벌릴 수 있습니다.

다만 핵심 변수가 있습니다.

**가격**: Mythos가 아무리 뛰어나도 Opus의 3–5배 가격이라면, 대부분의 실무 워크로드에서 선택지가 되기 어렵습니다. 고도의 추론이나 보안 감사 같은 특수 목적에 한정될 가능성이 높습니다.

**접근성**: 현재 사이버 방어 분야에만 제한적으로 제공되고 있어, 일반 개발자가 실제로 사용할 수 있기까지는 상당한 시간이 걸릴 수 있습니다.

**경쟁사 대응**: OpenAI와 Google이 가만히 있지 않을 것입니다. Mythos 유출로 자극받아 자사 최상위 모델의 출시를 앞당길 가능성이 있습니다.

## 지금 확인된 것과 확인되지 않은 것

정보의 신뢰도를 구분하는 것이 중요합니다.

### 확인된 사실 (Anthropic 공식 확인 또는 다수 언론 교차 검증)

- Mythos는 실존하며 현재 테스트 중
- CMS 설정 오류로 약 3,000건의 미공개 자료가 유출
- Opus 위의 새로운 티어(Capybara) 신설
- 코딩, 추론, 사이버보안에서 "극적으로 높은" 성능
- 사이버 방어 분야 조직에 제한적 얼리 액세스 제공 중
- 서빙 비용이 매우 높음

### 미확인 정보 (보도는 있으나 공식 확인 없음)

- 10조 파라미터 규모
- 훈련 비용 100억 달러
- 구체적 벤치마크 점수
- 정확한 출시 일정
- 정확한 가격

## 정리

Claude Mythos는 AI 모델 경쟁의 새로운 국면을 보여줍니다. 단순히 "더 똑똑한 모델"이 아니라, 사이버보안이라는 민감한 영역에서의 압도적 성능이 사회적·경제적 파급력을 가진다는 것을 증명했습니다. AI 모델 하나의 유출이 사이버보안주 14.5조 원 시가총액 증발을 일으킨 사례는 전례가 없습니다.

Anthropic이 "신중한 출시"를 약속한 만큼, 실제 공개까지는 시간이 걸릴 것입니다. 하지만 Mythos의 존재 자체가 이미 시장을 움직이고 있습니다. [AI 모델 비교 2026](/posts/ai-model-releases-2026/)에서 다룬 3강 구도는 Mythos 출시와 함께 다시 한번 재편될 가능성이 높습니다.

---

**참고 소스**

- [Fortune – Anthropic 'Mythos' AI model revealed in data leak (2026.03.26)](https://fortune.com/2026/03/26/anthropic-says-testing-mythos-powerful-new-ai-model-after-data-leak-reveals-its-existence-step-change-in-capabilities/)
- [Fortune – Anthropic leaked AI model poses unprecedented cybersecurity risks (2026.03.27)](https://fortune.com/2026/03/27/anthropic-leaked-ai-mythos-cybersecurity-risk/)
- [CNBC – Cybersecurity stocks fall on Anthropic Mythos report (2026.03.27)](https://www.cnbc.com/2026/03/27/anthropic-cybersecurity-stocks-ai-mythos.html)
- [The Decoder – Anthropic leak reveals "Claude Mythos" (2026.03.27)](https://the-decoder.com/anthropic-leak-reveals-new-model-claude-mythos-with-dramatically-higher-scores-on-tests-than-any-previous-model/)
- [SiliconANGLE – Claude Mythos advanced reasoning features (2026.03.27)](https://siliconangle.com/2026/03/27/anthropic-launch-new-claude-mythos-model-advanced-reasoning-features/)
- [Futurism – Anthropic leaked model with unprecedented cybersecurity risks (2026.03.27)](https://futurism.com/artificial-intelligence/anthropic-step-change-new-model-claude-mythos)
- [CoinDesk – Claude Mythos leak cybersecurity nightmare (2026.03.27)](https://www.coindesk.com/markets/2026/03/27/anthropic-s-massive-claude-mythos-leak-reveals-a-new-ai-model-that-could-be-a-cybersecurity-nightmare)
- [Decrypt – Anthropic's most capable AI model Claude Mythos leaks (2026.03.27)](https://decrypt.co/362606/anthropic-most-capable-ai-model-claude-mythos-leaks)
