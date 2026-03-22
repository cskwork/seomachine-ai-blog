# Requirements

This file is the explicit capability and coverage contract for the project.

## Active

### R001 — Complete Korean Blog Post (3,500-4,500자)
- Class: core-capability
- Status: active
- Description: 공부 동기부여 방법 주제의 한국어 블로그 포스트 3,500-4,500자 분량 작성
- Why it matters: 본 프로젝트의 핵심 산출물
- Source: user
- Primary owning slice: M001/S01
- Supporting slices: none
- Validation: mapped
- Notes: 리서치 브리프의 7가지 전략 구조 기반

### R002 — SEO Optimization for "공부 동기부여 방법"
- Class: quality-attribute
- Status: active
- Description: 주요 키워드 "공부 동기부여 방법" 및 부가 키워드(공부 의욕 없을때, 도파민 공부법, 66일 습관 등) SEO 최적화
- Why it matters: 검색 유입을 위한 필수 조건
- Source: user
- Primary owning slice: M001/S01
- Supporting slices: M001/S02
- Validation: mapped
- Notes: 키워드 밀도 1-2%, H2/H3에 키워드 포함, 메타 요소 최적화

### R003 — Science-Backed Content with Research Citations
- Class: differentiator
- Status: active
- Description: 뇌과학(도파민 보상 시스템, Nature 2026 연구)과 심리학(SDT 메타분석, 포모도로 리뷰) 연구 데이터 인용
- Why it matters: 감정적 팩폭 중심 경쟁 콘텐츠와 차별화하는 핵심 전략
- Source: user
- Primary owning slice: M001/S01
- Supporting slices: none
- Validation: mapped
- Notes: 127개 연구/77,560명 메타분석, r=0.72 포모도로, 66일 습관 등 구체적 수치

### R004 — Hugo Frontmatter Format Compliance
- Class: constraint
- Status: active
- Description: 기존 발행된 포스트와 동일한 Hugo YAML frontmatter 형식 준수
- Why it matters: 블로그 빌드 및 발행 호환성
- Source: inferred
- Primary owning slice: M001/S01
- Supporting slices: none
- Validation: mapped
- Notes: title, date, draft, tags, categories, description, summary, ShowToc, seo 필드 포함

### R005 — Brand Voice Compliance
- Class: quality-attribute
- Status: active
- Description: AI Insights Lab 브랜드 보이스 준수 (경어체, 사실 기반, 기술 용어 영문 유지, 과장 없음)
- Why it matters: 블로그 정체성과 일관성 유지
- Source: inferred
- Primary owning slice: M001/S01
- Supporting slices: none
- Validation: mapped
- Notes: 이모지 미사용, 감정적 과장 배제, 첫 등장 시 영문 기술 용어에 한국어 설명 병기

### R006 — Contextual CTAs with Internal Links (2-3개)
- Class: primary-user-loop
- Status: active
- Description: 프롬프트 엔지니어링 가이드, SEO 콘텐츠 전략 등 기존 포스트로의 내부 링크 CTA 2-3개 배치
- Why it matters: 내부 링크 SEO 가치 및 독자 체류 시간 증가
- Source: inferred
- Primary owning slice: M001/S01
- Supporting slices: none
- Validation: mapped
- Notes: 체계적 접근법, 시스템적 사고 맥락에서 자연스럽게 연결

### R007 — Korean-Context Mini-Stories (2-3개)
- Class: quality-attribute
- Status: active
- Description: 한국 상황(수능, 자격증, 직장인 자기계발 등) 기반 미니스토리 2-3개 포함
- Why it matters: 한국 독자 공감대 형성 및 /write 명령어 engagement 요건 충족
- Source: user
- Primary owning slice: M001/S01
- Supporting slices: none
- Validation: mapped
- Notes: 한국 이름 사용, 구체적 상황과 결과 포함 (50-150단어 각)

### R008 — Image Placeholders
- Class: launchability
- Status: active
- Description: 도파민 보상 루프 다이어그램, 66일 타임라인 등 인포그래픽 위치에 [image: 설명] 형태 플레이스홀더 삽입
- Why it matters: 발행 시 시각 자료 추가 작업을 위한 가이드
- Source: user
- Primary owning slice: M001/S01
- Supporting slices: none
- Validation: mapped
- Notes: 리서치 브리프 Visual Suggestions 섹션 참조

### R009 — Content Quality Score ≥70
- Class: quality-attribute
- Status: active
- Description: content_scorer.py 기준 복합 품질 점수 70점 이상 달성
- Why it matters: 발행 가능 품질 기준선
- Source: inferred
- Primary owning slice: M001/S02
- Supporting slices: none
- Validation: mapped
- Notes: Humanity 30%, Specificity 25%, Structure 20%, SEO 15%, Readability 10%

### R010 — AI Watermark Scrubbing
- Class: quality-attribute
- Status: active
- Description: /scrub 명령어로 AI 워터마크 및 텔테일 패턴 제거
- Why it matters: AI 생성 콘텐츠 표식 제거
- Source: inferred
- Primary owning slice: M001/S02
- Supporting slices: none
- Validation: mapped
- Notes: 유니코드 워터마크, em-dash 변환, 포맷 제어 문자 제거

### R011 — Optimization Agent Reports
- Class: operability
- Status: active
- Description: SEO, meta, keyword, internal link 최적화 에이전트 보고서 생성
- Why it matters: 콘텐츠 품질 및 SEO 성과 가시성
- Source: inferred
- Primary owning slice: M001/S02
- Supporting slices: none
- Validation: mapped
- Notes: drafts/reports/study-motivation-scientific-methods/ 디렉토리에 저장

## Validated

(None yet)

## Deferred

(None)

## Out of Scope

(None)

## Traceability

| ID | Class | Status | Primary owner | Supporting | Proof |
|---|---|---|---|---|---|
| R001 | core-capability | active | M001/S01 | none | mapped |
| R002 | quality-attribute | active | M001/S01 | M001/S02 | mapped |
| R003 | differentiator | active | M001/S01 | none | mapped |
| R004 | constraint | active | M001/S01 | none | mapped |
| R005 | quality-attribute | active | M001/S01 | none | mapped |
| R006 | primary-user-loop | active | M001/S01 | none | mapped |
| R007 | quality-attribute | active | M001/S01 | none | mapped |
| R008 | launchability | active | M001/S01 | none | mapped |
| R009 | quality-attribute | active | M001/S02 | none | mapped |
| R010 | quality-attribute | active | M001/S02 | none | mapped |
| R011 | operability | active | M001/S02 | none | mapped |

## Coverage Summary

- Active requirements: 11
- Mapped to slices: 11
- Validated: 0
- Unmapped active requirements: 0
