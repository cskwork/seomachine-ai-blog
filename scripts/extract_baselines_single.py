import re, sys
filepath = sys.argv[1]
with open(filepath, 'r', encoding='utf-8') as f:
    content = f.read()
parts = content.split('---', 2)
body = parts[2] if len(parts) >= 3 else content
blocks = re.findall(r'(```[^\n]*\n.*?\n```)', body, re.DOTALL)
print('\n'.join(blocks), end='')
