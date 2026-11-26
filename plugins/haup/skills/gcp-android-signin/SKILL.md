---
name: gcp-android-signin
description: Walk the user through the Google Cloud console setup that lets an Android app sign in with Google and use Google Drive (the app's hidden drive.appdata folder, as cloud sync does), one step at a time with the app's own values filled in. Use when an app needs Google sign-in or Drive sync on Android, or when asked to "set up Google Cloud", "create the OAuth clients" or "walk me through GCP" for an app.
---

# Google sign-in setup for an Android app

This is console work only the user can do. You fill in the values and pace the steps; the `gcp-android-signin` script (haup-term `bin/`) holds the steps themselves.

## 1. Get the filled-in steps

Run `gcp-android-signin <app-dir> --print`. It reads the name, package, debug and upload SHA-1s, support email, home page and privacy policy from the app's `app.json`, `android/`, `credentials.json` and `ship.config.json`.

- If it says it could not find something, ask the user for that value only, then pass it as the option the error names.
- An app that never ships (an example or test app) stays in Testing: pass `--testing <test-account-email>`. Ask which Google account they will sign into the emulator.
- The support email is public. If the user doesn't want their personal address shown, use the app's store contact address (what the script found) and have them sign into the console with that account.
- Several apps: do one app at a time, all steps, so the project in the top bar never changes mid-step. Do the app the test needs first.

## 2. Walk through it

Give the user one step at a time, exactly as printed, and wait for "done" before the next. They can also run the script in a terminal themselves; it pages the same steps.

- When they send a screenshot, read what it actually says before answering. A greyed-out **Publish app** means the Branding links are missing.
- For the Play signing client, ask them to paste the SHA-1 back, and to check the Upload key SHA-1 on the same Play Console page. When the script had no upload keystore, that page is the only place to check the value they entered.
- If Google asks for verification or for anything the steps don't cover, stop and look into it instead of guessing.

## 3. After the console work

- Record what was set up wherever the work is tracked (project names, which clients exist, the test account). Never record passwords; agents never sign in to the test account themselves.
- Say what the app still needs: the code change that turns on Android sign-in or sync, a privacy policy that covers the Google data use, and, for tests, the test account signed into the emulator by the user.
