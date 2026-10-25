---
paths:
  - "**/*.tsx"
---

# React Native / Expo standards

A project-level CLAUDE.md overrides these.

## Naming & Exports

- **Components:** Named exports (`export function Foo`), PascalCase filenames (`FooBar.tsx`). Never default exports for components.
- **Hooks:** camelCase with `use` prefix (`useMyHook.ts`).
- **Constants:** UPPER_SNAKE_CASE for module-level constants (`MY_CONSTANT`).
- **Types/Interfaces:** Define `interface Props` (or `type Props`) directly above the component that uses it.

## Component Structure

Order within every component:

1. Hooks
2. Callbacks (`useCallback`)
3. Derived values (`useMemo`)
4. Effects (`useEffect`)
5. Return

`StyleSheet.create` always goes at the bottom of the file.

## Rules of Hooks

- **Never call hooks after an early return.** All hooks must run unconditionally at the top of the component.

## Imports

- Prefer absolute imports via aliasing if the project supports it.

## Inline props

- All non-primitive values should be defined inside a useMemo above the component return
- All functions should be defined inside useCallback above the component return
- No inline functions
- No inline non-primitive values

## Animations & Gestures

- **Never use React Native `Animated` or `PanResponder`.** Always use `react-native-reanimated` and `react-native-gesture-handler`.

### Scroll-driven transforms

- **Keep transformed elements inside the ScrollView.** Moving an element outside the scroll view to "simplify" transforms breaks normal scroll participation (the element won't scroll away).
- **Only transform the element that needs the effect.** Wrap a single `Animated.View` around the target (e.g. just the image), not its parent container. Transforming a parent scales/moves all its children (text, buttons, etc.).
- **Check for `overflow: hidden` on ancestors.** Scale and translate transforms render outside the element's bounds. Any ancestor with `overflow: hidden` will clip the result. Remove or adjust it when the transform intentionally exceeds bounds (e.g. overscroll zoom).

## State Management

- Zustand for global state. Don't mirror external/native state with `useState` — the external source is the source of truth.
- Selectors: `useStore((s) => s.field)`.

## Styling

- Always use `StyleSheet.create`. Never hardcode colors inline — use the project's color/palette constants.

## TypeScript

- Strict mode. No `as` casting except where third-party APIs require it.

## Comments

- Only add comments for genuinely complex or non-obvious logic.
- Do not add JSDoc or comments that restate what the function name or signature already conveys.

## Reusable Primitives

- When a styled primitive component (toggle, button, input, etc.) is reused across multiple screens, extract it to a global component prefixed with `App` (e.g. `AppToggle`, `AppButton`). Keep it in `components/`.

## Component Folders

- When a component file grows large (~300+ lines), split into a folder: `index.tsx` orchestrator + `components/` subfolder. Other modules keep importing from the folder entry point.
