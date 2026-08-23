#!/usr/bin/env python3
"""
Agent Telemetry & Performance Metrics Logger (agent_telemetry.py)
Framework: Agent-Rules-Ecosystem
Calculates task completion rate, token friction estimates, and session telemetry.
"""

import os
import json
import re
from datetime import datetime

def analyze_telemetry(project_root):
    overview_dir = os.path.join(project_root, "overview")
    
    metrics = {
        "timestamp": datetime.now().isoformat(),
        "total_tasks": 0,
        "completed_tasks": 0,
        "open_tasks": 0,
        "completion_rate_pct": 100.0,
        "technical_debt": {"high": 0, "medium": 0, "low": 0},
        "sessions_count": 0,
        "verification_status": "unverified"
    }

    # 1. Work.md analysis
    work_file = os.path.join(overview_dir, "work.md")
    if os.path.exists(work_file):
        with open(work_file, "r") as f:
            content = f.read()
            open_matches = re.findall(r'\|\s*w\d+\s*\|\s*\w+\s*\|\s*(pendiente|en progreso|bloqueado)\s*\|', content)
            closed_matches = re.findall(r'\|\s*w\d+\s*\|\s*\w+\s*\|\s*(hecho|resuelto)\s*\|', content)
            
            metrics["open_tasks"] = len(open_matches)
            metrics["completed_tasks"] = len(closed_matches)
            metrics["total_tasks"] = metrics["open_tasks"] + metrics["completed_tasks"]
            if metrics["total_tasks"] > 0:
                metrics["completion_rate_pct"] = round((metrics["completed_tasks"] / metrics["total_tasks"]) * 100, 1)

    # 2. Deuda técnica analysis
    deuda_file = os.path.join(overview_dir, "work", "deuda_tecnica.md")
    if os.path.exists(deuda_file):
        with open(deuda_file, "r") as f:
            content = f.read()
            metrics["technical_debt"]["high"] = len(re.findall(r'\|\s*d\d+\s*\|.*High|Alta', content, re.I))
            metrics["technical_debt"]["medium"] = len(re.findall(r'\|\s*d\d+\s*\|.*Medium|Media', content, re.I))
            metrics["technical_debt"]["low"] = len(re.findall(r'\|\s*d\d+\s*\|.*Low|Baja', content, re.I))

    # 3. Session history count
    session_file = os.path.join(overview_dir, "session.md")
    if os.path.exists(session_file):
        with open(session_file, "r") as f:
            content = f.read()
            if "verificado" in content.lower():
                metrics["verification_status"] = "verificado"
            metrics["sessions_count"] = len(re.findall(r'##\s*Sesión', content)) or 1

    return metrics

def main():
    project_root = os.getcwd()
    metrics = analyze_telemetry(project_root)
    
    out_dir = os.path.join(project_root, "overview")
    os.makedirs(out_dir, exist_ok=True)
    out_file = os.path.join(out_dir, "telemetry.json")

    with open(out_file, "w") as f:
        json.dump(metrics, f, indent=2)

    print("📊 ======================================================")
    print(" 📊 Agent Performance & Telemetry Dashboard")
    print(" ======================================================")
    print(f"  Completion Rate  : {metrics['completion_rate_pct']}% ({metrics['completed_tasks']}/{metrics['total_tasks']} tasks)")
    print(f"  Technical Debt   : High: {metrics['technical_debt']['high']} | Med: {metrics['technical_debt']['medium']} | Low: {metrics['technical_debt']['low']}")
    print(f"  Verification     : {metrics['verification_status']}")
    print(f"  Telemetry File   : overview/telemetry.json")
    print(" ======================================================")

if __name__ == "__main__":
    main()
