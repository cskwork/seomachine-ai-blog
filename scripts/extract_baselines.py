import re

def extract_code_blocks(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    parts = content.split('---', 2)
    if len(parts) >= 3:
        body = parts[2]
    else:
        body = content
    blocks = re.findall(r'(```[^\n]*\n.*?\n```)', body, re.DOTALL)
    return '\n'.join(blocks)

files = {
    'ai-agent-trends': 'site/content/posts/ai-agent-trends-2026.md',
    'claude-vs-gpt': 'site/content/posts/claude-vs-gpt-comparison.md',
    'getting-started': 'site/content/posts/claude-code/claude-code-getting-started.md',
}

for name, path in files.items():
    result = extract_code_blocks(path)
    outpath = f'scripts/baselines/{name}-codeblocks.txt'
    with open(outpath, 'w', encoding='utf-8') as f:
        f.write(result)
    block_count = result.count('```') // 2
    print(f'{name}: {block_count} code blocks extracted -> {outpath}')
