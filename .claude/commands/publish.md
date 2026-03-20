# Publish Command

Hugo 블로그에 글을 발행합니다. 품질 게이트를 통과한 글만 발행할 수 있습니다.

## Usage
`/publish [slug]`

## What This Command Does
1. 품질 게이트 확인 (quality_score >= 70)
2. Hugo frontmatter의 draft 상태를 false로 변경
3. Hugo 빌드를 실행하여 정적 사이트 생성
4. 빌드 성공 확인 후 git commit

## Process

### Step 1: 파일 확인
- `site/content/posts/[slug].md` 파일 존재 여부 확인
- 파일이 없으면 "해당 slug의 글을 찾을 수 없습니다" 안내 후 중단

### Step 2: 품질 게이트
- frontmatter의 `seo.quality_score` 확인
- **70 이상**: 발행 진행
- **70 미만 또는 미설정**: "/optimize [slug]를 먼저 실행하세요" 안내 후 중단
- `seo.review_required: true`인 경우: "수동 리뷰가 필요한 글입니다. 수정 후 /optimize를 다시 실행하세요" 안내 후 중단

### Step 3: Draft 상태 변경
- frontmatter의 `draft: true`를 `draft: false`로 변경
- 변경 사항을 파일에 저장

### Step 4: Hugo 빌드
```bash
cd site
hugo build --minify
```
- 빌드 성공: Step 5로 진행
- 빌드 실패: `draft: true`로 롤백, 에러 메시지 표시 후 중단

### Step 5: 빌드 검증
- `site/public/posts/[slug]/index.html` 파일 존재 확인
- 파일이 없으면 빌드 오류로 판단, `draft: true`로 롤백

### Step 6: Git Commit
```bash
git add site/content/posts/[slug].md
git commit -m "feat: [글 제목] 발행"
```

### Step 7: 완료 안내
다음 정보를 표시:
- 발행된 글 제목
- 로컬 URL: `http://localhost:1313/seomachine-ai-blog/posts/[slug]/`
- 품질 점수
- "hugo server -D 로 로컬에서 확인하세요" 안내

## Error Handling
- 파일 미존재: slug 오타 가능성 안내, 현재 posts 목록 표시
- 품질 미달: /optimize 실행 권고
- 빌드 실패: 에러 로그 표시, draft 롤백, 수정 방법 안내
- 이미 발행됨 (draft: false): "이미 발행된 글입니다" 안내
