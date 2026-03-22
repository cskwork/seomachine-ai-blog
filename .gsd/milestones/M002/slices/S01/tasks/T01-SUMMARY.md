---
status: done
outcome: success
duration: ~25m
---

# T01 Summary: 톤 가이드 전면 재작성 + 검증 인프라 구축

## What was done

1. **brand-voice.md 전면 재작성** (157줄): 톤 3대 원칙, Do/Don't 예시 7쌍, 금지 표현 12개, 독자 페르소나(주요: 3-7년차 실무 개발자), 글 유형별 미세 조정 가이드(기술해설/비교분석/튜토리얼), 기술 용어 규칙 통합.

2. **style-guide.md 전면 재작성** (161줄): 도입부 3패턴(독자 시나리오/핵심 질문/반직관적 사실), 섹션 전환 2패턴, 결론 3패턴(즉시 실행/판단 기준/3줄 요약), 문장 길이·문단 호흡·소제목 규칙, 네이버 블로그 구조 요소, 포맷팅 규칙.

3. **코드 블록 baseline 추출**: `scripts/baselines/`에 3파일 baseline 저장 — ai-agent-trends 1블록, claude-vs-gpt 2블록, getting-started 17블록.

4. **검증 스크립트** (`scripts/verify-s01.sh`): 18개 체크 — 코드 블록 diff(3), frontmatter 필드 보존(7), SEO Machine 푸터(3), 구조 패턴(3), K001 seo indent(2). `check_not` 헬퍼로 부정 조건 처리.

## Key decisions

- study-motivation 글을 목표 톤 레퍼런스로 확정하고, 해당 글의 패턴(독자 시나리오 도입, 단정적 서술, 데이터 인용, 미니스토리)을 가이드에 코드화.
- Windows 환경에서 `python3` 명령이 exit code 49로 실패 → `python` 명령 사용으로 전환. 검증 스크립트 내 helper도 `python` 호출.

## Verification

`bash scripts/verify-s01.sh` — 18/18 ALL CHECKS PASSED (리라이트 전 baseline 일치 확인).
