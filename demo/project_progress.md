# Project Progress (demo)

_Last updated: 2026-10-10_

## Project summary
Interactive React demo of the Tasky Flutter app (`../lib`), inside an iPhone frame with a side panel
for notifications, lock screen, shortcuts, theme, frame colour and zoom. Original app untouched.

## Tech stack & key decisions
- Vite + React 19 + TypeScript, no router/UI kit/CDN. In-memory navigation stack in `DemoContext`.
- `base: './'` so the static build works from any sub-path.
- The Flutter app has no notifications, so the three in `demo.config.ts` are labelled examples.
- Values copied from the Flutter code, including its quirks (see Known issues).

## Done
- [x] Discovery: screens, theme, data model, flows (D1)
- [x] Screens, store, fake data, bridge (`src/app`, `src/bridge`)
- [x] Shell: phone frame, status bar, banner, lock screen, panel, zoom/fit (`src/shell`)
- [x] Verified with a local esbuild bundle + Playwright at 1440x900, 390x844, 360x740 (no console errors)

## In progress
- [ ] Not verified: `npm run build` (Vite) and `tsc --noEmit` with real `@types/react`. The npm registry
  was blocked in the build environment.

## Next steps
1. `cd demo && npm install && npm run build`; fix anything it reports.
2. Pin `vite` and `@vitejs/plugin-react` (currently `latest`) and commit `package-lock.json`.
3. Publish (see README).

## Known issues / tech debt
- Welcome illustration is tiny: the Flutter code sizes it with `Appsizes.w118`, which is `32.w`.
  Kept as in the original.
- Typo "Please Enetr Your Full Name" and raw menu labels (edit / delete / markAsDone) are the app's own.

## How to run & verify
`npm run dev`, `npm run build`, `npm run preview`.
