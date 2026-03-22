import re, os

def extract_code_blocks(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    parts = content.split('---', 2)
    body = parts[2] if len(parts) >= 3 else content
    blocks = re.findall(r'(```[^\n]*\n.*?\n```)', body, re.DOTALL)
    return '\n'.join(blocks)

basedir = 'scripts/baselines'
os.makedirs(basedir, exist_ok=True)

# S03 files
s03 = {
    'multi-agent-architecture': 'site/content/posts/multi-agent-architecture.md',
    'mcp-introduction': 'site/content/posts/mcp-introduction.md',
    'rag-pipeline-design': 'site/content/posts/rag-pipeline-design.md',
    'prompt-engineering': 'site/content/posts/prompt-engineering-practical-guide.md',
    'llm-cost-optimization': 'site/content/posts/llm-cost-optimization.md',
    'ai-code-review': 'site/content/posts/ai-code-review-automation.md',
}

# S04 files
s04 = {
    'fine-tuning-vs-rag': 'site/content/posts/fine-tuning-vs-rag.md',
    'langchain-vs-llamaindex': 'site/content/posts/langchain-vs-llamaindex.md',
    'ai-seo-content-strategy': 'site/content/posts/ai-seo-content-strategy.md',
    'ai-hack-camp': 'site/content/posts/ai-hack-camp-2026-application-guide.md',
    'designers': 'site/content/posts/designers-most-underrated-in-tech.md',
    'reshaping-design': 'site/content/posts/claude-code-reshaping-design-process.md',
    'figma-mcp-playbook': 'site/content/posts/figma-mcp-claude-code-designer-playbook.md',
    'code-to-figma': 'site/content/posts/claude-code-to-figma-code-to-canvas.md',
}

for label, files in [('S03', s03), ('S04', s04)]:
    print(f'\n=== {label} ===')
    for name, path in files.items():
        result = extract_code_blocks(path)
        outpath = f'{basedir}/{name}-codeblocks.txt'
        with open(outpath, 'w', encoding='utf-8') as f:
            f.write(result)
        block_count = result.count('```') // 2
        print(f'{name}: {block_count} blocks -> {outpath}')
