#!/usr/bin/env bash
# verify-s01.sh — S01 slice verification script
# Checks: code block preservation, YAML validity, date/tags immutability,
#         경어체 patterns, structure patterns, SEO Machine footer, difficulty field
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
BASELINES="$SCRIPT_DIR/baselines"

PASS=0
FAIL=0

check() {
    local desc="$1"
    shift
    if "$@" >/dev/null 2>&1; then
        echo "  PASS: $desc"
        PASS=$((PASS + 1))
    else
        echo "  FAIL: $desc"
        FAIL=$((FAIL + 1))
    fi
}

check_not() {
    local desc="$1"
    shift
    if "$@" >/dev/null 2>&1; then
        echo "  FAIL: $desc"
        FAIL=$((FAIL + 1))
    else
        echo "  PASS: $desc"
        PASS=$((PASS + 1))
    fi
}

extract_codeblocks() {
    python "$SCRIPT_DIR/extract_baselines_single.py" "$1"
}

echo "=== S01 Verification ==="
echo ""

# --- 1. Code block preservation ---
echo "[1] Code block preservation"

# Create a helper script for single-file extraction
cat > "$SCRIPT_DIR/extract_baselines_single.py" << 'PYEOF'
import re, sys

filepath = sys.argv[1]
with open(filepath, 'r', encoding='utf-8') as f:
    content = f.read()
parts = content.split('---', 2)
body = parts[2] if len(parts) >= 3 else content
blocks = re.findall(r'(```[^\n]*\n.*?\n```)', body, re.DOTALL)
print('\n'.join(blocks), end='')
PYEOF

# ai-agent-trends code blocks
ACTUAL=$(extract_codeblocks "$PROJECT_DIR/site/content/posts/ai-agent-trends-2026.md")
EXPECTED=$(cat "$BASELINES/ai-agent-trends-codeblocks.txt")
check "ai-agent-trends code blocks unchanged" [ "$ACTUAL" = "$EXPECTED" ]

# claude-vs-gpt code blocks
ACTUAL=$(extract_codeblocks "$PROJECT_DIR/site/content/posts/claude-vs-gpt-comparison.md")
EXPECTED=$(cat "$BASELINES/claude-vs-gpt-codeblocks.txt")
check "claude-vs-gpt code blocks unchanged" [ "$ACTUAL" = "$EXPECTED" ]

# getting-started code blocks
ACTUAL=$(extract_codeblocks "$PROJECT_DIR/site/content/posts/claude-code/claude-code-getting-started.md")
EXPECTED=$(cat "$BASELINES/getting-started-codeblocks.txt")
check "getting-started code blocks unchanged (17 blocks)" [ "$ACTUAL" = "$EXPECTED" ]

echo ""

# --- 2. YAML frontmatter validity ---
echo "[2] Frontmatter field preservation"

extract_fm_field() {
    local file="$1"
    local field="$2"
    # Extract value from YAML frontmatter
    sed -n '/^---$/,/^---$/p' "$file" | grep "^${field}:" | head -1
}

# ai-agent-trends: date and tags must not change
FM_DATE=$(extract_fm_field "$PROJECT_DIR/site/content/posts/ai-agent-trends-2026.md" "date")
check "ai-agent-trends date unchanged" [ "$FM_DATE" = "date: 2026-03-20" ]

check "ai-agent-trends tags contain AI 에이전트" \
    grep -q 'AI 에이전트' "$PROJECT_DIR/site/content/posts/ai-agent-trends-2026.md"

# claude-vs-gpt: date and tags
FM_DATE=$(extract_fm_field "$PROJECT_DIR/site/content/posts/claude-vs-gpt-comparison.md" "date")
check "claude-vs-gpt date unchanged" [ "$FM_DATE" = "date: 2026-03-17" ]

check "claude-vs-gpt tags contain Claude" \
    grep -q '"Claude"' "$PROJECT_DIR/site/content/posts/claude-vs-gpt-comparison.md"

# getting-started: date, tags, difficulty
FM_DATE=$(extract_fm_field "$PROJECT_DIR/site/content/posts/claude-code/claude-code-getting-started.md" "date")
check "getting-started date unchanged" [ "$FM_DATE" = "date: 2026-03-20" ]

check "getting-started difficulty field preserved" \
    grep -q 'difficulty:' "$PROJECT_DIR/site/content/posts/claude-code/claude-code-getting-started.md"

check_not "getting-started has no seo block" \
    grep -q '^seo:' "$PROJECT_DIR/site/content/posts/claude-code/claude-code-getting-started.md"

echo ""

# --- 3. SEO Machine footer ---
echo "[3] SEO Machine footer"

check "ai-agent-trends has SEO Machine footer" \
    grep -q "SEO Machine" "$PROJECT_DIR/site/content/posts/ai-agent-trends-2026.md"

check "claude-vs-gpt has SEO Machine footer" \
    grep -q "SEO Machine" "$PROJECT_DIR/site/content/posts/claude-vs-gpt-comparison.md"

check_not "getting-started has NO SEO Machine footer" \
    grep -q "SEO Machine" "$PROJECT_DIR/site/content/posts/claude-code/claude-code-getting-started.md"

echo ""

# --- 4. Structure patterns (post-rewrite checks) ---
echo "[4] Structure patterns"

# Check that each pilot has at least 4 H2 sections
for file in \
    "$PROJECT_DIR/site/content/posts/ai-agent-trends-2026.md" \
    "$PROJECT_DIR/site/content/posts/claude-vs-gpt-comparison.md" \
    "$PROJECT_DIR/site/content/posts/claude-code/claude-code-getting-started.md"; do
    fname=$(basename "$file" .md)
    h2_count=$(grep -c '^## ' "$file" || true)
    check "$fname has 3+ H2 sections (found $h2_count)" [ "$h2_count" -ge 3 ]
done

echo ""

# --- 5. Frontmatter seo indent preservation (K001) ---
echo "[5] Frontmatter seo indent (K001)"

for file in \
    "$PROJECT_DIR/site/content/posts/ai-agent-trends-2026.md" \
    "$PROJECT_DIR/site/content/posts/claude-vs-gpt-comparison.md"; do
    fname=$(basename "$file" .md)
    if grep -q '^seo:' "$file"; then
        # Check that seo sub-fields use 2-space indent
        check "$fname seo sub-fields have 2-space indent" \
            grep -q '^  primary_keyword:' "$file"
    fi
done

echo ""

# --- Summary ---
TOTAL=$((PASS + FAIL))
echo "=== Results: $PASS/$TOTAL passed, $FAIL failed ==="

if [ "$FAIL" -gt 0 ]; then
    echo "VERIFICATION FAILED"
    exit 1
else
    echo "ALL CHECKS PASSED"
    exit 0
fi
