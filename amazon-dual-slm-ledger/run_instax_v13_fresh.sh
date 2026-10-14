#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail
cd "$HOME"
SCRIPT="$HOME/amazon_instax_dual_ledger_v13_gemma4.py"
if [[ ! -f "$SCRIPT" ]]; then
  echo "ERROR: $SCRIPT not found; copy the v13 Python file into HOME first." >&2
  exit 2
fi
mkdir -p "$HOME/logs"
RUN_ID="$(date +%Y%m%d_%H%M%S)_$$"
STATE="$HOME/instax_v13_${RUN_ID}_state.json"
LOG="$HOME/logs/instax_v13_${RUN_ID}.jsonl"
TEXT="$HOME/logs/instax_v13_${RUN_ID}.txt"
printf '[RUN V13] %s | FULL FRESH: BASELINE -> PLAN -> COMMIT\n' "$RUN_ID"
printf '[RUN V13] Two phone-local llama.cpp models: executor 8080; reasoner 8081\n'
printf '[RUN V13] Live terminal + individual JSONL, state and text logs\n'
printf '[RUN V13] State: %s\n' "$STATE"
python -u "$SCRIPT" --browser Firefox --fresh --llm http://127.0.0.1:8080/v1/chat/completions --reasoner-url http://127.0.0.1:8081/v1/chat/completions --reasoner-output-tokens 896 --trace-sifr --state "$STATE" --log "$LOG" 2>&1 | tee "$TEXT"
