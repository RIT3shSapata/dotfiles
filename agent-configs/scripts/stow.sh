#!/usr/bin/env bash

set -euo pipefail

package_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
repo_dir="$(dirname -- "$package_dir")"
codex_dir="${CODEX_HOME:-$HOME/.codex}"
claude_dir="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
simulate=false
action=--stow

usage() {
  printf 'Usage: %s [--dry-run] [--delete]\n' "$0"
  printf 'Link personal instructions for Codex and Claude Code with GNU Stow.\n'
}

for arg in "$@"; do
  case "$arg" in
    --dry-run) simulate=true ;;
    --delete) action=--delete ;;
    --help|-h) usage; exit 0 ;;
    *) usage >&2; exit 2 ;;
  esac
done

if ! command -v stow >/dev/null 2>&1; then
  printf 'GNU Stow is missing. Install it before using this script.\n' >&2
  exit 1
fi

if [[ "$codex_dir" != /* || "$claude_dir" != /* ]]; then
  printf 'Use absolute paths for CODEX_HOME and CLAUDE_CONFIG_DIR.\n' >&2
  exit 1
fi

for target in "$codex_dir" "$claude_dir"; do
  if [[ ! -d "$target" ]]; then
    if [[ "$simulate" == true || "$action" == --delete ]]; then
      printf 'Target directory does not exist: %s\n' "$target" >&2
      exit 1
    fi
    mkdir -p -- "$target"
  fi
done

if [[ "$action" == --stow && -s "$codex_dir/AGENTS.override.md" ]]; then
  printf 'Codex uses %s instead of AGENTS.md.\n' "$codex_dir/AGENTS.override.md" >&2
  exit 1
fi

stow_all() {
  stow --dir="$repo_dir" --target="$codex_dir" --no-folding "$@" "$action" agent-configs
  stow --dir="$repo_dir" --target="$claude_dir" --no-folding --ignore='^AGENTS\.md$' "$@" "$action" agent-configs
  stow --dir="$package_dir/configs" --target="$claude_dir" --no-folding "$@" "$action" claude
}

# Detect conflicts in all targets before creating any links.
stow_all --simulate --verbose

if [[ "$simulate" == true ]]; then
  printf 'Preview completed. No links changed.\n'
  exit 0
fi

stow_all

if [[ "$action" == --delete ]]; then
  printf 'Personal instruction links removed. Source files remain in %s.\n' "$package_dir"
else
  printf 'Codex instructions: %s/AGENTS.md\n' "$codex_dir"
  printf 'Claude Code instructions: %s/CLAUDE.md\n' "$claude_dir"
fi
