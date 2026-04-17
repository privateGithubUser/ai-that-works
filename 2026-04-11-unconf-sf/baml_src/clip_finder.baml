// Highlight clip extraction for unconference talks

class TalkClip {
  hook string @description(#"
    1-2 sentence punchy, social-media-ready summary of why this clip is compelling.
    Write it as a teaser — make someone want to watch.
  "#)
  rationale string @description(#"
    Internal note explaining why this moment is worth highlighting.
    What makes it insightful, surprising, or memorable?
  "#)
  clip_start_anchor string @description(#"
    Verbatim first 10-15 words of the clip, exactly as they appear in the transcript.
    This MUST match the transcript character-for-character — it will be used to locate the clip.
  "#)
  clip_end_anchor string @description(#"
    Verbatim last 10-15 words of the clip, exactly as they appear in the transcript.
    This MUST match the transcript character-for-character — it will be used to locate the clip.
  "#)
  estimated_word_count int @description(#"
    Estimated word count of the clip. Target range: 65–195 words (30 seconds to 1.5 minutes).
  "#)
}

function FindBestClips(
  talk_transcript: string,
  talk_title: string,
  speaker_name: string?,
) -> TalkClip[] {
  client Gemini25Pro
  prompt #"
    {{ _.role('user') }}
    You are curating a highlight reel from an unconference talk.

    Talk title: {{ talk_title }}
    Speaker: {{ speaker_name | default("Unknown") }}

    Your job: find 0–3 clips from this transcript worth featuring as standalone social clips.

    A great clip:
    - Is self-contained and understandable without context
    - Contains a punchy insight, surprising take, concrete example, or memorable moment
    - Is 65–195 words long (30 seconds to 1.5 minutes at normal speaking pace)
    - Starts and ends at natural sentence boundaries
    - Does NOT require setup — a viewer can jump in cold and immediately get value

    Prefer:
    - Counterintuitive or contrarian takes
    - Specific, concrete examples over abstract descriptions
    - Moments where the speaker says something quotable or provocative
    - Natural back-and-forth exchanges (questions + answers work great)

    Return an empty array if the talk has no moments worth highlighting.

    For each clip, return the EXACT verbatim words that begin and end it.
    These strings will be searched in the transcript to locate boundaries,
    so they must match character-for-character.

    Talk transcript:
    {{ talk_transcript }}

    {{ ctx.output_format }}
  "#
}

test FindBestClipsTest {
  functions [FindBestClips]
  args {
    talk_title "Prompt Caching with Anthropic"
    speaker_name "Mario"
    talk_transcript #"
      So the thing people don't realize about prompt caching is that it's not just about
      cost. Yes, you save 80 percent on tokens, but the real win is latency. When your
      static context is cached, your time-to-first-token drops dramatically. We went from
      4 seconds to under 400 milliseconds on our most common queries. That's not a
      marginal improvement — that's a product-level difference. Users notice. They go from
      "this feels like a chatbot" to "this feels like a real tool." And the implementation
      is surprisingly simple. You just structure your prompt so the stable parts come first
      — your system instructions, your examples, your context — and the dynamic user input
      goes last. Anthropic's infrastructure handles the rest automatically. No special API
      calls, no cache management on your end. It just works.
    "#
  }
}
