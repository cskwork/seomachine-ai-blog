---
title: "Claude Code로 투자/재무 관리하기: 금융 MCP 서버 & 스킬 총정리 (2026)"
date: 2026-03-28T12:00:00
draft: false
tags: ["Claude Code", "MCP 서버", "금융", "투자", "포트폴리오", "핀테크", "재무 관리", "자산 관리"]
categories: ["실전 가이드"]
description: "2026년 3월 기준, Claude Code에서 사용 가능한 금융 MCP 서버, 투자 분석 스킬, 재무 관리 플러그인을 총정리합니다. Anthropic 공식 플러그인부터 Alpaca 실거래까지."
summary: "10개 리서치 에이전트로 GitHub, MCP 레지스트리, 공식 문서를 전수 조사한 결과, Claude Code 금융 생태계의 모든 것을 정리합니다. 공식 Anthropic 플러그인(5,600+ stars)부터 실거래 가능한 Alpaca MCP까지."
ShowToc: true
TocOpen: true
seo:
  primary_keyword: "Claude Code 금융 MCP"
  secondary_keywords: ["Claude Code 투자", "Claude Code 재무 관리", "금융 MCP 서버", "AI 투자 도구", "Claude Code 주식 분석"]
  word_count: 4500
  quality_score: 0
  last_optimized: null
  review_required: false
---

"주식 분석 리포트 만들어줘." 터미널에 이 한 마디를 치면, AI가 SEC 공시를 읽고, 재무제표를 분석하고, 기술적 지표를 계산해서 13페이지짜리 리포트를 PDF로 출력합니다.

공상과학이 아닙니다. 2026년 3월 현재, Claude Code에 금융 MCP 서버와 스킬을 연결하면 실제로 가능한 일입니다.

10개 리서치 에이전트를 병렬로 돌려 GitHub, MCP 레지스트리, 공식 문서, 커뮤니티를 전수 조사했습니다. 결론부터 말하면, **금융은 MCP 생태계에서 가장 빠르게 성장하는 카테고리**이며, Anthropic 공식 플러그인부터 실거래 가능한 브로커리지 연동까지 이미 실전 투입 가능한 도구들이 상당합니다.

## 바로 쓸 수 있는 추천 도구 5선

리서치 결과를 바탕으로, 용도별 최적의 도구를 먼저 추천합니다.

### 1. 종합 금융 분석: Anthropic 공식 Financial Services Plugins (5,600+ Stars)

**GitHub**: [anthropics/financial-services-plugins](https://github.com/anthropics/financial-services-plugins)

Anthropic이 직접 만든 금융 서비스 플러그인 마켓플레이스입니다. 5개 수직 영역을 커버합니다:

- **Financial Analysis** -- 재무 분석 핵심 도구 + MCP 데이터 커넥터
- **Investment Banking** -- `/comps`, `/earnings`, `/ic-memo` 슬래시 커맨드
- **Equity Research** -- 주식 리서치 워크플로우
- **Private Equity** -- 사모펀드 분석 프레임워크
- **Wealth Management** -- 포트폴리오 최적화, 세금 분석, 리밸런싱

마크다운 + JSON 기반이라 빌드 과정 없이 바로 설치됩니다. Claude Code와 Claude Cowork 모두 호환.

```bash
# 설치
git clone https://github.com/anthropics/financial-services-plugins.git
cp -r financial-services-plugins/.claude/skills/* ~/.claude/skills/
```

### 2. 주식 시장 데이터: Financial Datasets MCP (1,721 Stars)

**GitHub**: [financial-datasets/mcp-server](https://github.com/financial-datasets/mcp-server)

AI 에이전트를 위해 설계된 주식 시장 API입니다. 가장 많은 스타를 받은 금융 MCP 서버이며, 다음 데이터를 제공합니다:

- 손익계산서, 대차대조표, 현금흐름표
- 실시간/과거 주가 데이터
- 시장 뉴스

```json
{
  "mcpServers": {
    "financial-datasets": {
      "command": "uvx",
      "args": ["financial-datasets-mcp"],
      "env": {
        "FINANCIAL_DATASETS_API_KEY": "your-api-key"
      }
    }
  }
}
```

### 3. 실거래: Alpaca MCP Server (586 Stars)

**GitHub**: [alpacahq/alpaca-mcp-server](https://github.com/alpacahq/alpaca-mcp-server)

현존하는 **유일한 실거래 가능 MCP 서버**입니다. 주식, ETF, 크립토, 옵션 주문을 자연어로 실행할 수 있습니다. Alpaca의 공식 Trading API를 사용합니다.

**주의**: 실제 돈이 움직입니다. 반드시 페이퍼 트레이딩 모드에서 충분히 테스트한 후 사용하세요.

```bash
# 페이퍼 트레이딩 모드로 시작
export ALPACA_API_KEY="your-paper-key"
export ALPACA_SECRET_KEY="your-paper-secret"
export ALPACA_BASE_URL="https://paper-api.alpaca.markets"
```

### 4. 크립토 지갑: Coinbase AgentKit (1,182 Stars)

**GitHub**: [coinbase/agentkit](https://github.com/coinbase/agentkit)

Coinbase가 만든 공식 AI 에이전트 툴킷입니다. "Every AI Agent deserves a wallet"이라는 슬로건답게, MPC 지갑 생성, USDC 전송, 온체인 액션을 지원합니다.

### 5. 결제/상거래: Stripe AI (1,410 Stars)

**GitHub**: [stripe/ai](https://github.com/stripe/ai)

공식 Stripe MCP 서버입니다. 결제, 고객, 상품, 구독 관리를 Claude Code에서 직접 할 수 있습니다. 원격(`mcp.stripe.com`) 또는 로컬(`npx @stripe/mcp`) 두 가지 방식으로 사용 가능합니다.

## 용도별 금융 MCP 서버 전체 지도

### 투자 분석 / 주식 리서치

| 서버 | Stars | 핵심 기능 |
|------|-------|----------|
| [anthropics/financial-services-plugins](https://github.com/anthropics/financial-services-plugins) | 5,600+ | 공식. 5개 금융 수직 영역 종합 |
| [financial-datasets/mcp-server](https://github.com/financial-datasets/mcp-server) | 1,721 | 재무제표, 주가, 뉴스 |
| [alpacahq/alpaca-mcp-server](https://github.com/alpacahq/alpaca-mcp-server) | 586 | 실거래 (주식/ETF/크립토/옵션) |
| [whchien/ai-trader](https://github.com/whchien/ai-trader) | 530 | Backtrader 20+ 전략 백테스팅 |
| [atilaahmettaner/tradingview-mcp](https://github.com/atilaahmettaner/tradingview-mcp) | 476 | TradingView 기술적 지표 |
| [wshobson/maverick-mcp](https://github.com/wshobson/maverick-mcp) | 453 | 기술적 분석, 스크리닝, 포트폴리오 최적화 |
| [ferdousbhai/investor-agent](https://github.com/ferdousbhai/investor-agent) | 320 | Yahoo Finance 통합. 옵션/재무제표/센티먼트 |
| [polygon-io/mcp_polygon](https://github.com/polygon-io/mcp_polygon) | 270 | 공식 Polygon.io. 주식/지수/외환/옵션 |
| [OctagonAI/octagon-mcp-server](https://github.com/OctagonAI/octagon-mcp-server) | 110 | SEC 공시, 어닝콜, 사모시장 데이터 |
| [alphavantage/alpha_vantage_mcp](https://github.com/alphavantage/alpha_vantage_mcp) | 109 | 공식 Alpha Vantage. 100+ API |

### 크립토 / DeFi / 블록체인

| 서버 | Stars | 핵심 기능 |
|------|-------|----------|
| [coinbase/agentkit](https://github.com/coinbase/agentkit) | 1,182 | 공식 Coinbase. MPC 지갑, 온체인 |
| [mcpdotdirect/evm-mcp-server](https://github.com/mcpdotdirect/evm-mcp-server) | 370 | 30+ EVM 네트워크 (토큰, NFT, 스마트컨트랙트) |
| [base/base-mcp](https://github.com/base/base-mcp) | 340 | Base Network / Coinbase API |
| [hydra-mcp/hydra-mcp-solana](https://github.com/hydra-mcp/hydra-mcp-solana) | 252 | Solana MCP 통합 |
| [coingecko/mcp-server](https://github.com/coingecko/coingecko-typescript) | 공식 | 공식 CoinGecko. 200+ 체인, 8M+ 토큰 |
| [Nayshins/mcp-server-ccxt](https://github.com/Nayshins/mcp-server-ccxt) | 61 | CCXT 멀티 거래소 (Binance, Coinbase 등) |

### 결제 / 커머스

| 서버 | Stars | 핵심 기능 |
|------|-------|----------|
| [stripe/ai](https://github.com/stripe/ai) | 1,410 | 공식 Stripe. 결제/고객/구독 |
| [paypal/agent-toolkit](https://github.com/paypal/agent-toolkit) | 공식 | 공식 PayPal MCP |
| [razorpay/razorpay-mcp-server](https://github.com/razorpay/razorpay-mcp-server) | 공식 | 공식 Razorpay |
| [PaddleHQ/paddle-mcp-server](https://github.com/PaddleHQ/paddle-mcp-server) | 공식 | 상품 카탈로그, 빌링, 구독 |

### 회계 / 부기 / 세금

| 서버 | Stars | 핵심 기능 |
|------|-------|----------|
| [XeroAPI/xero-mcp-server](https://github.com/XeroAPI/xero-mcp-server) | 220 | 공식 Xero. 재무보고서, 송장, 은행거래 |
| [intuit/quickbooks-online-mcp-server](https://github.com/intuit/quickbooks-online-mcp-server) | 127 | 공식 QuickBooks. 실시간 회계 데이터 |
| [norman-finance/norman-mcp-server](https://github.com/norman-finance/norman-mcp-server) | 8 | 유럽 기업가용. 송장/부기/VAT 신고 |
| [dma9527/irs-taxpayer-mcp](https://github.com/dma9527/irs-taxpayer-mcp) | 신규 | 미국 세금 계산 39개 도구 |

### 개인 재무 / 예산 관리

| 서버 | Stars | 핵심 기능 |
|------|-------|----------|
| [akutishevsky/lunchmoney-mcp](https://github.com/akutishevsky/lunchmoney-mcp) | 55 | LunchMoney 개인 재무 앱 통합 |
| [ignaciohermosillacornejo/copilot-money-mcp](https://github.com/ignaciohermosillacornejo/copilot-money-mcp) | 18 | Copilot Money 앱 연동 |
| [klauern/mcp-ynab](https://github.com/klauern/mcp-ynab) | 6 | YNAB (You Need A Budget) |
| [lantip/mcp-personal-finance-tracker](https://github.com/lantip/mcp-personal-finance-tracker) | 4 | 수입/지출/예산 추적 |

### 기관급 데이터 제공자

기관 투자자나 금융 전문가를 위한 프리미엄 MCP 커넥터입니다.

| 제공자 | 설명 | 라이선스 |
|--------|------|----------|
| **LSEG (Refinitiv)** | 채권, 수익률곡선, FX, 금리스왑, 옵션, 주식 등 10개 도구 | 유료 |
| **FactSet** | 실시간 시장 데이터, 펀더멘탈 분석, 어닝 추정치 | 유료 |
| **S&P Global / Capital IQ Pro** | 기업 티어시트, 산업 거래 요약, 어닝콜 프리뷰 | 유료 |
| **Morningstar** | 리서치, 편집 콘텐츠, 데이터포인트 | 유료 |
| **Daloopa** | 헤지펀드 분석가용. 리서치 노트, Excel 모델, 피치덱 출력 | OAuth |

## Claude Code 전용 금융 스킬

MCP 서버 외에도, `.claude/skills/` 폴더에 설치하는 전용 스킬들이 있습니다.

### 투자 분석 스킬

| 스킬 | 설명 |
|------|------|
| [andrasp/claude-code-finance](https://github.com/andrasp/claude-code-finance) | Alpha Vantage + SEC EDGAR + yfinance. 펀더멘탈/비교/어닝 분석 워크플로우 |
| [tradermonty/claude-trading-skills](https://github.com/tradermonty/claude-trading-skills) | **50개 트레이딩 스킬**. 백테스팅, 기술적 차팅, 매크로 브리핑, 포지션 사이징 |
| [ai-sub-invest](https://github.com/ancs21/ai-sub-invest) | 21개 분석가 페르소나 (워렌 버핏, 찰리 멍거 스타일 등) 합의 기반 추천 |
| [OctagonAI/skills](https://github.com/OctagonAI/skills) | 에이전틱 금융 리서치 스킬 컬렉션 |
| [xvary-research/claude-code-stock-analysis-skill](https://github.com/xvary-research/claude-code-stock-analysis-skill) | `/analyze`, `/score`, `/compare` 커맨드 |

### 재무 모델링 스킬

| 스킬 | 설명 |
|------|------|
| [hammy15/claude-standard](https://github.com/hammy15/claude-standard) | DCF, IRR, Comps, 민감도 분석 CLI (`cc-std finance dcf`) |
| [jeremylongshore/excel-analyst-pro](https://github.com/jeremylongshore/excel-analyst-pro) | DCF 모델, LBO 분석, 분산 보고서, 피벗테이블 |

### 주식 딥리서치 에이전트

| 에이전트 | Stars | 설명 |
|---------|-------|------|
| [Claude-Code-Stock-Deep-Research-Agent](https://github.com/liangdabiao/Claude-Code-Stock-Deep-Research-Agent) | 252 | 8단계 실사 프레임워크, 28개 병렬 에이전트. `/stock-research AAPL`로 실행 |
| [claude-investor](https://github.com/martinxu9/claude-investor) | 실험적 | Claude Opus + Haiku 멀티모델 투자 분석 |

## MCP 서버 설치하는 법

Claude Code에서 MCP 서버를 사용하려면 `~/.claude.json` 또는 프로젝트의 `.claude/settings.json`에 설정을 추가합니다.

### 기본 설정 예시

```json
{
  "mcpServers": {
    "financial-datasets": {
      "command": "uvx",
      "args": ["financial-datasets-mcp"],
      "env": {
        "FINANCIAL_DATASETS_API_KEY": "your-key"
      }
    },
    "alpaca": {
      "command": "uvx",
      "args": ["alpaca-mcp-server"],
      "env": {
        "ALPACA_API_KEY": "your-key",
        "ALPACA_SECRET_KEY": "your-secret"
      }
    },
    "yahoo-finance": {
      "command": "uvx",
      "args": ["mcp-yahoo-finance"]
    }
  }
}
```

### 무료로 시작하기

API 키 없이 바로 사용할 수 있는 서버들입니다:

```bash
# 방법 1: pip으로 설치 (SEC Form 4, 의회 거래, 옵션 분석)
pip install mcp-financial-tools

# 방법 2: 글로벌 주식 데이터 (미국/중국/인도/영국/일본)
git clone https://github.com/AI-Hub-Admin/finance-agent-mcp-server
cd finance-agent-mcp-server && pip install -r requirements.txt

# 방법 3: SEC EDGAR 공시 데이터
git clone https://github.com/stefanoamorelli/sec-edgar-mcp
```

## 실전 활용 시나리오

### 시나리오 1: 주간 포트폴리오 리뷰

Anthropic 공식 Wealth Management 플러그인 + Financial Datasets MCP를 조합하면:

1. "내 포트폴리오 AAPL, MSFT, GOOGL 이번 주 성과 분석해줘"
2. AI가 각 종목의 주가 변동, 뉴스, 재무 지표를 수집
3. 리밸런싱 추천과 세금 영향 분석 리포트 생성

### 시나리오 2: 경쟁사 재무 비교

Financial Datasets + OctagonAI를 조합하면:

1. "Shopify vs BigCommerce 재무 비교 분석해줘"
2. SEC 공시에서 최신 10-K, 10-Q 데이터 추출
3. 매출 성장률, 마진, FCF 비교 테이블 자동 생성

### 시나리오 3: 크립토 포트폴리오 모니터링

Coinbase AgentKit + CoinGecko MCP를 조합하면:

1. "내 지갑 잔고 확인하고 상위 10개 코인 대비 성과 비교해줘"
2. 실시간 가격 데이터와 지갑 잔고를 크로스체크
3. 포트폴리오 배분 시각화 + 리밸런싱 제안

## 한국 시장 특화 도구

한국 투자자를 위한 도구도 있습니다:

- **[korea-stock-analyzer-mcp](https://github.com/Mrbaeksang/korea-stock-analyzer-mcp)** -- KOSPI/KOSDAQ 분석 전용 MCP 서버
- **[guangxiangdebizi/FinanceMCP](https://github.com/guangxiangdebizi/FinanceMCP)** -- Tushare API 기반 아시아 시장 데이터 (518 stars)

아직 stars가 높지 않지만, 한국어 금융 데이터를 다루는 몇 안 되는 MCP 서버입니다.

## 주의사항

금융 AI 도구를 사용할 때 반드시 알아야 할 점들입니다:

1. **투자 조언이 아닙니다** -- 이 도구들은 정보 제공 목적입니다. 투자 결정은 본인 책임입니다.
2. **실거래 전 반드시 테스트** -- Alpaca 등 실거래 MCP는 페이퍼 트레이딩 모드에서 충분히 검증하세요.
3. **API 키 보안** -- 금융 API 키는 절대 코드에 하드코딩하지 마세요. 환경 변수나 시크릿 매니저를 사용하세요.
4. **데이터 지연** -- 무료 API는 보통 15-20분 지연된 데이터를 제공합니다. 실시간 데이터가 필요하면 유료 플랜을 고려하세요.
5. **규제 확인** -- 자동 매매는 국가별 규제가 다릅니다. 한국에서는 금융위원회 규정을 확인하세요.

## 생태계 현황 분석

10개 리서치 에이전트의 조사 결과를 종합하면:

### 성숙한 영역
- **주식 시장 데이터**: Financial Datasets(1,721 stars), Yahoo Finance, Alpha Vantage 등 다수
- **결제/커머스**: Stripe(1,410 stars), PayPal, Razorpay 등 대형 업체 공식 지원
- **크립토**: Coinbase(1,182 stars), CoinGecko, Base Network 등 활발

### 성장 중인 영역
- **트레이딩**: Alpaca(586 stars)가 선두, QuantConnect 백테스팅 플랫폼 진입
- **회계**: Xero(220 stars), QuickBooks(127 stars) 공식 서버 출시

### 아직 초기인 영역
- **개인 재무/예산**: LunchMoney(55 stars)가 최대. Plaid 공식 MCP 서버 없음
- **세금**: 미국 IRS 특화 도구만 존재. 한국 세금 도구는 아직 없음
- **보험/연금**: MCP 서버 전무

## 추가 리소스

더 많은 금융 MCP 서버를 찾으려면:

- [TensorBlock/awesome-mcp-servers -- Finance & Crypto](https://github.com/TensorBlock/awesome-mcp-servers/blob/main/docs/finance--crypto.md) -- 가장 상세한 카테고리 분류
- [BlockRunAI/awesome-finance-mcp](https://github.com/BlockRunAI/awesome-finance-mcp) -- AI 금융 에이전트 전용 큐레이션
- [punkpeye/awesome-mcp-servers](https://github.com/punkpeye/awesome-mcp-servers) -- 84,000+ stars, 전체 MCP 서버 디렉토리
- [MCP Registry](https://registry.modelcontextprotocol.io) -- 공식 MCP 레지스트리
- [LobeHub MCP Marketplace](https://lobehub.com/mcp?category=stocks-finance) -- 1,700+ 서버 브라우징 가능

---

*이 글은 10개 병렬 리서치 에이전트로 GitHub, MCP 레지스트리, 공식 문서, 커뮤니티를 전수 조사한 결과입니다. Stars 수는 2026년 3월 28일 기준입니다.*
