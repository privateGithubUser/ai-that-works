class SlopPattern {
  pattern string @description("The specific pattern that makes the text sound AI-generated, e.g. 'overuse of em-dashes', 'corporate buzzwords', 'hollow affirmations'")
  example string @description("A verbatim excerpt from the text that demonstrates this pattern")
  rationale string @description("Why this pattern makes the text sound artificial rather than human")
}

function IdentifySlop(text: string) -> SlopPattern[] {
  client Gemini25Flash
  prompt #"
    {{ _.role('user') }}
    The following text sounds like it was written by AI. Identify the specific patterns that make it sound like AI slop and not like a real human wrote it.

    Text:
    {{ text }}

    {{ _.role('user') }}
    For each pattern you find, give it a name, quote a specific example from the text, and explain why it sounds artificial. Look for things like:
    - Hollow affirmations ("Certainly!", "Great question!", "Absolutely!")
    - Repetitive sentence structure
    - Overuse of em-dashes or semicolons
    - Corporate or buzzword-heavy language
    - Unnaturally balanced "on one hand / on the other hand" framing
    - Generic filler phrases that add no information

    {{ ctx.output_format }}
  "#
}

function FixSlop(text: string, patterns: SlopPattern[]) -> string {
  client Gemini25Flash
  prompt #"
    {{ _.role('user') }}
    Rewrite the following text so it sounds like a real human wrote it. Fix the specific AI-sounding patterns listed below. Keep all the same information and intent — just make it sound natural.

    Original text:
    {{ text }}

    Patterns to fix:
    {% for pattern in patterns %}
    - {{ pattern.pattern }}: {{ pattern.rationale }}
      Example to avoid: "{{ pattern.example }}"
    {% endfor %}

    {{ _.role('user') }}
    Rewrite the text. Output only the rewritten text with no preamble, explanation, or meta-commentary.

    {{ ctx.output_format }}
  "#
}
