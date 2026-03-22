#!/usr/bin/env bash
# verify-s02.sh — S02 slice verification: Claude Code series 9 files
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
BASELINES="$SCRIPT_DIR/baselines"
CC_DIR="$PROJECT_DIR/site/content/posts/claude-code"

PASS=0
FAIL=0

check() {
    local desc="$1"; shift
    if "$@" >/dev/null 2>&1; then
        echo "  PASS: $desc"; PASS=$((PASS + 1))
    else
        echo "  FAIL: $desc"; FAIL=$((FAIL + 1))
    fi
}

check_not() {
    local desc="$1"; shift
    if "$@" >/dev/null 2>&1; then
        echo "  FAIL: $desc"; FAIL=$((FAIL + 1))
    else
        echo "  PASS: $desc"; PASS=$((PASS + 1))
    fi
}

FILES=(
    essential-commands
    project-setup
    claude-md-guide
    context-management
    custom-commands
    hooks-automation
    mcp-servers
    multi-agent
    tdd-workflow
)

DATES=(
    "date: 2026-03-19"
    "date: 2026-03-18"
    "date: 2026-03-17"
    "date: 2026-03-14"
    "date: 2026-03-16"
    "date: 2026-03-11"
    "date: 2026-03-12"
    "date: 2026-03-13"
    "date: 2026-03-15"
)

# Create helper for code block extraction
cat > "$SCRIPT_DIR/extract_baselines_single.py" 2>/dev/null << 'PYEOF' || true
import re, sys
filepath = sys.argv[1]
with open(filepath, 'r', encoding='utf-8') as f:
    content = f.read()
parts = content.split('---', 2)
body = parts[2] if len(parts) >= 3 else content
blocks = re.findall(r'(```[^\n]*\n.*?\n```)', body, re.DOTALL)
print('\n'.join(blocks), end='')
PYEOF

echo "=== S02 Verification: Claude Code Series (9 files) ==="
echo ""

# --- 1. Code block preservation ---
echo "[1] Code block preservation"
for i in "${!FILES[@]}"; do
    name="${FILES[$i]}"
    file="$CC_DIR/claude-code-${name}.md"
    baseline="$BASELINES/${name}-codeblocks.txt"
    if [ -f "$baseline" ]; then
        ACTUAL=$(python "$SCRIPT_DIR/extract_baselines_single.py" "$file")
        EXPECTED=$(cat "$baseline")
        check "$name code blocks unchanged" [ "$ACTUAL" = "$EXPECTED" ]
    else
        echo "  SKIP: $name (no baseline)"
    fi
done
echo ""

# --- 2. Frontmatter date preservation ---
echo "[2] Frontmatter date preservation"
for i in "${!FILES[@]}"; do
    name="${FILES[$i]}"
    file="$CC_DIR/claude-code-${name}.md"
    expected_date="${DATES[$i]}"
    actual_date=$(sed -n '/^---$/,/^---$/p' "$file" | grep "^date:" | head -1)
    check "$name date unchanged" [ "$actual_date" = "$expected_date" ]
done
echo ""

# --- 3. No seo block, no SEO Machine footer ---
echo "[3] No seo block / No SEO Machine footer"
for name in "${FILES[@]}"; do
    file="$CC_DIR/claude-code-${name}.md"
    check_not "$name has no seo block" grep -q '^seo:' "$file"
    check_not "$name has no SEO Machine footer" grep -q 'SEO Machine' "$file"
done
echo ""

# --- 4. Structure: H2 sections ---
echo "[4] Structure patterns"
for name in "${FILES[@]}"; do
    file="$CC_DIR/claude-code-${name}.md"
    h2_count=$(grep -c '^## ' "$file" || true)
    check "$name has 3+ H2 sections (found $h2_count)" [ "$h2_count" -ge 3 ]
done
echo ""

# --- Summary ---
TOTAL=$((PASS + FAIL))
echo "=== Results: $PASS/$TOTAL passed, $FAIL failed ==="
if [ "$FAIL" -gt 0 ]; then
    echo "VERIFICATION FAILED"; exit 1
else
    echo "ALL CHECKS PASSED"; exit 0
fi
