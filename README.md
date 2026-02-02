# Claude Code Configuration

Personal Claude Code setup (agents, commands, workflows) managed with GNU Stow for easy sharing across machines.

## What's Included

| Directory | Contents |
|-----------|----------|
| `claude/CLAUDE.md` | Global instructions and preferences |
| `claude/agents/` | Custom agents (arch-auditor, codebase-analyzer, test-runner, etc.) |
| `claude/commands/` | Custom commands (/create_pr, /create_handoff, /resume_handoff) |

## Getting Started

### Prerequisites

```bash
brew install stow
```

### Install

```bash
git clone <repo-url> ~/dev/projects/claude-config
cd ~/dev/projects/claude-config

# First time (if you have existing files in ~/.claude/):
./install.sh --adopt

# Fresh install (no existing files):
./install.sh
```

### Uninstall

```bash
./install.sh --remove
```

## How It Works

GNU Stow creates symlinks from `~/.claude/` pointing to files in this repo:

```
~/.claude/CLAUDE.md → ~/dev/projects/claude-config/claude/CLAUDE.md
~/.claude/agents/   → ~/dev/projects/claude-config/claude/agents/
...
```

Edit files in this repo, commit, push. Pull on other machines to sync.

## What's NOT Managed

These stay local to each machine (not symlinked):

- `settings.json` / `settings.local.json` - personal preferences
- `config.json` - MCP servers, API keys
- `.credentials.json` - auth tokens
- Runtime directories (cache, history, projects, etc.)
