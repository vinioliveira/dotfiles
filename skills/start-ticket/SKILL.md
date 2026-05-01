---
name: start-ticket
description: Start working on a Linear ticket — creates a git worktree + tmux session via gwfo, asks which agent to use (claude-code with claude-opus-4-6 or codex with gpt-5.5 high reasoning), then launches the agent in the session with the ticket as context. Also handles cleanup when the ticket is done.
---

Start working on a Linear ticket end-to-end: fetch the ticket, spin up the worktree + tmux session, and launch the chosen AI agent with full ticket context.

## Shell Commands Reference

These are shell aliases/functions available in the user's zsh environment. Use them exactly as documented.

### `gwfo <branch> [--bg]`

Creates a git worktree and tmux session for the `data-intelligence` repo.

- **`gwfo my-branch`** — creates worktree, installs deps, creates tmux session, and **switches the user into it**
- **`gwfo my-branch --bg`** — same setup but the tmux session stays in the **background** (user is not moved to it)

What it does under the hood:
1. Creates worktree at `~/dev/projects/fullcast/data-intelligence.git/branches/<branch>` (slashes in branch name → dashes)
2. Copies `.env` files from the `main` branch into the new worktree
3. Runs `pnpm i`
4. Creates a tmux session named after the branch (`.` and `/` replaced with `_`)

### `gwfid [branch]`

Deletes a git worktree and its tmux session for the `data-intelligence` repo.

- **`gwfid`** (no args) — opens an **interactive fzf picker** to choose which worktree to delete
- **`gwfid my-branch`** — **non-interactive**: finds the worktree by branch name, removes it, and kills the associated tmux session. Force-removes if there are uncommitted changes.

---

The skill can be invoked with any combination of arguments pre-filled:
- `/start-ticket` — prompts for everything
- `/start-ticket LN4-465` — prompts for agent choice only
- `/start-ticket LN4-465 claude` — runs immediately with no prompts
- `/start-ticket LN4-465 codex` — runs immediately with no prompts

---

## Step 1: Fetch the Ticket

Ask the user for the Linear ticket ID if not already provided (e.g. `LN4-465`).

Use the Linear MCP tool to fetch the full ticket:
- Title
- Description
- Any linked branch name (if present on the ticket)

Derive a branch name if one is not already set on the ticket:
- Format: `<ticket-id>-<title-slug>` (lowercase, hyphens for spaces/special chars)
- Keep it under 50 chars total
- Example: `LN4-465-fix-auth-middleware-session-tokens`

---

## Step 2: Choose Agent

If the agent was not passed as an argument, ask the user before doing anything else:

> Which agent should work on this ticket?
> 1. **claude-code** — model `claude-opus-4-6` (default)
> 2. **codex** — model `o4-mini-high`

Accept shorthand answers: `1`, `claude`, `claude-code` → claude-code; `2`, `codex` → codex. Default to **claude-code** if the user just hits Enter.

Model and effort flags per agent:
- **claude-code**: `--model claude-opus-4-6 --effort high`
- **codex**: `-m gpt-5.5 -c model_reasoning_effort="high"`

---

## Step 3: Create Worktree + tmux Session

Run `gwfo` with the branch name and `--bg` flag so the session is created in the background without switching the user to it:

```bash
gwfo <branch_name> --bg
```

This will:
- Create a git worktree at `~/dev/projects/fullcast/data-intelligence.git/branches/<normalized-branch>` (slashes → dashes)
- Copy `.env` files from main
- Run `pnpm i`
- Create a tmux session named after the branch (slashes and dots → underscores) in the background

Wait for the command to complete before proceeding.

---

## Step 4: Launch Agent in the tmux Session

Compute the tmux session name from the branch: replace all `/` and `.` with `_`.

**IMPORTANT**: Ticket descriptions contain backticks, curly braces, colons, and other characters that zsh will interpret if passed inline. Never pass the prompt as a shell argument. Always write it to a temp file and pipe it in.

### 4a. Write the prompt to a temp file

Write the full ticket context to a temp file inside the worktree:

```bash
cat <<'TICKET_PROMPT_EOF' > /tmp/ticket-prompt-<ticket-id>.md
Ticket: <ID> — <Title>

<Description>
TICKET_PROMPT_EOF
```

Use a heredoc with **quoted delimiter** (`<<'EOF'`) so no shell expansion happens on the content.

### 4b. Write a launcher script

`tmux send-keys` can mangle commands with special characters, and claude-code's `-p` (print/non-interactive) flag requires an explicit API key that may not be set. To avoid both issues, write a launcher script and execute it via tmux.

#### For claude-code:
```bash
cat <<'EOF' > /tmp/run-claude-<ticket-id>.sh
#!/bin/bash
PROMPT=$(cat /tmp/ticket-prompt-<ticket-id>.md)
claude --model claude-opus-4-6 --effort high "$PROMPT"
EOF
```

Claude-code runs interactively (no `-p` flag) so it uses built-in OAuth auth.

#### For codex:
```bash
cat <<'EOF' > /tmp/run-codex-<ticket-id>.sh
#!/bin/bash
PROMPT=$(cat /tmp/ticket-prompt-<ticket-id>.md)
codex -m gpt-5.5 -c model_reasoning_effort="high" "$PROMPT"
EOF
```

Codex runs interactively (no `exec`) so the TUI renders properly. The prompt is passed as a positional argument.

### 4c. Send the launcher to the tmux session

```bash
tmux send-keys -t <session_name> 'bash /tmp/run-<agent>-<ticket-id>.sh' Enter
```

Report back to the user: "Session `<session_name>` is running — `<agent>` is working on `<ticket-id>`."

---

## Cleanup (When Ticket is Done)

When the user asks to clean up / close out a ticket:

### Step C1: Verify the ticket is done

Use the Linear MCP tool to check the ticket state. Only proceed if state is **Done**, **Completed**, or **Cancelled**. If not done, warn the user and ask for confirmation before continuing.

### Step C2: Delete worktree + kill tmux session

Use the non-interactive delete command with the branch name. This removes the worktree and kills the associated tmux session in one step:

```bash
gwfid <branch_name>
```

Confirm success and report back.
