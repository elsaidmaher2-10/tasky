# Tasky: interactive demo

A static web demo of the Tasky Flutter app, rebuilt in React (Vite + TypeScript) and shown inside an
iPhone frame. A side panel lets viewers try what a real phone would receive or trigger: notification
banners, the lock screen, shortcuts to every screen, dark/light mode, frame colour and zoom.

The Flutter app in the parent folder is only *read*; nothing in it was changed. The demo does not run
Flutter Web.

## Run

```bash
cd demo
npm install
npm run dev        # development
npm run build      # typecheck + production build -> dist/
npm run preview    # serve the production build
```

`./serve.sh` installs, builds and serves `dist/` on http://localhost:8080.

## Publish

`dist/` is a static site and uses relative asset paths (`base: './'`), so it works from any sub-path
without configuration: GitHub Pages, Netlify, Firebase Hosting, Vercel.

GitHub Pages with Actions, `.github/workflows/deploy.yml` at the repo root:

```yaml
name: Deploy demo
on:
  push:
    branches: [main]
permissions:
  contents: read
  pages: write
  id-token: write
jobs:
  deploy:
    runs-on: ubuntu-latest
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: 22
          cache: npm
          cache-dependency-path: demo/package-lock.json
      - run: npm ci
        working-directory: demo
      - run: npm run build
        working-directory: demo
      - uses: actions/upload-pages-artifact@v3
        with:
          path: demo/dist
      - id: deployment
        uses: actions/deploy-pages@v4
```

Then set **Settings -> Pages -> Source: GitHub Actions**. Commit `demo/package-lock.json` first
(`npm ci` needs it). Check that the action versions are still current.

## What is in the demo

| Screen | Source in the Flutter app |
|---|---|
| Welcome (name form) | `Feature/welcome/welcome_Screen.dart` |
| Home, To Do, Completed, Profile (bottom navigation) | `Feature/main`, `Home`, `Tasks`, `Profile` |
| High priority tasks | `Feature/Tasks/highperiorty_screen.dart` |
| New task | `Feature/addTask/add_task.dart` |
| User details | `Feature/Profile/user_details_screen.dart` |
| Edit sheet, delete dialog, task menu | `core/component/task_list_widget.dart` |

Colours, sizes, strings and behaviour were copied from the Flutter themes and widgets
(`flutter_screenutil` scaling, design size 375x809, is reproduced for the 390x844 phone). Data is
in memory and resets on reload.

## Good to know

- **Notifications are examples.** The Flutter app has no push or local notifications. The three in
  `src/demo.config.ts` (daily reminder, high priority task, achievement) are realistic examples built
  from its core flows. Replace them there.
- **Simulated:** the profile picture picker (the app uses `image_picker`) shows a sample result.
- It is a rebuild, not the real app, so small differences are possible. Say so when you show it.

## Change things

Most edits go in `src/demo.config.ts` (name, accent colour, notifications, shortcut chips). Screens
are in `src/app/`, the phone and panel in `src/shell/`, navigation and notification state in
`src/bridge/DemoContext.tsx`.
