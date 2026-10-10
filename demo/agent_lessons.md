# Agent lessons

## [2026-10-10] Reset selectors beat component classes
- **What happened:** `.tasky button {background:none; border:0; padding:0}` overrode `.fab`,
  `.round-arrow` etc., so buttons lost their background, border and padding.
- **Root cause:** a descendant reset (0,1,1) has higher specificity than a single class (0,1,0).
- **Rule going forward:** write scoped resets as `:where(.scope) button` so components can override them.
- **Where it applies:** `src/styles/theme.css`.

## [2026-10-10] Quote URLs inside CSS `url()`
- **What happened:** icons used as CSS masks rendered as solid squares when the bundler inlined SVGs
  as data URLs.
- **Rule going forward:** always write `url("${src}")`, with quotes.
- **Where it applies:** `src/app/components/Icon.tsx`.

## [2026-10-10] TypeScript 6 checks side-effect imports
- **Rule going forward:** declare `*.css` in `vite-env.d.ts` (or reference `vite/client`) or
  `import './x.css'` fails typecheck.

## [2026-10-10] Check the network before planning on npm
- **What happened:** the registry was blocked (403), so Vite and `@types/react` could not be installed.
- **Rule going forward:** test registry access first; if blocked, say so early and state what could
  not be verified.
