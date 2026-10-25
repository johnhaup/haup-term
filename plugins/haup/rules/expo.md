---
paths:
  - "app.json"
  - "app.config.*"
  - "eas.json"
  - "**/*.tsx"
---

# Expo: check the docs, not memory

Expo ships breaking changes every SDK release. Before writing code that touches an Expo, EAS or React Native API:

1. Read the major version of `expo` in `package.json`.
2. Read the versioned docs at `https://docs.expo.dev/versions/v<major>.0.0/`, or start from `https://docs.expo.dev/llms.txt`.
3. Add packages with `bunx expo install <package>` (or `npx` without bun) so versions match the SDK.
4. If `ios/` and `android/` are generated (Continuous Native Generation), never edit them by hand; change `app.json`/`app.config.*` or a config plugin.
