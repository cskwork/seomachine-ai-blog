# Context Files as Executable Requirements

**Extracted:** 2026-03-28
**Context:** 에이전트/커맨드가 일관된 출력을 내야 할 때

## Problem
AI 에이전트가 매번 다른 톤, 스타일, SEO 규칙으로 콘텐츠를 생성함. 브랜드 일관성이 깨짐.

## Solution
`context/` 디렉토리에 실행 가능한 요구사항 파일을 두고, 커맨드에서 `@context/filename.md`로 **필수 참조**시킴.

```
context/
├── brand-voice.md        # 톤 정의
├── style-guide.md        # 포맷팅 규칙
├── seo-guidelines.md     # 키워드 밀도, 헤더 구조
├── internal-links-map.md # 내부 링크 토폴로지
└── writing-examples.md   # Before/After 톤 샘플
```

커맨드 내 사용법:
```markdown
## 사전 필수 읽기
@context/brand-voice.md
@context/style-guide.md
```

핵심: context 파일은 "참고 문서"가 아니라 **버전 관리되는 비즈니스 로직**으로 취급.

## When to Use
- 여러 에이전트가 동일 프로젝트에서 콘텐츠를 생성할 때
- 브랜드 톤/스타일 일관성이 필요한 모든 프로젝트
- 커맨드 기반 워크플로우 설계 시
