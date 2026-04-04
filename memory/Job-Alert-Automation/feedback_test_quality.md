---
name: Tests must assert the full behavioral contract, not just that code runs
description: Tests that don't verify every user-visible property are useless — they let bugs ship
type: feedback
---

Tests must verify the complete behavioral contract of what they're testing. Shallow tests (e.g. "the function returned something") are worse than no tests because they create false confidence.

**Why:** Two bugs shipped that passing tests didn't catch:
1. Inline `<svg>` icons stripped by Gmail/Outlook — the test checked vote links existed but never asserted icon format
2. "Relevant" link had no explicit color — rendered purple in email clients — no test asserted the color property
3. US city locations treated as remote — no test used a realistic "New York, United States" input to verify rejection

**How to apply:**
- For HTML/email rendering: assert every user-visible property — color values, element types (`<img>` not `<svg>`), text content, link structure. If a property matters to the user, there must be a test for it.
- For filtering logic: always include realistic negative inputs (e.g. actual US city strings, not just contrived ones). The bug input itself becomes a required test case.
- Ask: "If someone introduced this exact bug, would my tests catch it?" If the answer is no, the tests are incomplete.
- Never consider a feature "tested" just because the happy path passes. Test the exact properties that could be broken.
