#!/usr/bin/env python3
"""
Model Context Protocol (MCP) Bridge & Local Tools Server
Framework: Agent-Rules-Ecosystem
Exposes agent governance commands, linter, and skill installer as native MCP tools.
"""

import sys
import json
import os
import subprocess

def run_command(cmd_list, cwd=None):
    try:
        res = subprocess.run(cmd_list, cwd=cwd or os.getcwd(), capture_output=True, text=True)
        return {"exit_code": res.returncode, "stdout": res.stdout, "stderr": res.stderr}
    except Exception as e:
        return {"exit_code": 1, "stdout": "", "stderr": str(e)}

TOOLS = [
    {
        "name": "agent_health",
        "description": "Runs agent health check, overview/ consistency audit, mermaid syntax linter, and privacy scan.",
        "inputSchema": {"type": "object", "properties": {}}
    },
    {
        "name": "install_skill",
        "description": "Installs an agent skill as a Git submodule and recursively resolves its manifest dependencies.",
        "inputSchema": {
            "type": "object",
            "properties": {
                "skill_name": {"type": "string", "description": "Skill name or Git repository URL."}
            },
            "required": ["skill_name"]
        }
    },
    {
        "name": "read_tracker",
        "description": "Reads a specific tracker file from the project's overview/ directory.",
        "inputSchema": {
            "type": "object",
            "properties": {
                "tracker": {"type": "string", "description": "Tracker name (e.g., 'session', 'work', 'architecture', 'tasks')."}
            },
            "required": ["tracker"]
        }
    }
]

def handle_request(req):
    method = req.get("method")
    req_id = req.get("id")

    if method == "tools/list":
        return {"jsonrpc": "2.0", "id": req_id, "result": {"tools": TOOLS}}

    if method == "tools/call":
        params = req.get("params", {})
        tool_name = params.get("name")
        args = params.get("arguments", {})

        if tool_name == "agent_health":
            script_path = os.path.join(os.getcwd(), "scripts", "agent_health.sh")
            res = run_command(["bash", script_path])
            return {
                "jsonrpc": "2.0",
                "id": req_id,
                "result": {"content": [{"type": "text", "text": res["stdout"] or res["stderr"]}]}
            }

        elif tool_name == "install_skill":
            skill_name = args.get("skill_name")
            script_path = os.path.join(os.getcwd(), "scripts", "install_skill.sh")
            res = run_command(["bash", script_path, skill_name])
            return {
                "jsonrpc": "2.0",
                "id": req_id,
                "result": {"content": [{"type": "text", "text": res["stdout"] or res["stderr"]}]}
            }

        elif tool_name == "read_tracker":
            tracker = args.get("tracker", "").replace(".md", "")
            target = os.path.join(os.getcwd(), "overview", f"{tracker}.md")
            if not os.path.exists(target):
                target = os.path.join(os.getcwd(), "overview", "work", f"{tracker}.md")
            
            if os.path.exists(target):
                with open(target, "r") as f:
                    content = f.read()
                return {"jsonrpc": "2.0", "id": req_id, "result": {"content": [{"type": "text", "text": content}]}}
            else:
                return {"jsonrpc": "2.0", "id": req_id, "error": {"code": -32602, "message": f"Tracker '{tracker}' not found."}}

    return {"jsonrpc": "2.0", "id": req_id, "error": {"code": -32601, "message": "Method not found"}}

def main():
    for line in sys.stdin:
        line = line.strip()
        if not line:
            continue
        try:
            req = json.loads(line)
            resp = handle_request(req)
            sys.stdout.write(json.dumps(resp) + "\n")
            sys.stdout.flush()
        except Exception as e:
            sys.stderr.write(f"Error parsing MCP request: {e}\n")

if __name__ == "__main__":
    main()
