# Launch Posts -- Excalidraw Converter

Repository: https://github.com/cskwork/excalidraw-converter

---

## 1. Hacker News -- Show HN

**Title:** Show HN: Turn text and images into editable Excalidraw diagrams with AI

**Body:**

I built an open-source tool that converts text descriptions, files (Markdown, CSV, JSON, HTML, XML), and images into fully editable Excalidraw diagrams. Excalidraw is a fantastic whiteboarding tool, but starting from a blank canvas is slow when you already know what the diagram should look like. This tool lets you describe what you want in plain text or upload a file/image, and it generates properly laid-out Excalidraw elements you can immediately edit.

Built with Claude Agent SDK + Next.js 15 (App Router). The Claude Agent SDK handles the conversion logic -- analyzing input and generating valid Excalidraw element JSON with auto-layout.

Repo: https://github.com/cskwork/excalidraw-converter

Would love feedback on the conversion quality and any use cases I haven't thought of.

---

## 2. Reddit r/programming

**Title:** I built an open-source tool that converts text descriptions into Excalidraw diagrams using AI [Claude Agent SDK + Next.js 15]

**Body:**

I've been using Excalidraw for architecture diagrams and flowcharts for a while now. It's one of the best whiteboarding tools out there -- minimal, fast, and the hand-drawn style makes diagrams feel approachable. But every time I started a new diagram, I'd spend 10-15 minutes just placing boxes and drawing arrows for something I could describe in two sentences.

So I built Excalidraw Converter. It takes three types of input and turns them into editable Excalidraw diagrams:

- **Text descriptions** -- Describe your diagram in plain English ("three microservices connected to a shared database with a load balancer in front") and get a proper diagram
- **Files** -- Upload Markdown, CSV, JSON, HTML, or XML and it extracts the structure into a diagram
- **Images** -- Upload a photo of a whiteboard sketch or screenshot of an existing diagram and get an editable Excalidraw version

**Tech stack:**

- Next.js 15 with App Router for the frontend and API routes
- React 19 with the Excalidraw component for the interactive editor
- Claude Agent SDK for the AI conversion pipeline -- it analyzes input, generates valid Excalidraw JSON elements, and handles auto-layout
- Vitest + Playwright for testing

**How it works under the hood:**

1. User provides input (text, file, or image) via a resizable sidebar
2. Input is sent to the `/api/convert` route
3. The API uses the Claude Agent SDK to analyze the input and generate Excalidraw elements
4. Elements are validated, auto-laid out, and rendered in the full Excalidraw editor

**What's next:**

There are several open issues for anyone who wants to contribute:

- Drag-and-drop support for files and images
- Export to SVG/PNG
- Mermaid syntax as an input format
- Conversion history
- Example prompts and templates
- Dark mode support

The project is MIT licensed and contributions are welcome.

GitHub: https://github.com/cskwork/excalidraw-converter

---

## 3. Reddit r/webdev

**Title:** Built this over a weekend: AI-powered text-to-Excalidraw converter with Next.js 15 and Claude Agent SDK

**Body:**

Sharing a side project I put together -- an AI-powered tool that converts text, files, and images into editable Excalidraw diagrams.

**Architecture overview:**

The app is a standard Next.js 15 App Router project with a clear separation of concerns:

- `src/app/` -- App Router pages and API routes
- `src/components/` -- React components (Excalidraw editor wrapper, resizable sidebar, input forms)
- `src/lib/` -- Core conversion logic and Claude Agent SDK integration
- `src/types/` -- TypeScript type definitions for Excalidraw elements and API contracts

The main flow is straightforward: the frontend sends input to `/api/convert`, the API route invokes the Claude Agent SDK to analyze the input and produce valid Excalidraw element JSON, then the response gets validated, auto-laid out, and fed into the Excalidraw React component.

**Interesting technical challenges:**

1. **Excalidraw element generation** -- Getting the AI to produce valid Excalidraw JSON was the trickiest part. Excalidraw elements have specific required fields (type, x, y, width, height, angle, strokeColor, etc.) and the relationships between elements (especially arrows with start/end bindings) need to be internally consistent. I ended up building a validation and auto-layout step that catches malformed output and fixes element positioning.

2. **Image-to-diagram pipeline** -- For image inputs, the Claude Agent SDK handles vision analysis natively. The challenge was getting it to extract structural relationships (not just labels) from photos of hand-drawn diagrams or screenshots. Prompt engineering for spatial reasoning was key.

3. **Resizable sidebar UX** -- Wanted the input panel to feel native. Used a drag-to-resize approach so users can expand the input area when writing long descriptions or collapse it when focusing on the diagram.

4. **React 19 + Excalidraw** -- The Excalidraw React component is large and needs to be dynamically imported (no SSR). Managing state between the sidebar inputs and the editor component required careful ref management.

**Stack:** Next.js 15, React 19, TypeScript, Tailwind CSS, Excalidraw, Claude Agent SDK, Vitest, Playwright.

Open issues if you want to contribute: drag-and-drop file upload, SVG/PNG export, Mermaid syntax input, conversion history, and dark mode.

GitHub: https://github.com/cskwork/excalidraw-converter

---

## 4. Reddit r/SideProject

**Title:** I built a tool that turns plain text into editable Excalidraw diagrams

**Body:**

I use Excalidraw almost daily -- for architecture diagrams, meeting notes, flowcharts, system designs. It's hands down the best whiteboarding tool for developers. But there's always that friction at the start: you know exactly what the diagram should look like, but you still have to manually place every box, type every label, and draw every arrow.

Last weekend I decided to fix that. I built Excalidraw Converter -- you describe a diagram in plain text (or upload a file or image), and it generates a fully editable Excalidraw diagram.

**Why I built it:**

I was in a meeting where someone described a system architecture verbally. I started sketching it in Excalidraw but kept falling behind. Afterwards I thought -- I could have just typed what they said and let AI generate the diagram. That was the spark.

**How long it took:**

The core functionality took about a weekend. I had a working text-to-diagram flow on Saturday evening and added file/image support on Sunday. The following week I polished the UI (resizable sidebar, better layout algorithm) and added tests.

**What I learned:**

- The Claude Agent SDK is surprisingly ergonomic for building AI-powered tools. The agent pattern handles the conversation loop and tool use automatically -- you define the tools and the SDK manages the back-and-forth.
- Generating valid Excalidraw JSON is harder than it sounds. Elements reference each other (arrows bind to shapes by ID), coordinates need to make sense spatially, and there are dozens of required fields per element. I spent more time on validation and layout than on the AI integration itself.
- Next.js 15 App Router + React 19 is a solid stack for this kind of project. API routes for the backend, React components for the frontend, all in one repo.

**What's next:**

- Drag-and-drop file/image upload (currently click-to-upload)
- Export diagrams to SVG/PNG
- Support Mermaid syntax as an input format
- Conversion history so you can revisit past diagrams
- Example prompts to help new users get started
- Dark mode

All of these are open issues on GitHub if anyone wants to contribute. MIT licensed.

GitHub: https://github.com/cskwork/excalidraw-converter

---

## 5. Twitter/X Thread

**Posting notes:**
- Tag @AnthropicAI and @excalidraw
- Hashtags: #buildinpublic #opensource #excalidraw #claude #nextjs
- Best posting time: Tuesday-Thursday, 9-11am EST

---

**Tweet 1 (Hook):**

I got tired of manually drawing boxes and arrows in Excalidraw when I could describe the diagram in one sentence.

So I built a tool that does it for you. Open source.

**Tweet 2 (What it does):**

Excalidraw Converter takes three types of input:

1. Text -- describe your diagram in plain English
2. Files -- upload Markdown, CSV, JSON, HTML, or XML
3. Images -- upload a photo of a whiteboard or screenshot

And turns them into fully editable Excalidraw diagrams.

**Tweet 3 (How it works):**

How it works:

- You type a description or upload a file/image in the sidebar
- The API sends it to Claude via the Agent SDK
- Claude analyzes the input and generates valid Excalidraw JSON
- Elements are validated, auto-laid out, and rendered in the editor
- You can immediately edit, rearrange, and export

**Tweet 4 (Tech stack):**

Tech stack:

- Next.js 15 (App Router)
- React 19
- TypeScript
- Tailwind CSS
- Excalidraw React component
- Claude Agent SDK for the AI conversion
- Vitest + Playwright for testing

The whole thing is about 83K lines of TypeScript. MIT licensed.

**Tweet 5 (Use cases):**

Use cases I've tested:

- Architecture diagrams from text descriptions
- Flowcharts from process documentation
- ER diagrams from database schemas (JSON/CSV)
- System diagrams from meeting notes
- Editable versions of whiteboard photos
- Org charts from CSV data

**Tweet 6 (What's next):**

What's coming next (all open issues -- contributions welcome):

- Drag-and-drop file upload
- SVG/PNG export
- Mermaid syntax as input
- Conversion history
- Example prompts and templates
- Dark mode

**Tweet 7 (CTA):**

Try it out, star the repo, or grab an open issue:

https://github.com/cskwork/excalidraw-converter

Built with @AnthropicAI Claude Agent SDK + @excalidraw

#buildinpublic #opensource #excalidraw #claude #nextjs

---

## 6. Dev.to Blog Post

**Title:** How I Built an AI-Powered Diagram Converter with Claude Agent SDK

**Tags:** ai, webdev, nextjs, opensource

---

### The problem with creating diagrams

If you've ever used a diagramming tool, you know the pattern: you already know what the diagram should look like, but you still spend 10-15 minutes dragging boxes, typing labels, and connecting arrows. The mental model exists in your head (or in a text description, or in a rough sketch) -- the bottleneck is translating it into the tool's format.

Excalidraw is one of the best diagramming tools available. It's fast, minimal, and the hand-drawn aesthetic makes everything feel less formal and more collaborative. But it still requires manual construction from scratch.

I wanted to bridge that gap: take what you already have (a text description, a file, a photo) and produce an editable Excalidraw diagram automatically.

### The solution: Excalidraw Converter

Excalidraw Converter is an open-source web app that accepts three types of input:

- **Text descriptions** -- "Three microservices connected to a shared PostgreSQL database with an API gateway in front"
- **Files** -- Markdown, CSV, JSON, HTML, or XML documents whose structure can be visualized
- **Images** -- Photos of whiteboard sketches, screenshots of existing diagrams, or any image with visual structure

It analyzes the input using AI and generates a fully editable Excalidraw diagram that renders in an embedded editor. You can immediately pan, zoom, edit labels, move elements, change styles, and export.

### Architecture

The project follows a standard Next.js 15 App Router structure:

```
src/
  app/          -- Pages and API routes
  components/   -- React components (Editor, Sidebar, InputForms)
  lib/          -- Core conversion logic + Claude Agent SDK integration
  types/        -- TypeScript definitions for Excalidraw elements
```

The conversion flow:

```
User Input (text/file/image)
        |
        v
  /api/convert (Next.js API Route)
        |
        v
  Claude Agent SDK
  - Analyzes input structure
  - Generates Excalidraw element JSON
        |
        v
  Validation + Auto-Layout
  - Verify element schema
  - Fix spatial positioning
  - Resolve arrow bindings
        |
        v
  Excalidraw React Component
  - Renders elements
  - Full editing capability
```

### Implementation highlights

**1. Generating valid Excalidraw elements**

Excalidraw elements are JSON objects with specific required fields: `type`, `id`, `x`, `y`, `width`, `height`, `angle`, `strokeColor`, `backgroundColor`, `fillStyle`, `strokeWidth`, `roughness`, and more. Arrows additionally need `startBinding` and `endBinding` objects that reference other elements by ID.

Getting the AI to produce consistently valid JSON required careful prompt engineering and a post-processing validation step. The validation layer checks every element against the expected schema, assigns missing defaults, and recalculates arrow bindings to ensure they actually connect to the referenced elements.

**2. Auto-layout**

Raw AI output often produces overlapping or poorly spaced elements. The auto-layout step applies basic spatial rules: minimum padding between elements, consistent alignment for hierarchical structures, and arrow routing that avoids crossing through other elements when possible.

**3. Image analysis**

For image inputs, Claude's vision capabilities analyze the uploaded image to identify shapes, labels, and connections. The challenge is spatial reasoning -- understanding not just what text appears in the image, but how elements are positioned relative to each other and what the connecting lines mean.

### Why Claude Agent SDK

The Claude Agent SDK provides an agent loop pattern: you define the task and available tools, and the SDK manages the multi-turn conversation with Claude to complete the task. For this project, the agent:

1. Receives the user input (text, file content, or image)
2. Analyzes the structure and identifies diagram elements
3. Generates Excalidraw-compatible JSON
4. Returns the elements for rendering

The SDK handles retries, conversation management, and tool orchestration. This was significantly less boilerplate than building a raw API integration with manual prompt chaining.

### What it can generate

The converter handles a range of diagram types:

- **Architecture diagrams** from text descriptions of system components
- **Flowcharts** from process documentation or step-by-step instructions
- **Entity-relationship diagrams** from database schemas
- **Organizational charts** from CSV/JSON data
- **Editable copies** of whiteboard photos or diagram screenshots
- **Mind maps** from hierarchical text or Markdown outlines

### What's next

The project has several open issues for contributors:

- **Drag-and-drop** -- Currently click-to-upload; want native drag-and-drop for files and images
- **SVG/PNG export** -- Export the generated diagram directly, without going through the Excalidraw UI
- **Mermaid syntax support** -- Accept Mermaid diagram definitions as input
- **Conversion history** -- Save and revisit past conversions
- **Example prompts** -- Pre-built templates to help new users get started
- **Dark mode** -- Match system preference

### Get involved

The project is MIT licensed and contributions are welcome. Whether it's picking up an open issue, improving conversion quality for a specific diagram type, or reporting bugs -- all contributions help.

GitHub: https://github.com/cskwork/excalidraw-converter

**Tech stack summary:** Next.js 15, React 19, TypeScript, Tailwind CSS, Excalidraw, Claude Agent SDK, Vitest, Playwright.

---

## 7. LinkedIn Post

I just open-sourced Excalidraw Converter -- an AI-powered tool that transforms text descriptions, files, and images into fully editable Excalidraw diagrams.

The problem is familiar to anyone who creates technical diagrams regularly: you know exactly what the diagram should look like, but you still spend 10-15 minutes manually placing boxes and drawing arrows. The mental-to-visual translation is the bottleneck, not the thinking.

Excalidraw Converter removes that step. Describe your architecture in plain English, upload a CSV of your org structure, or photograph a whiteboard sketch -- and get an editable diagram in seconds.

On the technical side, the project is built with Next.js 15 (App Router), React 19, and TypeScript. The AI conversion pipeline uses the Claude Agent SDK from Anthropic, which provides an agent loop pattern for multi-step reasoning. The SDK analyzes the input, generates valid Excalidraw element JSON, and handles validation and auto-layout before rendering in the embedded editor.

The project is MIT licensed and has several open issues tagged for contributors: drag-and-drop file upload, SVG/PNG export, Mermaid syntax input, conversion history, and dark mode.

If you work with technical diagrams, architecture reviews, or system design documentation, I would appreciate your feedback. And if you are looking for a well-scoped open-source project to contribute to, the issues are ready.

https://github.com/cskwork/excalidraw-converter

#opensource #developer #webdev #AI #nextjs

---

## 8. GeekNews (Korean HN)

**Title:** AI로 텍스트/이미지를 편집 가능한 Excalidraw 다이어그램으로 변환하는 오픈소스 도구

**Body:**

텍스트 설명, 파일(Markdown, CSV, JSON, HTML, XML), 이미지를 편집 가능한 Excalidraw 다이어그램으로 자동 변환하는 오픈소스 웹 앱을 만들었습니다. Excalidraw는 훌륭한 화이트보드 도구이지만, 매번 빈 캔버스에서 박스를 배치하고 화살표를 그리는 반복 작업이 번거로웠습니다. 이 도구를 사용하면 원하는 다이어그램을 텍스트로 설명하거나 파일/이미지를 업로드하는 것만으로 즉시 편집 가능한 다이어그램을 생성할 수 있습니다.

기술 스택은 Next.js 15 (App Router) + React 19 + Claude Agent SDK (Anthropic)이며, Claude Agent SDK가 입력을 분석해서 유효한 Excalidraw 엘리먼트 JSON을 생성하고 자동 레이아웃까지 처리합니다. MIT 라이선스이고 기여를 환영합니다.

GitHub: https://github.com/cskwork/excalidraw-converter

---

## 9. Awesome List PR Descriptions

### awesome-excalidraw

If an `awesome-excalidraw` list exists, add under a "Tools" or "Integrations" section:

```
- [Excalidraw Converter](https://github.com/cskwork/excalidraw-converter) - AI-powered converter that turns text, files, and images into editable Excalidraw diagrams using Claude Agent SDK + Next.js 15.
```

**PR Title:** Add Excalidraw Converter -- AI-powered text/file/image to diagram tool

**PR Body:**

Excalidraw Converter is an open-source web app that converts text descriptions, files (Markdown, CSV, JSON, HTML, XML), and images into editable Excalidraw diagrams using Claude Agent SDK. Built with Next.js 15 and React 19.

- Repository: https://github.com/cskwork/excalidraw-converter
- License: MIT
- Active development with open issues for contributors

---

### awesome-nextjs

Add under an "Apps" or "Projects" section:

```
- [Excalidraw Converter](https://github.com/cskwork/excalidraw-converter) - AI-powered converter that turns text, files, and images into editable Excalidraw diagrams. Built with Next.js 15 App Router + Claude Agent SDK.
```

**PR Title:** Add Excalidraw Converter -- AI diagram generation with Next.js 15

**PR Body:**

Excalidraw Converter is a Next.js 15 App Router application that converts text, files, and images into editable Excalidraw diagrams using Claude Agent SDK. Uses React 19, TypeScript, Tailwind CSS, API routes for the conversion pipeline, and dynamic imports for the Excalidraw component.

- Repository: https://github.com/cskwork/excalidraw-converter
- License: MIT

---

### awesome-anthropic / awesome-claude

Add under a "Projects" or "Applications" section:

```
- [Excalidraw Converter](https://github.com/cskwork/excalidraw-converter) - AI-powered converter that turns text, files, and images into editable Excalidraw diagrams using Claude Agent SDK + Next.js 15.
```

**PR Title:** Add Excalidraw Converter -- diagram generation with Claude Agent SDK

**PR Body:**

Excalidraw Converter demonstrates the Claude Agent SDK in a practical application: converting text descriptions, files, and images into fully editable Excalidraw diagrams. The agent analyzes input structure, generates valid Excalidraw element JSON, and handles spatial layout automatically.

- Repository: https://github.com/cskwork/excalidraw-converter
- License: MIT
- Stack: Claude Agent SDK + Next.js 15 + React 19 + TypeScript

---

### awesome-ai-tools

```
- [Excalidraw Converter](https://github.com/cskwork/excalidraw-converter) - Convert text, files, and images into editable Excalidraw diagrams using AI. Claude Agent SDK + Next.js 15.
```

**PR Title:** Add Excalidraw Converter -- AI text/image to diagram tool

**PR Body:**

Open-source tool that uses Claude Agent SDK to convert text descriptions, structured files, and images into editable Excalidraw diagrams with auto-layout. MIT licensed.

- Repository: https://github.com/cskwork/excalidraw-converter
