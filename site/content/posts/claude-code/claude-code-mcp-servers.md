---
title: "MCP 서버로 Claude Code 확장하기: 외부 도구 연동 가이드"
date: 2026-03-12
draft: false
tags: ["Claude Code", "MCP", "Model Context Protocol", "확장", "도구"]
categories: ["Claude Code"]
description: "MCP(Model Context Protocol) 서버로 Claude Code의 기능을 확장하는 방법. 기존 MCP 서버 활용법과 커스텀 서버 구축 예제를 포함합니다."
summary: "MCP 서버를 활용하여 Claude Code에 데이터베이스 쿼리, 문서 검색, 외부 API 연동 기능을 추가하는 방법을 다룹니다."
difficulty: "고급"
ShowToc: true
TocOpen: true
---

Claude Code는 터미널에서 동작하는 AI 코딩 도구이지만, 그 능력을 외부 시스템까지 확장할 수 있는 메커니즘이 있다. 바로 MCP(Model Context Protocol)다. MCP를 활용하면 Claude Code가 데이터베이스에 직접 쿼리를 날리거나, 최신 라이브러리 문서를 실시간으로 조회하거나, GitHub 이슈를 생성하는 등의 작업을 대화 흐름 안에서 자연스럽게 처리할 수 있게 된다.

이 글에서는 MCP의 개념부터 실제 연결 설정, 유용한 서버 소개, 그리고 커스텀 서버를 직접 만드는 방법까지 순서대로 다룬다.

## MCP란 무엇인가

MCP는 Anthropic이 개발한 오픈 표준 프로토콜이다. 정식 명칭은 Model Context Protocol이며, LLM이 외부 서비스나 도구와 상호작용하는 방식을 표준화한다.

비유를 들자면 USB와 같다. USB가 등장하기 전에는 마우스, 키보드, 프린터마다 각기 다른 포트와 드라이버가 필요했다. USB는 이 문제를 표준 인터페이스 하나로 해결했다. MCP도 마찬가지다. 데이터베이스, 파일 시스템, 외부 API, 검색 엔진 등 다양한 외부 시스템을 AI와 연결하는 방식을 하나의 표준으로 통일한다. 덕분에 LLM 쪽 코드를 바꾸지 않아도 새로운 도구를 플러그인처럼 추가할 수 있다.

MCP 프로토콜에는 세 가지 핵심 개념이 있다.

**Tools(도구)**는 Claude가 직접 실행할 수 있는 함수다. 데이터베이스 쿼리 실행, 파일 읽기, API 호출 같은 동작이 여기에 해당한다. Claude는 작업 맥락에 맞게 어떤 도구를 언제 써야 하는지 스스로 판단한다.

**Resources(리소스)**는 Claude가 참조할 수 있는 데이터 소스다. 파일 내용, 데이터베이스 스키마, 문서 등을 구조화된 형태로 제공한다. 도구와 달리 리소스는 읽기 전용이며 부작용 없이 데이터를 전달한다.

**Prompts(프롬프트)**는 특정 작업을 위한 미리 정의된 대화 템플릿이다. 반복되는 작업 패턴을 재사용 가능한 형태로 패키징할 때 활용한다.

## Claude Code에서 MCP 서버 연결하기

### settings.json에 등록

MCP 서버는 `settings.json` 파일의 `mcpServers` 섹션에 등록한다. 아래는 Context7 MCP 서버를 추가하는 예시다.

```json
{
  "mcpServers": {
    "context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp@latest"],
      "type": "stdio"
    }
  }
}
```

`command`는 서버 프로세스를 실행하는 명령어, `args`는 그에 따른 인수 배열이다. `type`은 전송 방식을 지정하는데, 로컬 프로세스와 통신하는 경우 `stdio`를 사용한다.

여러 서버를 동시에 등록할 수도 있다. 키 이름(`context7` 같은 것)이 서버의 식별자가 되며, 이 이름이 Claude에게 어떤 서버인지 알려주는 단서가 된다.

### 프로젝트 스코프 vs 글로벌 스코프

MCP 서버 설정에는 두 가지 범위가 있다.

**프로젝트 스코프**: `.claude/settings.json`에 등록하면 해당 프로젝트 디렉터리 안에서만 활성화된다. 특정 프로젝트의 데이터베이스에 연결하는 서버나, 팀 전용 내부 API를 다루는 서버처럼 해당 프로젝트에만 의미 있는 도구에 적합하다. 이 파일을 저장소에 커밋하면 팀원들도 동일한 MCP 환경을 공유할 수 있다.

**글로벌 스코프**: `~/.claude/settings.json`에 등록하면 모든 프로젝트에서 사용 가능하다. Context7처럼 어디서든 유용한 라이브러리 문서 검색, 범용 파일 처리 도구 등이 여기에 어울린다.

실무 판단 기준은 간단하다. "이 서버가 다른 프로젝트에서도 의미가 있는가?" 그렇다면 글로벌, 아니라면 프로젝트 스코프에 등록한다.

### 전송 방식: stdio vs Streamable HTTP

MCP 서버는 두 가지 방식으로 통신할 수 있다.

**stdio** 방식은 서버를 로컬 프로세스로 실행하고 표준 입출력으로 통신한다. 대부분의 MCP 서버가 이 방식을 사용한다. 설정이 단순하고, 추가 네트워크 인프라가 필요 없으며, 로컬 파일 시스템에 자유롭게 접근할 수 있다는 장점이 있다.

**Streamable HTTP** 방식은 원격 서버에 HTTP로 연결한다. 여러 클라이언트가 하나의 서버를 공유하거나, 별도의 서버 인프라에서 무거운 작업을 처리해야 할 때 유용하다. 설정에서는 `command` 대신 `url` 필드를 사용한다.

팀 내에서 공용 MCP 서버를 운영하는 경우가 아니라면 stdio 방식이 훨씬 단순하고 관리하기 쉽다.

## 유용한 MCP 서버 소개

### Context7 - 최신 라이브러리 문서 검색

LLM의 훈련 데이터에는 시간적 한계가 있다. Next.js 15, React 19처럼 최근에 나온 라이브러리의 최신 API나 변경 사항을 Claude가 모르는 경우가 많다. Context7은 이 문제를 해결한다.

Context7 MCP 서버를 연결하면 Claude에게 이렇게 요청할 수 있다.

> "Context7으로 Next.js 15의 Server Actions 문서를 찾아줘."

Claude는 Context7 서버를 통해 해당 라이브러리의 최신 공식 문서를 실시간으로 검색하고, 그 내용을 바탕으로 답변한다. 오래된 패턴을 제안하거나 존재하지 않는 API를 만들어내는 문제를 크게 줄일 수 있다.

설정은 앞서 소개한 예시와 동일하게 `npx`로 실행하면 된다. 별도 설치나 토큰 발급이 필요 없어 진입 장벽이 낮다.

### 데이터베이스 MCP - SQL 쿼리 실행

PostgreSQL이나 MySQL용 MCP 서버를 연결하면 Claude가 데이터베이스에 직접 쿼리를 실행할 수 있다.

이것이 실제로 어떻게 도움이 되는지 생각해보자. 버그를 추적하면서 "이 에러가 발생한 사용자가 몇 명인지" 알고 싶을 때, 지금까지는 직접 DB 클라이언트를 열고 쿼리를 작성해야 했다. 데이터베이스 MCP가 있으면 Claude에게 "최근 24시간 내에 결제 실패가 발생한 사용자 수를 조회해줘"라고 말하는 것만으로 충분하다. Claude가 스키마를 탐색하고, 적절한 쿼리를 작성하고, 실행 결과를 해석해준다.

활용 시나리오는 다양하다. 스키마 탐색, 데이터 분포 확인, 마이그레이션 전후 데이터 검증, 성능 분석을 위한 쿼리 실행 등이 모두 가능하다.

### GitHub/Gitea MCP - 이슈 및 PR 관리

코드를 작성하다 보면 이슈를 발견하거나, PR을 생성해야 하거나, 코멘트를 남겨야 하는 상황이 생긴다. 보통은 터미널에서 브라우저로 전환하거나 별도의 CLI 도구를 사용해야 한다.

GitHub MCP 또는 Gitea MCP 서버를 연결하면 이 전환 비용이 사라진다. 코딩 흐름을 유지한 채로 이슈를 생성하고, PR을 열고, 리뷰 코멘트를 작성할 수 있다. "이 버그를 이슈로 등록하고 현재 브랜치에서 PR을 만들어줘"처럼 자연어로 요청하면 된다.

## 커스텀 MCP 서버 만들기

표준 MCP 서버로 해결되지 않는 요구사항은 직접 만들면 된다. Python의 FastMCP 라이브러리를 사용하면 함수 하나를 MCP 도구로 노출하는 것이 매우 간단하다.

아래는 내부 서비스의 헬스 상태를 확인하는 간단한 예제다.

```python
from mcp.server.fastmcp import FastMCP
import requests

mcp = FastMCP("my-tools")

@mcp.tool()
def check_service_health(service_name: str) -> str:
    """지정한 서비스의 헬스 상태를 확인합니다."""
    try:
        response = requests.get(
            f"https://api.example.com/{service_name}/health",
            timeout=5
        )
        if response.status_code == 200:
            return f"{service_name}: 정상 (200)"
        else:
            return f"{service_name}: 이상 감지 ({response.status_code})"
    except requests.exceptions.Timeout:
        return f"{service_name}: 타임아웃 - 서버가 응답하지 않습니다"
    except Exception as e:
        return f"{service_name}: 연결 실패 - {str(e)}"

@mcp.tool()
def list_recent_deployments(environment: str, limit: int = 5) -> str:
    """최근 배포 이력을 조회합니다."""
    # 실제 배포 시스템 API 호출
    response = requests.get(
        f"https://deploy.example.com/api/deployments",
        params={"env": environment, "limit": limit}
    )
    deployments = response.json()
    result = [f"환경: {environment} 최근 {limit}건"]
    for d in deployments:
        result.append(f"  - {d['version']} ({d['deployed_at']}): {d['status']}")
    return "\n".join(result)

if __name__ == "__main__":
    mcp.run()
```

이 서버를 Claude Code에 연결하려면 `settings.json`에 다음과 같이 추가한다.

```json
{
  "mcpServers": {
    "my-tools": {
      "command": "python",
      "args": ["/path/to/server.py"],
      "type": "stdio"
    }
  }
}
```

이제 Claude에게 "프로덕션 환경의 API 서비스 헬스 상태 확인해줘" 또는 "스테이징에 최근 배포된 내역 보여줘"라고 말하면 된다. 함수의 docstring이 Claude에게 도구의 용도를 설명하므로, 명확하게 작성할수록 Claude가 올바른 상황에 도구를 사용한다.

FastMCP 외에도 TypeScript SDK를 사용해 Node.js로 서버를 작성할 수도 있다. 기존 백엔드 코드베이스의 언어에 맞추면 유지보수가 편하다.

## 실무 인사이트: MCP 서버 운영 시 주의점

### 보안: 최소 권한 원칙

MCP 서버는 Claude에게 강력한 실행 권한을 부여한다. 데이터베이스 MCP가 있다면 Claude는 이론적으로 테이블을 삭제하거나 모든 데이터를 조회할 수 있다. 이 권한의 범위를 신중하게 설계해야 한다.

핵심 원칙은 최소 권한이다. 데이터베이스 MCP에는 읽기 전용 계정을 사용하고, 가능하면 프로덕션 대신 읽기 전용 레플리카에 연결한다. API 키와 접속 정보는 절대 `settings.json`에 직접 적지 않고 환경 변수로 분리한다.

```json
{
  "mcpServers": {
    "my-db": {
      "command": "npx",
      "args": ["-y", "@some/postgres-mcp"],
      "type": "stdio",
      "env": {
        "DATABASE_URL": "${DATABASE_URL}"
      }
    }
  }
}
```

`settings.json`을 저장소에 커밋할 경우 실제 자격 증명이 노출될 수 있으므로, 환경 변수 참조 방식을 반드시 사용해야 한다.

### 성능: 느린 서버는 전체를 지연시킨다

Claude가 MCP 도구를 호출할 때 응답을 기다리는 동안 작업 흐름 전체가 멈춘다. 응답이 느린 서버가 하나 있으면 Claude와의 대화 전체가 느려진다.

커스텀 서버를 만들 때는 타임아웃을 명시적으로 설정하고, 처리 시간이 오래 걸리는 작업(대용량 파일 분석, 무거운 통계 연산 등)은 비동기로 처리하거나 결과를 캐싱하는 방식을 고려한다. 서버가 느리다면 Claude가 재시도를 반복하면서 상황이 더 나빠질 수 있다.

### 디버깅: 문제가 생겼을 때

MCP 서버가 의도한 대로 동작하지 않을 때 사용할 수 있는 진단 방법들이 있다.

서버가 도구 목록에 아예 나타나지 않는 경우는 대부분 `settings.json` 경로 문제다. 파일을 불러온 위치(`~/.claude/settings.json`인지 `.claude/settings.json`인지)와 JSON 문법 오류 여부를 먼저 확인한다. Claude Code 대화창에서 "MCP 서버 목록을 보여줘"라고 요청하면 현재 연결된 서버 상태를 확인할 수 있다.

서버가 등록은 됐는데 도구 호출이 실패하는 경우는 서버 프로세스 자체의 문제일 가능성이 높다. 해당 서버를 직접 실행해서 오류 메시지를 확인한다.

```bash
# 서버 직접 실행해서 오류 확인
python /path/to/server.py
```

환경 변수가 제대로 전달되는지도 빈번한 문제 원인이다. 로컬 셸 환경에서는 설정되어 있어도 Claude Code가 서버 프로세스를 실행할 때 해당 환경 변수가 전달되지 않는 경우가 있다. `settings.json`의 `env` 섹션에 명시적으로 선언해두는 것이 안전하다.

## 마치며

MCP는 Claude Code를 단순한 코드 작성 도우미에서 실제 업무 시스템과 통합된 워크플로우 자동화 도구로 만들어주는 핵심 메커니즘이다. Context7로 최신 문서를 실시간 참조하고, 데이터베이스 MCP로 디버깅 중에 데이터를 즉시 조회하고, 팀 전용 서버로 내부 시스템을 연동하면 개발 흐름의 단절을 크게 줄일 수 있다.

시작은 간단하다. Context7 하나를 글로벌 설정에 추가해보는 것으로 충분하다. MCP의 효용을 직접 경험하고 나면 어떤 도구를 더 연결할지 자연스럽게 보이기 시작한다.

---

**관련 글**

- [Claude Code Hooks로 반복 작업 자동화하기](/posts/claude-code/claude-code-hooks-automation/)
- [Claude Code 멀티 에이전트 워크플로우](/posts/claude-code/claude-code-multi-agent/)
