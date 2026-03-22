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
- Description: 주요 키워드 "공부 동기부여 방법" 및 부가 키워드 SEO 최적화
- Why it matters: 검색 유입을 위한 필수 조건
- Source: user
- Primary owning slice: M001/S01
- Supporting slices: M001/S02
- Validation: mapped
- Notes: 키워드 밀도 1-2%, H2/H3에 키워드 포함, 메타 요소 최적화

### R003 — Science-Backed Content with Research Citations
- Class: differentiator
- Status: active
- Description: 뇌과학과 심리학 연구 데이터 인용
- Why it matters: 감정적 팩폭 중심 경쟁 콘텐츠와 차별화하는 핵심 전략
- Source: user
- Primary owning slice: M001/S01
- Supporting slices: none
- Validation: mapped
- Notes: 127개 연구/77,560명 메타분석 등 구체적 수치

### R004 — Hugo Frontmatter Format Compliance
- Class: constraint
- Status: active
- Description: 기존 발행된 포스트와 동일한 Hugo YAML frontmatter 형식 준수
- Why it matters: 블로그 빌드 및 발행 호환성
- Source: inferred
- Primary owning slice: M001/S01
- Supporting slices: M002/S01~S05
- Validation: mapped
- Notes: title, date, draft, tags, categories, description, summary, ShowToc, seo 필드 포함

### R005 — Brand Voice Compliance
- Class: quality-attribute
- Status: active
- Description: AI Insights Lab 브랜드 보이스 준수 — M002에서 "실력 있는 선배" 톤으로 업데이트
- Why it matters: 블로그 정체성과 일관성 유지
- Source: inferred
- Primary owning slice: M001/S01
- Supporting slices: M002/S01
- Validation: mapped
- Notes: 이모지 미사용, 감정적 과장 배제. M002에서 톤 가이드 재정의

### R006 — Contextual CTAs with Internal Links (2-3개)
- Class: primary-user-loop
- Status: active
- Description: 기존 포스트로의 내부 링크 CTA 2-3개 배치
- Why it matters: 내부 링크 SEO 가치 및 독자 체류 시간 증가
- Source: inferred
- Primary owning slice: M001/S01
- Supporting slices: none
- Validation: mapped
- Notes: 체계적 접근법 맥락에서 자연스럽게 연결

### R007 — Korean-Context Mini-Stories (2-3개)
- Class: quality-attribute
- Status: active
- Description: 한국 상황 기반 미니스토리 2-3개 포함
- Why it matters: 한국 독자 공감대 형성
- Source: user
- Primary owning slice: M001/S01
- Supporting slices: none
- Validation: mapped
- Notes: 한국 이름 사용, 구체적 상황과 결과 포함

### R008 — Image Placeholders
- Class: launchability
- Status: active
- Description: 인포그래픽 위치에 [image: 설명] 형태 플레이스홀더 삽입
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
- Notes: Korean scorer limitations apply (K002, K003)

### R010 — AI Watermark Scrubbing
- Class: quality-attribute
- Status: active
- Description: AI 워터마크 및 텔테일 패턴 제거
- Why it matters: AI 생성 콘텐츠 표식 제거
- Source: inferred
- Primary owning slice: M001/S02
- Supporting slices: none
- Validation: mapped
- Notes: 유니코드 워터마크, em-dash 변환 등

### R011 — Optimization Agent Reports
- Class: operability
- Status: active
- Description: SEO, meta, keyword, internal link 최적화 에이전트 보고서 생성
- Why it matters: 콘텐츠 품질 및 SEO 성과 가시성
- Source: inferred
- Primary owning slice: M001/S02
- Supporting slices: none
- Validation: mapped
- Notes: drafts/reports/ 디렉토리에 저장

### R012 — 통일된 블로그 목소리
- Class: core-capability
- Status: active
- Description: 28개 글 전체가 "실력 있는 선배" 경어체로 통일. 자신감 있고 단정적인 톤. 구어적 전환점 적절히 삽입
- Why it matters: 블로그 전체 정체성 확립. 글마다 다른 톤이면 브랜드 인지 불가
- Source: user
- Primary owning slice: M002/S01
- Supporting slices: M002/S02, M002/S03, M002/S04, M002/S05
- Validation: mapped
- Notes: brand-voice.md, style-guide.md 업데이트 포함

### R013 — 자연스러운 한국어
- Class: quality-attribute
- Status: active
- Description: 문법/맞춤법 오류, AI 생성 냄새 나는 어색한 표현, 기계적 반복 패턴 모두 교정
- Why it matters: 독자가 AI 글이라고 느끼는 순간 이탈. 자연스러운 한국어가 체류시간의 기본
- Source: user
- Primary owning slice: M002/S02
- Supporting slices: M002/S03, M002/S04, M002/S05
- Validation: mapped
- Notes: "~합니다" "~입니다" 단순 반복, "스스로" 같은 오타, "살펴봅니다" 도입부 패턴

### R014 — 독자 참여형 구조
- Class: primary-user-loop
- Status: active
- Description: 네이버 인기 블로그 패턴 — 흥미 유발 도입부, 핵심 요약, 독자에게 던지는 질문, 섹션 연결 문장, 행동 유도 결론
- Why it matters: 읽히지 않는 글은 SEO 점수와 무관하게 가치 없음. 구조가 스크롤을 만듦
- Source: user
- Primary owning slice: M002/S01
- Supporting slices: M002/S02, M002/S03, M002/S04
- Validation: mapped
- Notes: 기계적 나열 → 서사적 흐름. 섹션 사이 연결 문장 필수

### R015 — SEO 메타 품질
- Class: quality-attribute
- Status: active
- Description: frontmatter title, description이 새 톤에 맞게 자연스럽고 클릭 유도. slug/date/tags는 유지
- Why it matters: 검색 결과에서 제목과 설명이 첫 인상. 기계적 제목은 CTR 저하
- Source: user
- Primary owning slice: M002/S02
- Supporting slices: M002/S03, M002/S04
- Validation: mapped
- Notes: frontmatter 수정 시 K001(YAML 인덴테이션 붕괴) 주의

### R016 — 기술 정확성 보존
- Class: constraint
- Status: active
- Description: 코드 블록, API 예시, 기술 비교 테이블, 수치 데이터 정확성 보존. 기술 블로그 정체성 훼손 금지
- Why it matters: 톤 개선하다 코드 예시 깨뜨리면 본말전도
- Source: user
- Primary owning slice: M002/S02
- Supporting slices: M002/S03, M002/S04
- Validation: mapped
- Notes: 코드 블록 내용 변경 금지. 가벼운 수다, 자신감 없는 표현 금지

### R017 — 브랜드 가이드 정합성
- Class: quality-attribute
- Status: active
- Description: brand-voice.md, style-guide.md를 새 톤 기준에 맞게 업데이트
- Why it matters: 가이드 문서가 실제 글과 불일치하면 향후 글 작성 시 혼란
- Source: inferred
- Primary owning slice: M002/S01
- Supporting slices: none
- Validation: mapped
- Notes: M002/S01에서 톤 가이드와 함께 업데이트

### R018 — 글간 일관성
- Class: quality-attribute
- Status: active
- Description: 28개 글 전체에서 톤/구조/패턴이 일관되는지 최종 검증
- Why it matters: 부분적으로 좋아도 전체가 어울리지 않으면 브랜드 경험 훼손
- Source: user
- Primary owning slice: M002/S05
- Supporting slices: none
- Validation: mapped
- Notes: S05에서 전체 QA 수행

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
| R004 | constraint | active | M001/S01 | M002/S01~S05 | mapped |
| R005 | quality-attribute | active | M001/S01 | M002/S01 | mapped |
| R006 | primary-user-loop | active | M001/S01 | none | mapped |
| R007 | quality-attribute | active | M001/S01 | none | mapped |
| R008 | launchability | active | M001/S01 | none | mapped |
| R009 | quality-attribute | active | M001/S02 | none | mapped |
| R010 | quality-attribute | active | M001/S02 | none | mapped |
| R011 | operability | active | M001/S02 | none | mapped |
| R012 | core-capability | active | M002/S01 | M002/S02~S05 | mapped |
| R013 | quality-attribute | active | M002/S02 | M002/S03~S05 | mapped |
| R014 | primary-user-loop | active | M002/S01 | M002/S02~S04 | mapped |
| R015 | quality-attribute | active | M002/S02 | M002/S03~S04 | mapped |
| R016 | constraint | active | M002/S02 | M002/S03~S04 | mapped |
| R017 | quality-attribute | active | M002/S01 | none | mapped |
| R018 | quality-attribute | active | M002/S05 | none | mapped |

## Coverage Summary

- Active requirements: 18
- Mapped to slices: 18
- Validated: 0
- Unmapped active requirements: 0
