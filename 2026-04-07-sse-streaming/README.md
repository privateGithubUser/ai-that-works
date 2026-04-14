# 🦄 ai that works: SSE Streaming

> Build a real-time site summarizer using Server-Sent Events (SSE) streaming. Crawl a website, summarize each page with an LLM using BAML's semantic streaming, and stream partial results back to the browser as they're generated.

[Video](https://www.youtube.com/watch?v=9MFiATinGC0)

[![SSE Streaming](https://img.youtube.com/vi/9MFiATinGC0/0.jpg)](https://www.youtube.com/watch?v=9MFiATinGC0)

## Links

## Whiteboards

---

## Demo

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
