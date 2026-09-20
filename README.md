# Jamiyan Batnyam — portfolio

A static portfolio site. Plain HTML, CSS, and JavaScript — no frameworks, no build
step, no dependencies. Every page is a single self-contained file.

## Pages

| File | What it is |
|---|---|
| `index.html` | Home: hero, featured work, gallery teaser, about, toolbelt |
| `visual.html` | Gallery: even 3-up grid by default, filterable, with a full-screen viewer and zoom |
| `projects/content-plus.html` | Case study: educational screen time for kids |
| `projects/liminal.html` | Case study: wellness app for anxiety support |
| `projects/vibe-coding.html` | Case study: AI-assisted motorcycle dashboard, with a live simulator |
| `404.html` | Not-found page, served automatically by GitHub Pages |
| `.nojekyll` | Stops GitHub from running Jekyll over the files |

## Publishing to GitHub Pages

1. Create a repository (for a personal site, name it `<your-username>.github.io`).
2. Copy everything in this folder into it, keeping the structure.
3. `git add . && git commit -m "Portfolio site" && git push`
4. In the repository: **Settings → Pages → Build and deployment → Deploy from a
   branch**, pick `main` and `/ (root)`.
5. It goes live in a minute or two.

To preview locally, run `python3 -m http.server` in this folder and open
<http://localhost:8000>.

## ⚠️ Read this before unpublishing the Framer site

Every image and video on these pages still loads from Framer's servers
(`framerusercontent.com`). **If you unpublish or delete the Framer site, the
images disappear from here too.**

Run `./fetch-assets.sh` first. It downloads every asset into `assets/`, rewrites
the HTML to point at the local copies, and saves `.bak` files in case you want to
undo it. Some source files are very large — the biggest is 7000px wide — so resize
them before committing if repository size matters.

## Things left to fill in

- **Gallery metadata** — `visual.html` has a `PIECES` array at the top of its
  script with empty `title`, `year`, `medium`, and `alt` fields. Fill them in and
  captions appear. The alt text matters most; right now it's a placeholder.
- **Toolbelt names** — `index.html` has a `TOOLS` array with empty `name` fields.
  Each name becomes that icon's alt text.
- **Liminal's research paragraph** — marked `DRAFT` in an HTML comment. It replaces
  a paragraph that was copied from the ContentPlus page by mistake.
- **Vibe Coding: the model version numbers** — worth checking before this is public.
- **Typos inside images** — "Succesful" and "Unsuccesful" in Liminal's test-results
  images, and the SCAD Portal placeholder text in its style guide. These live in the
  image files, so they need fixing in Figma.

## How it's built

- **Shared chrome.** Every page uses the same nav, footer, spacing scale, and
  heading tiers.
- **Case study side navigation.** A sticky numbered index with a reading-progress
  bar. Progress comes from real scroll position; the time remaining is derived at
  runtime from that page's own word count at 200 wpm, so it never goes stale when
  the copy changes. It is exposed as a `progressbar` with a live `aria-valuetext`
  and as visible text, and it only appears once the script is running. Below
  1000px the rail becomes a horizontal scrolling strip pinned under the header.
- **Footer utilities.** Copy-email, a reduce-motion toggle that overrides the OS
  setting and is remembered in `localStorage`, and back-to-top. The first two are
  revealed by script, so they are never present as dead controls without JS.
- **Motion.** CSS transitions and keyframes plus `IntersectionObserver`, tuned per
  project: quick with a slight bounce for ContentPlus, slow and settling for
  Liminal, precise for Vibe Coding. All of it behind `prefers-reduced-motion`.
- **Interactive pieces.** The dashboard simulator and iteration comparison in
  Vibe Coding; the filters, layout toggle, and zoomable viewer in the gallery.
- **Image strips.** The toolbelt and the wireframe/sketch strips are plain
  horizontal scrollers - drag, trackpad, arrow keys. Nothing advances on its
  own, so there is no pause/play control anywhere on the site. The only
  playback controls left are the native ones on the `<video>` recordings,
  which are what lets a visitor stop a clip that autoplays.
- **Accessibility.** Keyboard operable throughout, visible focus rings, live
  regions for anything that changes on screen, and content that never depends on
  JavaScript or motion to be readable.
