"""
Convert haerache (해라체) to kyungeoache (경어체) in markdown files.
Only converts body text outside of code blocks and frontmatter.
"""
import re
import sys

def convert_haerache_to_kyungeo(text):
    """Convert common haerache endings to kyungeoache."""
    # Order matters — more specific patterns first
    replacements = [
        # ~ㄴ다 / ~는다 patterns
        (r'된다\.', '됩니다.'),
        (r'한다\.', '합니다.'),
        (r'않는다\.', '않습니다.'),
        (r'있는다\.', '있습니다.'),
        (r'없는다\.', '없습니다.'),
        (r'는다\.', '습니다.'),  # generic
        # ~다 patterns (past/present)
        (r'했다\.', '했습니다.'),
        (r'됐다\.', '됐습니다.'),
        (r'졌다\.', '졌습니다.'),
        (r'왔다\.', '왔습니다.'),
        (r'봤다\.', '봤습니다.'),
        (r'났다\.', '났습니다.'),
        (r'갔다\.', '갔습니다.'),
        (r'썼다\.', '썼습니다.'),
        (r'놓았다\.', '놓았습니다.'),
        # ~이다 pattern
        (r'이다\.', '입니다.'),
        # ~있다/없다
        (r'있다\.', '있습니다.'),
        (r'없다\.', '없습니다.'),
        # ~ㄹ 수 있다/없다
        (r'수 있다\.', '수 있습니다.'),
        (r'수 없다\.', '수 없습니다.'),
        # Other common endings
        (r'낸다\.', '냅니다.'),
        (r'진다\.', '집니다.'),
        (r'친다\.', '칩니다.'),
        (r'쓴다\.', '씁니다.'),
        (r'든다\.', '듭니다.'),
        (r'간다\.', '갑니다.'),
        (r'인다\.', '입니다.'),
        (r'본다\.', '봅니다.'),
        (r'온다\.', '옵니다.'),
        (r'준다\.', '줍니다.'),
        (r'넣는다\.', '넣습니다.'),
        # ~ㄴ/는 것이다
        (r'것이다\.', '것입니다.'),
        # Imperative: ~하자 / ~보자
        (r'하자\.', '합시다.'),
        (r'보자\.', '봅시다.'),
        # ~해야 한다
        (r'해야 한다\.', '해야 합니다.'),
        # ~할 수 있다
        (r'할 수 있다\.', '할 수 있습니다.'),
        # ~하지 않는다
        (r'하지 않는다\.', '하지 않습니다.'),
        # ~하면 된다
        (r'하면 된다\.', '하면 됩니다.'),
        # ~라고 한다
        (r'라고 한다\.', '라고 합니다.'),
    ]
    
    for pattern, repl in replacements:
        text = re.sub(pattern, repl, text)
    
    return text

def process_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Split frontmatter
    parts = content.split('---', 2)
    if len(parts) < 3:
        print(f"WARNING: No frontmatter found in {filepath}")
        return
    
    fm = parts[0] + '---' + parts[1] + '---'
    body = parts[2]
    
    # Process body line by line, skipping code blocks
    lines = body.split('\n')
    in_code = False
    converted = []
    changes = 0
    
    for line in lines:
        stripped = line.strip()
        if stripped.startswith('```'):
            in_code = not in_code
            converted.append(line)
            continue
        
        if in_code:
            converted.append(line)
            continue
        
        new_line = convert_haerache_to_kyungeo(line)
        if new_line != line:
            changes += 1
        converted.append(new_line)
    
    result = fm + '\n'.join(converted)
    
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(result)
    
    print(f"{filepath}: {changes} lines converted")

if __name__ == '__main__':
    for filepath in sys.argv[1:]:
        process_file(filepath)
