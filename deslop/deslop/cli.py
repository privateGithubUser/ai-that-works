import asyncio
import sys


async def _run() -> None:
    text = sys.stdin.read()
    if not text.strip():
        return

    from baml_client import b

    patterns = await b.IdentifySlop(text=text)
    result = await b.FixSlop(text=text, patterns=patterns)
    print(result)


def run() -> None:
    asyncio.run(_run())
