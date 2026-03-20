---
title: "MCP(Model Context Protocol) 입문: LLM과 외부 시스템을 연결하는 표준"
date: 2026-03-14
draft: false
tags: ["MCP", "LLM", "프로토콜", "통합", "Claude"]
categories: ["기술 심화"]
description: "Model Context Protocol(MCP)의 개념, 아키텍처, 실무 활용법을 소개합니다. LLM이 외부 도구와 데이터에 접근하는 표준 프로토콜입니다."
summary: "MCP는 LLM과 외부 시스템 간의 통신을 표준화하는 프로토콜입니다. 개념부터 구현까지 살펴봅니다."
ShowToc: true
TocOpen: true
seo:
  primary_keyword: "MCP"
  secondary_keywords: ["프로토콜", "도구 통합"]
  word_count: 600
  quality_score: 0
  last_optimized: null
  review_required: false
---

## MCP란 무엇인가

MCP(Model Context Protocol)는 Anthropic이 발표한 오픈 프로토콜로, LLM 애플리케이션이 외부 데이터 소스와 도구에 접근하는 방식을 표준화합니다.

기존에는 각 AI 도구마다 고유한 통합 방식을 사용했습니다. MCP는 이를 하나의 표준으로 통합하여, "AI를 위한 USB-C"라고 비유할 수 있습니다.

### 해결하는 문제

- 도구마다 다른 통합 코드 작성 (N x M 문제)
- 데이터 소스 접근 방식의 파편화
- 보안과 권한 관리의 비일관성
- 컨텍스트 공유의 어려움

## 아키텍처

MCP는 클라이언트-서버 아키텍처를 따릅니다.

### 구성 요소

| 구성 요소 | 역할 | 예시 |
|----------|------|------|
| MCP Host | MCP 클라이언트를 포함하는 애플리케이션 | Claude Desktop, IDE |
| MCP Client | MCP 서버와 1:1 연결 유지 | SDK 내장 |
| MCP Server | 리소스, 도구, 프롬프트를 제공 | 파일 서버, DB 서버 |

### 세 가지 프리미티브

**1. Resources (리소스)**

LLM이 읽을 수 있는 데이터를 제공합니다. 파일, 데이터베이스 레코드, API 응답 등이 해당됩니다.

**2. Tools (도구)**

LLM이 실행할 수 있는 작업을 정의합니다. 데이터베이스 쿼리, API 호출, 파일 조작 등이 해당됩니다.

**3. Prompts (프롬프트)**

재사용 가능한 프롬프트 템플릿을 제공합니다. 특정 도메인이나 작업에 최적화된 프롬프트를 서버가 관리합니다.

## MCP 서버 구현

### Python (FastMCP)

```python
from mcp.server.fastmcp import FastMCP

mcp = FastMCP("weather-server")

@mcp.tool()
def get_weather(city: str) -> str:
    """지정된 도시의 현재 날씨를 반환합니다."""
    # 실제 구현에서는 날씨 API 호출
    return f"{city}의 현재 기온은 18도, 맑음입니다."

@mcp.resource("weather://{city}/forecast")
def get_forecast(city: str) -> str:
    """도시의 주간 날씨 예보를 반환합니다."""
    return f"{city}의 주간 예보: 월-수 맑음, 목-금 흐림"
```

### TypeScript (MCP SDK)

```typescript
import { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { z } from "zod";

const server = new McpServer({ name: "weather-server", version: "1.0.0" });

server.tool("get_weather",
  { city: z.string().describe("도시 이름") },
  async ({ city }) => ({
    content: [{ type: "text", text: `${city}: 18도, 맑음` }]
  })
);
```

## 실무 활용 사례

### 1. 데이터베이스 MCP 서버

SQL 데이터베이스에 자연어로 질의할 수 있습니다.

- 스키마 정보를 리소스로 제공
- SQL 실행을 도구로 제공
- 읽기 전용 모드로 안전성 확보

### 2. 문서 관리 MCP 서버

Confluence, Notion 등 문서 시스템과 연결합니다.

- 문서 검색, 읽기를 리소스로 제공
- 문서 생성, 수정을 도구로 제공
- 권한 체계를 MCP 서버에서 관리

### 3. 모니터링 MCP 서버

서버 상태, 로그, 메트릭에 접근합니다.

- 실시간 메트릭을 리소스로 제공
- 알림 설정, 대시보드 생성을 도구로 제공
- 인시던트 분석 프롬프트를 제공

## 보안 고려사항

MCP 서버 구현 시 반드시 고려해야 할 보안 사항:

1. **최소 권한 원칙**: 필요한 최소한의 권한만 부여
2. **입력 검증**: 모든 도구 입력을 검증하고 새니타이징
3. **속도 제한**: 도구 호출 빈도를 제한
4. **감사 로깅**: 모든 도구 호출을 기록
5. **민감 데이터 보호**: 비밀번호, API 키 등의 노출 방지

## 생태계 현황

2026년 현재 MCP 생태계는 빠르게 성장하고 있습니다:

- **공식 서버**: GitHub, Slack, Google Drive, PostgreSQL 등
- **커뮤니티 서버**: 500개 이상의 오픈소스 MCP 서버
- **지원 클라이언트**: Claude Desktop, Cursor, VS Code, Claude Code

## 시작하기

1. **기존 서버 사용**: 공식/커뮤니티 MCP 서버를 Claude Desktop에 설정
2. **간단한 서버 구현**: FastMCP로 사내 데이터 소스 연결
3. **도구 확장**: 팀의 워크플로우에 맞는 커스텀 도구 추가
4. **프로덕션 배포**: 보안 검토 후 팀 전체에 배포

---

*이 글은 [SEO Machine](https://github.com/TheCraigHewitt/seomachine) 워크스페이스를 활용하여 작성되었습니다.*
