#!/usr/bin/env python3
"""
Auto-Promotion of Learnings (promote_learning.py)
Framework: Agent-Rules-Ecosystem
Extracts validated proposals from overview/learning.md and generates promotion PR proposals.
"""

import os
import re
import json

def extract_promotable_learnings(project_root):
    learning_file = os.path.join(project_root, "overview", "learning.md")
    if not os.path.exists(learning_file):
        learning_file = os.path.join(project_root, "templates", "learning.md")

    if not os.path.exists(learning_file):
        return []

    with open(learning_file, "r") as f:
        lines = f.readlines()

    candidates = []
    for line in lines:
        line_clean = line.strip()
        # Look for bullet points with tags like [verificado], [validado], or [x]
        if line_clean.startswith("*") or line_clean.startswith("-"):
            if any(tag in line_clean.lower() for tag in ["[verificado]", "[validado]", "[x]", "✅"]):
                # Clean tag and extract rule
                clean_text = re.sub(r'^\s*[\*\-]\s*(\[[x\✓\✅]\]|\[verificado\]|\[validado\])?\s*', '', line_clean, flags=re.I)
                candidates.append(clean_text)

    return candidates

def main():
    project_root = os.getcwd()
    candidates = extract_promotable_learnings(project_root)

    print("🚀 ======================================================")
    print(" 🚀 Auto-Promotion of Learnings (promote_learning)")
    print(" ======================================================")

    if not candidates:
        print("  ℹ️ No validated learnings found tagged with [verificado] or [x] in learning.md.")
    else:
        print(f"  Found {len(candidates)} validated proposal(s) ready for central promotion:\n")
        proposal_file = os.path.join(project_root, "overview", "promotion_proposal.md")
        with open(proposal_file, "w") as f:
            f.write("# 🚀 Central Rule Promotion Proposal\n\n")
            f.write("> Extracted automatically by `promote_learning.py` for review and PR generation.\n\n")
            for idx, cand in enumerate(candidates, 1):
                print(f"  [{idx}] {cand}")
                f.write(f"{idx}. {cand}\n")
        
        print(f"\n  ${'✅'} Proposal saved to: overview/promotion_proposal.md")
    print(" ======================================================")

if __name__ == "__main__":
    main()
