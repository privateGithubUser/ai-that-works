# SSE Streaming Demo

Crawls a website, summarizes each page with an LLM (via BAML), and streams the results over SSE.

## Setup

```bash
uv sync
export OPENAI_API_KEY=sk-...
```

## Run

### CLI mode

```bash
uv run python main.py
```

Prints a summary of each page to stdout.

### Server mode (SSE)

```bash
uv run fastapi dev main.py
```

Then open: http://localhost:8000/summaries

Pass a custom URL: http://localhost:8000/summaries?url=https://boundaryml.com/podcast

### Regenerate BAML client

After editing any `.baml` file in `baml_src/`:

```bash
uv run baml-cli generate
```
