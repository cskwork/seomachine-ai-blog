---
title: "AI 에이전트 만들기: Claude API로 구현하는 도구 사용 에이전트"
date: 2026-03-15
draft: false
tags: ["AI 에이전트", "Claude API", "Tool Use", "튜토리얼", "Python"]
categories: ["튜토리얼"]
description: "Claude API의 Tool Use 기능을 활용하여 AI 에이전트를 직접 구현하는 튜토리얼입니다. 설계부터 구현, 테스트까지 단계별로 안내합니다."
summary: "Claude API의 Tool Use를 활용하여 도구를 사용하는 AI 에이전트를 처음부터 구현하는 방법을 다룹니다."
ShowToc: true
TocOpen: true
seo:
  primary_keyword: "AI 에이전트 만들기"
  secondary_keywords: ["Tool Use", "Claude API"]
  word_count: 600
  quality_score: 0
  last_optimized: null
  review_required: false
---

## 이 튜토리얼에서 만드는 것

파일 시스템을 탐색하고, 웹을 검색하며, 코드를 실행할 수 있는 간단한 AI 에이전트를 구현합니다.

핵심 개념:
- Tool Use (함수 호출): 모델이 외부 도구를 호출하는 메커니즘
- 에이전트 루프: 도구 호출 → 결과 수집 → 다음 행동 결정의 반복
- 가드레일: 에이전트의 행동 범위를 제한하는 안전 장치

## 사전 준비

필요한 것:
- Python 3.10 이상
- Anthropic API 키
- `anthropic` Python SDK

```bash
pip install anthropic
```

## 에이전트 아키텍처

### 핵심 루프

에이전트의 동작은 하나의 루프로 요약됩니다:

```
1. 사용자 입력을 받는다
2. LLM에게 도구 목록과 함께 요청을 보낸다
3. LLM이 도구 호출을 반환하면:
   a. 해당 도구를 실행한다
   b. 결과를 LLM에게 다시 보낸다
   c. 2번으로 돌아간다
4. LLM이 최종 텍스트 응답을 반환하면 종료한다
```

### 도구 정의

Claude API에서 도구는 JSON Schema로 정의합니다:

```python
tools = [
    {
        "name": "read_file",
        "description": "지정된 경로의 파일 내용을 읽어 반환합니다.",
        "input_schema": {
            "type": "object",
            "properties": {
                "path": {
                    "type": "string",
                    "description": "읽을 파일의 경로"
                }
            },
            "required": ["path"]
        }
    },
    {
        "name": "list_directory",
        "description": "지정된 디렉토리의 파일 목록을 반환합니다.",
        "input_schema": {
            "type": "object",
            "properties": {
                "path": {
                    "type": "string",
                    "description": "탐색할 디렉토리 경로"
                }
            },
            "required": ["path"]
        }
    }
]
```

### 도구 실행기

```python
import os

def execute_tool(name, arguments):
    if name == "read_file":
        path = arguments["path"]
        if not os.path.exists(path):
            return f"Error: 파일이 존재하지 않습니다: {path}"
        with open(path, "r") as f:
            return f.read()

    elif name == "list_directory":
        path = arguments["path"]
        if not os.path.isdir(path):
            return f"Error: 디렉토리가 존재하지 않습니다: {path}"
        entries = os.listdir(path)
        return "\n".join(entries)

    return f"Error: 알 수 없는 도구: {name}"
```

### 에이전트 루프 구현

```python
import anthropic

client = anthropic.Anthropic()

def run_agent(user_message, max_iterations=10):
    messages = [{"role": "user", "content": user_message}]

    for i in range(max_iterations):
        response = client.messages.create(
            model="claude-sonnet-4-6-20250514",
            max_tokens=4096,
            system="파일 시스템을 탐색하여 사용자의 질문에 답하세요.",
            tools=tools,
            messages=messages
        )

        # 최종 텍스트 응답이면 종료
        if response.stop_reason == "end_turn":
            return extract_text(response)

        # 도구 호출 처리
        if response.stop_reason == "tool_use":
            messages.append({"role": "assistant", "content": response.content})
            tool_results = process_tool_calls(response)
            messages.append({"role": "user", "content": tool_results})

    return "최대 반복 횟수에 도달했습니다."
```

## 가드레일 설계

### 경로 제한

에이전트가 접근할 수 있는 파일 시스템 범위를 제한합니다:

```python
ALLOWED_PATHS = ["/workspace", "/tmp"]

def is_path_allowed(path):
    resolved = os.path.realpath(path)
    return any(resolved.startswith(allowed) for allowed in ALLOWED_PATHS)
```

### 실행 제한

- 최대 반복 횟수: 에이전트가 무한 루프에 빠지지 않도록 제한
- 시간 제한: 전체 실행 시간에 타임아웃 설정
- 비용 제한: 토큰 사용량 상한 설정

### 사람 개입

위험한 작업(파일 삭제, 외부 API 호출)은 사람의 승인을 요구합니다:

```python
DANGEROUS_TOOLS = ["delete_file", "execute_command"]

def requires_approval(tool_name):
    return tool_name in DANGEROUS_TOOLS
```

## 확장하기

기본 에이전트를 구현한 후 다음과 같이 확장할 수 있습니다:

1. **도구 추가**: 웹 검색, 데이터베이스 조회, API 호출
2. **메모리**: 이전 대화 맥락을 저장하고 활용
3. **계획 수립**: 복잡한 작업을 단계별로 분해하여 실행
4. **멀티 에이전트**: 여러 전문 에이전트가 협업하는 구조

## 핵심 교훈

- 에이전트는 결국 "LLM + 도구 + 루프"입니다
- 가드레일이 없는 에이전트는 프로덕션에 배포하면 안 됩니다
- 작은 범위에서 시작하여 점진적으로 자율성을 확대하세요
- 모든 도구 호출을 로깅하고 모니터링하세요

---

*이 글은 [SEO Machine](https://github.com/TheCraigHewitt/seomachine) 워크스페이스를 활용하여 작성되었습니다.*
