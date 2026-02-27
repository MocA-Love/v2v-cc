#!/bin/bash
set -e

echo "=== v2v-cc Setup ==="

# 1. Register forked VoiceMode as MCP server
echo "[1/3] Registering VoiceMode MCP server (forked)..."
claude mcp add --scope user voicemode -- uvx --from "git+https://github.com/MocA-Love/voicemode" voice-mode
echo "  Done."

# 2. Setup voicemode.env
VOICEMODE_DIR="$HOME/.voicemode"
VOICEMODE_ENV="$VOICEMODE_DIR/voicemode.env"

echo "[2/3] Setting up voicemode.env..."
if [ -f "$VOICEMODE_ENV" ]; then
    echo "  $VOICEMODE_ENV already exists. Skipping."
    echo "  To reset, delete it and re-run this script."
else
    mkdir -p "$VOICEMODE_DIR"
    cp voicemode.env.template "$VOICEMODE_ENV"
    echo "  Created $VOICEMODE_ENV"
    echo "  ** Edit the file and set your OPENAI_API_KEY **"
fi

# 3. Permission reminder
echo "[3/3] Permission setup..."
echo "  Add the following to ~/.claude/settings.json allowlist:"
echo '    "mcp__voicemode"'
echo ""
echo "=== Setup complete ==="
echo ""
echo "Next steps:"
echo "  1. Set your OPENAI_API_KEY in $VOICEMODE_ENV"
echo "  2. Add \"mcp__voicemode\" to ~/.claude/settings.json permissions"
echo "  3. Ensure aivis-mcp is configured for TTS"
echo "  4. Start Claude Code in this directory"
