# Personal agent instructions

Apply these preferences across projects for Codex and Claude Code.
Treat them as personal defaults, subject to higher-priority instructions and explicit requests in the current chat.
Keep project-specific build commands and coding rules in the project instructions.

Before answering an explanation request, read `instructions/general/explanations.md` and `instructions/general/diagrams.md`.

Resolve these paths from the directory containing the user-wide instruction file, never from the current project directory.
For Codex, use `${CODEX_HOME:-$HOME/.codex}`.
For Claude Code, use `${CLAUDE_CONFIG_DIR:-$HOME/.claude}`.
If you resolve the entry-point symlink, read the modules beside its canonical `AGENTS.md` instead.
If a module is unavailable, report its path and follow the core preferences below.

For every conceptual explanation, show a Mermaid diagram before the detailed explanation.
Render the diagram with `mmdc` and show the image in the chat.
Immediately after each diagram, give bullet points that explain its meaning.
Build from intuition to a step-by-step explanation and a worked example.
Prefer practical software examples from the current project.
Use pseudocode first, then language-specific code when needed.
For project chats, save diagrams under `docs/explanations` at the project root.
For chats without a project, use the session artifact folder.

These instructions govern explanations, not every status message or implementation summary.
Do not interpret an explanation request as permission to change application code.
