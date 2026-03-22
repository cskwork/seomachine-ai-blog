import re, sys, os

def extract_code_blocks(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    parts = content.split('---', 2)
    body = parts[2] if len(parts) >= 3 else content
    blocks = re.findall(r'(```[^\n]*\n.*?\n```)', body, re.DOTALL)
    return '\n'.join(blocks)

basedir = 'scripts/baselines'
os.makedirs(basedir, exist_ok=True)

files = {
    'essential-commands': 'site/content/posts/claude-code/claude-code-essential-commands.md',
    'project-setup': 'site/content/posts/claude-code/claude-code-project-setup.md',
    'claude-md-guide': 'site/content/posts/claude-code/claude-code-claude-md-guide.md',
    'context-management': 'site/content/posts/claude-code/claude-code-context-management.md',
    'custom-commands': 'site/content/posts/claude-code/claude-code-custom-commands.md',
    'hooks-automation': 'site/content/posts/claude-code/claude-code-hooks-automation.md',
    'mcp-servers': 'site/content/posts/claude-code/claude-code-mcp-servers.md',
    'multi-agent': 'site/content/posts/claude-code/claude-code-multi-agent.md',
    'tdd-workflow': 'site/content/posts/claude-code/claude-code-tdd-workflow.md',
}

for name, path in files.items():
    result = extract_code_blocks(path)
    outpath = f'{basedir}/{name}-codeblocks.txt'
    with open(outpath, 'w', encoding='utf-8') as f:
        f.write(result)
    block_count = result.count('```') // 2
    print(f'{name}: {block_count} code blocks -> {outpath}')
