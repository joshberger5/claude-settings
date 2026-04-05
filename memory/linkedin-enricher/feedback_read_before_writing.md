---
name: Read library source before writing code that uses it
description: Always read third-party library source before writing code that calls it — do not assume behavior
type: feedback
---

Before writing any code that calls a third-party library, read the relevant source files first. Do not assume what a function does — verify it.

**Why:** Wrote auth code that passed a partial cookie jar without checking that `_set_session_cookies` also required `JSESSIONID`. User had to run the script multiple times to discover the failure.

**How to apply:** Any time code calls a library method (especially auth/session setup), read that method's source with the Read or Grep tool before writing the call. Verify all requirements are met before presenting code to the user.
