---
name: verify-ui
description: Launch the app and look at a UI change working before reporting it done, on the iOS simulator, Android emulator or a browser. Use after any change to screens, components, layout, styling, navigation or animations, or when asked to "check it in the simulator", "screenshot it" or "make sure it works".
---

# Verify UI

A UI change is not done until you have seen it on screen. Type checks prove it compiles, not that it looks or behaves right.

## 1. Use the project's own tooling first

Check `CLAUDE.md`, `AGENTS.md` and `.claude/skills/` for a QA skill or script (e.g. `device-qa`, `scripts/sim-run.sh`, `.maestro/`). If one exists, use it and stop reading here.

## 2. Pick a device you own

- **Never drive the default booted simulator** or an emulator someone else is using. Other projects run Metro or Expo on it and the two fight.
- Create or reuse a dedicated simulator named `<App> QA`:
  `xcrun simctl list devices | grep "<App> QA"` or `xcrun simctl create "<App> QA" "iPhone 17 Pro"` and boot it by UDID. Pass that UDID to every command below.

## 3. Build and launch

| Project | Build and install |
|---|---|
| Native iOS (Xcode / XcodeGen) | `xcodebuild -scheme <App> -sdk iphonesimulator -destination "id=<UDID>" -derivedDataPath ~/.cache/xcode-dd/<app> build`, then `xcrun simctl install <UDID> <.app>` and `xcrun simctl launch <UDID> <bundle id>` |
| Expo / React Native, JS-only change with a dev build already installed | Start Metro on a free port and open the dev client on that simulator |
| Expo / React Native, native change or no dev build | `bunx expo run:ios --device <UDID>` (or the project's own build script) |
| Android | Boot a named AVD, `./gradlew installDebug` or `bunx expo run:android`, then `adb shell am start` |
| Web | Start the dev server and open it with the browser tools available in this session |

Keep `-derivedDataPath` fixed so repeat builds hit the compiler cache.

## 4. Drive it and look

iOS, with AXe (`brew install cameroncooke/axe/axe`):

```bash
axe describe-ui --udid $U                  # elements, labels, frames
axe tap --label "Save" --udid $U           # or -x/-y
axe swipe --start-x 350 --start-y 450 --end-x 50 --end-y 450 --udid $U
axe type "hello" --udid $U
axe screenshot --output <scratchpad>/shot.png --udid $U
```

Android: `adb shell input tap X Y`, `adb exec-out screencap -p > shot.png`. Maestro flows work on both if the project has them.

Read every screenshot you take. Walk every path the change touches, including empty, loading, error and long-text states, dark mode, and a large Dynamic Type size if text changed.

## 5. Report

Say what you looked at and what you saw, with the screenshot paths. If you could not verify something (needs a real device, CarPlay, a server, an account), say that instead of implying it works.
