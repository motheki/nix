#!/usr/bin/env python3
"""Render Den's captured parent relationships without adding a graphics runtime."""

import hashlib
import html
import json
import sys


def render(entries):
    names = set()
    edges = set()
    for entry in entries:
        name = entry.get("path") or entry["name"]
        names.add(name)
        parent = entry.get("parent")
        if parent and parent != name:
            names.add(parent)
            edges.add((parent, name))

    def identifier(name):
        return "n" + hashlib.sha256(name.encode()).hexdigest()[:16]

    lines = ["flowchart TD"]
    for name in sorted(names):
        label = html.escape(name, quote=True).replace("\n", " ")
        lines.append(f'  {identifier(name)}["{label}"]')
    for parent, name in sorted(edges):
        lines.append(f"  {identifier(parent)} --> {identifier(name)}")
    return "\n".join(lines) + "\n"


if __name__ == "__main__":
    try:
        sys.stdout.write(render(json.load(sys.stdin)))
    except (json.JSONDecodeError, KeyError, TypeError, AttributeError) as error:
        print(f"Invalid Den trace: {error}", file=sys.stderr)
        sys.exit(1)
