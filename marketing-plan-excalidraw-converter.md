# Excalidraw Converter: 100 Stars 마케팅 실행 계획

## 현재 상태
- Stars: 0 | Forks: 0 | Created: 2026-03-28
- Topics: 설정 완료 (excalidraw, ai, claude, diagram, text-to-diagram 등)
- Description: 업데이트 완료

---

## Phase 1: GitHub Repo 최적화 (D+0 ~ D+2)

### 1.1 README 강화
- [ ] **Hero GIF 추가**: 텍스트 입력 -> 다이어그램 생성 과정을 15초 GIF로 촬영
  - 도구: [LICEcap](https://www.cockos.com/licecap/) 또는 macOS 화면 녹화 -> gifski
  - README 최상단에 배치 (텍스트 설명보다 GIF가 star 전환율 3-5배 높음)
- [ ] **"Why this?" 섹션 추가**: "Excalidraw는 좋지만, 처음부터 그리기는 귀찮다. 텍스트로 설명하면 AI가 그려준다"
- [ ] **Before/After 이미지**: 텍스트 입력 vs 완성된 다이어그램 나란히 배치
- [ ] **One-click demo badge**: `[![Try it](https://img.shields.io/badge/Try_Demo-blue)](URL)` 추가

### 1.2 라이브 데모 배포
- [ ] **Vercel 배포**: `vercel --prod` (Next.js 프로젝트이므로 즉시 가능)
- [ ] GitHub repo homepage URL에 데모 링크 설정
- [ ] Open Graph 이미지 설정 (`/app/opengraph-image.png` 또는 `metadata` 설정)

### 1.3 Social Proof 준비
- [ ] `CONTRIBUTING.md` 추가 (기여 유도)
- [ ] GitHub Issues에 "good first issue" 라벨로 3-5개 이슈 생성
  - 예: "Support Mermaid syntax input", "Add dark mode", "Export to SVG"
- [ ] GitHub Discussions 활성화

---

## Phase 2: 런칭 캠페인 (D+3 ~ D+7)

### 2.1 핵심 채널 (직접 효과)

#### Hacker News - Show HN
- **제목**: `Show HN: Turn text and images into editable Excalidraw diagrams with AI`
- **타이밍**: 화요일~목요일, 오전 9-11시 EST (HN 트래픽 피크)
- **본문**: 데모 링크 + 만든 이유 2줄 + GitHub 링크
- **목표**: Front page -> 20-50 stars

#### Reddit
- **r/programming** (6.3M): "I built an AI tool that converts text descriptions into Excalidraw diagrams"
- **r/webdev** (2.5M): Next.js + Excalidraw 기술 스택 강조
- **r/artificial** (1.2M): Claude Agent SDK 활용 사례
- **r/SideProject** (200K): 사이드 프로젝트 스토리
- 각 서브레딧 규칙 확인 필수 (self-promotion 제한)

#### Twitter/X
- **쓰레드 형식**:
  1. Hook: "I built a tool that turns plain text into Excalidraw diagrams in seconds"
  2. Demo GIF (15초)
  3. 기술 스택 설명 (Claude Agent SDK 강조)
  4. Before/After 비교
  5. GitHub 링크 + "Star if useful"
- **태그**: @excabordi, @AnthropicAI, @vercel
- **해시태그**: #buildinpublic #opensource #excalidraw #claude

### 2.2 에코시스템 채널 (간접 효과)

#### Excalidraw 커뮤니티
- [ ] Excalidraw Discord 서버의 #showcase 채널에 공유
- [ ] excalidraw/excalidraw repo에 "Made with Excalidraw" 섹션 PR (있다면)
- [ ] Excalidraw Libraries 목록에 등록 시도

#### Anthropic/Claude 커뮤니티
- [ ] Anthropic Discord의 #showcase 또는 #projects 채널
- [ ] Claude Agent SDK 사용 사례로 Anthropic 블로그/트위터에 제보
  - 초기 SDK 사용자 사례를 Anthropic이 적극 홍보하는 시기

#### Dev.to / Hashnode
- [ ] 기술 블로그 포스트: "How I built an AI-powered diagram converter with Claude Agent SDK"
- [ ] 구현 과정, 아키텍처, 어려웠던 점 포함
- [ ] 마지막에 GitHub 링크

### 2.3 한국 커뮤니티
- [ ] GeekNews (한국 HN): https://news.hada.io 에 공유
- [ ] 커리어리, 디스콰이어트 등 개발자 커뮤니티
- [ ] 한국어 기술 블로그 (velog, tistory)

---

## Phase 3: 지속 성장 (D+7 ~ D+30)

### 3.1 콘텐츠 마케팅
- [ ] YouTube 짧은 데모 영상 (1-2분)
- [ ] "How it works" 기술 블로그 시리즈
- [ ] 사용 사례별 GIF 시리즈 (architecture diagram, flowchart, ERD 등)

### 3.2 제품 개선으로 재방문 유도
- [ ] 새 기능 추가시마다 트위터 업데이트
  - Mermaid 지원, 다크모드, 템플릿 등
- [ ] GitHub Release 태그로 변경 이력 관리
- [ ] 사용자 피드백 반영 사이클 공개 (#buildinpublic)

### 3.3 크로스 프로모션
- [ ] awesome-excalidraw 목록에 PR
- [ ] awesome-claude / awesome-anthropic 목록에 PR
- [ ] awesome-nextjs 목록에 PR
- [ ] Product Hunt 런칭 (50+ stars 달성 후)

---

## 핵심 메시지 (모든 채널 공통)

> **"Stop drawing diagrams from scratch. Describe it in text, paste a file, or upload an image -- AI converts it to an editable Excalidraw diagram in seconds."**

### 차별점 강조
1. **Input flexibility**: 텍스트, 파일(MD/CSV/JSON), 이미지 모두 지원
2. **Editable output**: 이미지가 아닌 편집 가능한 Excalidraw 형식
3. **Zero config**: `npm install && npm run dev`로 즉시 실행
4. **Claude Agent SDK**: 최신 AI 기술 활용

---

## 성공 지표 트래킹

| 지표 | D+7 목표 | D+14 목표 | D+30 목표 |
|------|---------|----------|----------|
| Stars | 30 | 60 | 100+ |
| Forks | 5 | 10 | 20+ |
| Contributors | 2 | 5 | 8+ |
| Demo visits/day | 50 | 100 | 200+ |

---

## 즉시 실행 체크리스트 (오늘)

1. [ ] 데모 GIF 촬영 (15초, 텍스트 -> 다이어그램)
2. [ ] Vercel 배포 (`vercel --prod`)
3. [ ] README에 GIF + 데모 링크 추가
4. [ ] GitHub Issues 3-5개 생성 (good first issue)
5. [ ] Twitter/X 첫 포스트
