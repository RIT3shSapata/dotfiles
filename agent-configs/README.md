# Personal agent instructions

This package stores explanation preferences for Codex and Claude Code.
GNU Stow creates symlinks, which point the installed files to their source files.
Both agents use the same canonical `AGENTS.md` and instruction modules.

The package contains only the files needed for these preferences:

```text
agent-configs/
├── README.md
├── AGENTS.md
├── .stow-local-ignore
├── instructions/
│   └── general/
│       ├── explanations.md
│       └── diagrams.md
├── scripts/
│   └── stow.sh
└── configs/
    └── claude/
        └── CLAUDE.md -> ../../AGENTS.md
```

`AGENTS.md` names the modules and retains the core preferences as a fallback.
`explanations.md` describes the teaching sequence, examples, pseudocode, and comparisons.
`diagrams.md` describes diagram creation, storage, rendering, and display.
`CLAUDE.md` points to `AGENTS.md`, so both entry points stay consistent.
The package does not create sample roles, skills, workflows, or unrelated coding rules.

## Preferences

Each conceptual explanation starts with brief intuition and a rendered Mermaid diagram.
Bullet points directly after each diagram explain what it means.
A step-by-step explanation and worked example follow the diagram.
Examples use the current project when it fits the topic.
Pseudocode comes before language-specific code when code is needed.

Project diagrams stay under `docs/explanations` at the actual project root.
Chats without a project use the session artifact folder.
Agents ask you to install Mermaid CLI if `mmdc` is unavailable.
Agents preserve the `.mmd` source and show a file link when image display is unavailable.
Ordinary progress messages do not require diagrams.

These preferences use the choices from the setup chat and recurring requests in previous Codex chats.
The history review covered available local chats, archived chats, and the accessible remote Codex chat.
It excluded internal approval-review sessions from the preference evidence.
The files retain preferences rather than conversation transcripts or personal details.

## Install

Install GNU Stow before linking this package.
For diagram generation, install Mermaid CLI so that `mmdc` is available.
The installation script does not install dependencies.

From the root of the dotfiles repository, preview the links:

```sh
./agent-configs/scripts/stow.sh --dry-run
```

If both target directories exist, the preview changes no files.
If a target directory is missing, the preview reports its path.
The installation command creates missing target directories:

```sh
./agent-configs/scripts/stow.sh
```

The script links `AGENTS.md` and the instruction modules into `${CODEX_HOME:-$HOME/.codex}`.
It links `CLAUDE.md` and the same modules into `${CLAUDE_CONFIG_DIR:-$HOME/.claude}`.
The README, scripts, and tool adapter directory stay in the repository.

If Stow reports a conflicting real file, back it up and move it before installing.
The script stops on conflicts instead of replacing or adopting existing files.
If a nonempty `AGENTS.override.md` exists, the script stops because Codex reads that file instead of `AGENTS.md`.

To use different user directories, supply absolute paths:

```sh
CODEX_HOME="/absolute/path/codex" CLAUDE_CONFIG_DIR="/absolute/path/claude" ./agent-configs/scripts/stow.sh
```

Use those same environment variables when launching the corresponding agent.
These links apply to local sessions that use the selected user directories.
For another device or remote host, install the package there too.

## Update and remove

Edit the canonical files in this package.
Existing links immediately point to the edited content.
If you add or remove modules, run `./agent-configs/scripts/stow.sh` again.

To remove the installed links, run this command from the repository root:

```sh
./agent-configs/scripts/stow.sh --delete
```

The command removes links owned by this package.
It retains the source files and unrelated agent configuration.
If you used custom user directories, supply the same environment variables for removal.

## Make sure that agents load the instructions

Start a fresh Codex chat after installing the package.
Ask it to name its global instruction file and the two modules that it reads for explanation requests.
Then ask for a short conceptual explanation to exercise the diagram workflow.

Start a fresh Claude Code session after installing the package.
Use `/context` to inspect its loaded instruction files.
Ask it to read the explanation modules and explain a small concept.

Codex discovers global guidance under its user directory before project instructions.
More specific project instructions can override those defaults.
See the [official OpenAI documentation](https://learn.chatgpt.com/docs/agent-configuration/agents-md).

Claude Code reads `~/.claude/CLAUDE.md` for personal preferences across projects.
The local symlink points to the shared canonical entry point.
See the [Claude Code documentation](https://code.claude.com/docs/en/memory).

The module paths in `AGENTS.md` are instructions for the agent to read files.
They are not automatic Markdown imports.
Both agents retain the core preferences in their entry point if a module cannot load.
