---
name: Email screenshot automation via screenshot_email.py
description: Use screenshot_email.py to automate Edge DevTools full-page screenshots — never ask the user to do this manually
type: feedback
---

Use `screenshot_email.py` to take email screenshots. It automates exactly what the user would do manually in Edge DevTools.

```bash
py screenshot_email.py                        # uses latest email automatically
py screenshot_email.py docs/emails/foo.html  # specific file
```

Outputs: `docs/email_preview.png` (full page) and `docs/email_preview_cropped.png` (top 900px crop).

**Why:** Uses pyautogui to drive the actual Edge browser — kills Edge, opens fresh, F12, clicks inside DevTools panel, Ctrl+Shift+P, "Capture full size screenshot". Produces output identical to the user's Edge dark mode rendering.

**How to apply:** Run the script. Never ask the user to take a manual screenshot. Never use Playwright directly.
