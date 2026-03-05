client<llm> Gemini25Flash {
  provider google-ai
  retry_policy Exponential
  options {
    model "gemini-2.5-flash"
    api_key env.GOOGLE_API_KEY
    generationConfig {
      temperature 0.3
    }
  }
}

retry_policy Exponential {
  max_retries 2
  strategy {
    type exponential_backoff
    delay_ms 300
    multiplier 1.5
    max_delay_ms 10000
  }
}
