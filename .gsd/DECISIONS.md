# Decisions Register

<!-- Append-only. Never edit or remove existing rows.
     To reverse a decision, add a new row that supersedes it.
     Read this file at the start of any planning or research phase. -->

| # | When | Scope | Decision | Choice | Rationale | Revisable? |
|---|------|-------|----------|--------|-----------|------------|
| D001 | M001 | convention | Article tone strategy | Light tech touch — 시스템적 사고/분석적 접근법으로 기술 블로그 정체성 간접 표현, AI 강제 연결 없음 | 독자층 확장 콘텐츠로서 자기계발 관심 개발자/PM 타겟. 과학적 데이터 중심 접근 자체가 기술 블로그 정체성을 드러냄. | Yes |
| D002 | M001/S01 | content | Article character count target vs actual | Accept ~6,900자 article as-is instead of trimming to 3,500-4,500자 target | The article was written with comprehensive depth on all 7 strategies, each with specific research data and actionable steps. Trimming ~2,400자 would require cutting entire sections or gutting the research citations that are the R003 differentiator. The 6,900자 length delivers genuine value across all 7 strategies + 66일 roadmap + 응급 처방 + 오해 sections. The original target was an estimate; actual content quality is more important than a word count ceiling. | Yes |
| D003 | M002 | convention | 블로그 전체 문체 톤 | "실력 있는 선배가 설명하는" 경어체 — 자신감 있고 단정적, 구어적 전환점 삽입, 이모지 없음, 과장 없음, 가벼운 수다 금지, 자신감 없는 표현('~하는 것 같아요') 금지 | 기술 전문성은 유지하되 네이버 인기 블로그 수준의 가독성과 독자 참여를 만들기 위한 톤. 기존 건조한 교과서 문체에서 벗어나되, 기술 블로그 정체성을 훼손하지 않는 균형점. | No |
| D004 | M002 | convention | 글 개선 깊이 | 전면 리라이트 허용 — 섹션 순서, 소제목, 도입부, 결론까지 자유롭게 재구성. 내용은 보존하되 글의 뼈대를 바꿀 수 있음. 코드 블록 내용만 절대 변경 금지. | 단순 표현 교정으로는 기계적 구조(도입→불릿→테이블 반복)를 탈피할 수 없음. 네이버 블로그 스타일 흐름을 만들려면 구조 자체를 재설계해야 함. | No |
| D005 | M002 | convention | 글 구성 패턴 | 네이버 블로그 패턴 적용 — 흥미 유발 도입부, 핵심 요약박스, 독자에게 던지는 질문, 섹션 사이 연결 문장, 행동 유도 결론. 기존 SEO Machine 푸터는 유지. | 네이버 인기 블로그의 핵심은 대화하는 느낌과 짧은 호흡. 기술 블로그에 그대로 옮기면 가벼워지므로, 전문성을 유지하면서 구조 패턴만 차용. | Yes — 파일럿(S01) 결과에 따라 조정 |
| D006 | M002 | convention | 톤 통일 범위 | 28개 글 전체를 하나의 톤으로 통일. designers 글의 ~이다 체도 통일 톤(경어체)으로 변경. 글 성격별 미세 조정은 허용하되 기본 톤은 동일. | 글마다 톤이 다르면 브랜드 인지 불가. 일관된 목소리가 블로그 정체성의 기본. | No |
| D007 | M002 | convention | SEO 요소 수정 범위 | frontmatter title, description 함께 개선. slug, date, tags, 코드 블록 내용은 변경 금지. | 검색 결과에서 제목과 설명이 첫 인상. 기계적 제목은 CTR 저하. slug와 date는 기존 URL 보존을 위해 유지. | No |
