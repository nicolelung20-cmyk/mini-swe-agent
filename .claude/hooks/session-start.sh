#!/bin/bash
# Installs mini-swe-agent and points it at Claude Opus via OpenRouter for Claude Code on the web.
# The API key is read from the environment (set OPENROUTER_API_KEY in the cloud environment settings).
set -euo pipefail

if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

cd "$CLAUDE_PROJECT_DIR"
pip install -q -e '.[dev]'

export MSWEA_SILENT_STARTUP=1
mini-extra config set MSWEA_MODEL_NAME "${MSWEA_MODEL_NAME:-openrouter/anthropic/claude-opus-5.5}" >/dev/null
mini-extra config set MSWEA_CONFIGURED true >/dev/null
if [ -n "${OPENROUTER_API_KEY:-}" ]; then
  mini-extra config set OPENROUTER_API_KEY "$OPENROUTER_API_KEY" >/dev/null
else
  echo "OPENROUTER_API_KEY not set; add it to the environment settings to run mini." >&2
fi
