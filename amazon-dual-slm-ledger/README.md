# Two local SLMs, one persistent ledger, structured browser perception

Continuation of the small-model browser experiments in `e2llm/edge-browser-agent`.

Two consecutive runs of the same Amazon task were executed with two local models on one Samsung Galaxy S21 (SM-G991B):

- **Reasoner:** Google Gemma 4 E2B Q3 — local llama.cpp endpoint `127.0.0.1:8081`
- **Executor:** Qwen3.5-0.8B — local llama.cpp endpoint `127.0.0.1:8080`
- **Persistent ledger:** task state, dependencies, budget, verification and recovery
- **Structured browser perception/actions:** E2LLM/SiFR
- **Browser:** the user's existing Firefox session

E2LLM/SiFR is developed by the same team and is part of the system being tested here.

Neither model was fine-tuned or trained for this workflow. The models did not receive screenshots or raw HTML.

## Task

Prepare an Instax Mini 12 kit on Amazon under a USD 200 budget: camera, compatible film, spare AA alkaline batteries and a protective case.

Planning had to complete before any cart mutation. During COMMIT, planned products were reopened and reverified before Add to Cart. The workflow stopped at human review; no checkout, Buy Now, payment or purchase action was attempted.

## Results

**Run 1 — bundle route**

- 4/4 needs satisfied
- 2 cart entries
- USD 190.98 planned subtotal
- `READY_FOR_HUMAN_REVIEW`

**Run 2 — separate-products route + recovery**

A USD 179.95 film choice was rejected by the ledger because it would exceed the total budget. The reasoner returned to the observed alternatives, selected a compatible USD 17.89 film pack, and continued.

- 4/4 needs satisfied
- 4 cart entries
- USD 143.86 planned subtotal
- `READY_FOR_HUMAN_REVIEW`

The two runs were recorded consecutively in one ~50:59 session. The publication video is accelerated playback of that complete session.

## Architecture

**The ledger owns the task. Each model owns only the next bounded decision.**

Gemma makes semantic workflow decisions: search queries, product selection, compatibility, bundle coverage and recovery.

Qwen selects bounded live UI actions from the current SiFR observation.

E2LLM/SiFR supplies structured browser perception and explicit actions in the live Firefox session.

The task rules are deliberately specific to this experiment. This is a controlled workflow measurement, not a general browser-agent benchmark.

## Files

- `amazon_instax_dual_ledger_v13_gemma4.py` — exact Python workflow used for both runs
- `run_instax_v13_fresh.sh` — exact launcher used for each fresh run
- `two_runs.log` — the two original terminal logs concatenated in chronological order, byte-for-byte, with no inserted separator and no edits to their contents
- `SHA256SUMS` — SHA-256 hashes of the public files in this folder

Original source-log SHA-256 values before concatenation:

```text
7ae1d28a1e78254220fcead1f417d76e26296d595ab5d9f415c411f07a197a61  run1.txt
58cf7d1c8a0994bb16649c159c29c59cdc899730e8ec1874736c826c6aae3490  run2.txt
```

## Note on the final JSON label

The v13 executable still prints a legacy `v12 Gemma4` architecture string in the final JSON. This is a display-label bug. The executable used for both published runs is the v13 file included here; the logs are intentionally left unchanged.
