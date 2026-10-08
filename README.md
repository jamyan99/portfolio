# Jamiyan Batnyam — portfolio

A static portfolio site. Plain HTML, CSS, and JavaScript — no frameworks, no build
step, no dependencies. Every page is a single self-contained file.

## Pages

| File | What it is |
|---|---|
| `index.html` | Home, styled after the Design Playbook: video hero, selected work, about with toolbelt, three gallery pieces |
| `visual.html` | Gallery: even 3-up grid with a full-screen viewer and zoom |
| `projects/content-plus.html` | Case study: educational screen time for kids |
| `projects/liminal.html` | Case study: wellness app for anxiety support |
| `projects/vibe-coding.html` | Case study: AI-assisted motorcycle dashboard, with a live simulator |
| `404.html` | Not-found page, served automatically by GitHub Pages |
| `.nojekyll` | Stops GitHub from running Jekyll over the files |

## Publishing

Live at **https://jamiyanbatnyam.com**, served by GitHub Pages from the `main` branch
of `github.com/jamyan99/portfolio` (`CNAME` holds the domain, `.nojekyll` turns off
Jekyll). To update the site, commit and `git push`; Pages rebuilds in a minute or two.

DNS records at Spaceship for jamiyanbatnyam.com:

| Type | Host | Value |
|---|---|---|
| A | @ | 185.199.108.153 |
| A | @ | 185.199.109.153 |
| A | @ | 185.199.110.153 |
| A | @ | 185.199.111.153 |
| CNAME | www | jamyan99.github.io |

Every page has a favicon (`favicon.ico`, `apple-touch-icon.png`), a canonical URL and
link-preview tags; the 1200x630 preview images are in `assets/img/og/`. `404.html` uses
root-relative paths because Pages serves it at whatever missing address was requested.

To preview locally, run `npx --yes http-server -p 5180 -c-1` in this folder and open
<http://localhost:5180>. Opened straight from disk (`file://`), the browser blocks the
self-hosted fonts, so serve it to see the real thing.

## Images

Every image and video is self-hosted under `assets/`. The ones that used to load
from Framer's CDN live in `assets/img/framer/` as WebP, named `<framer id>-<size>.webp`
at the sizes the pages ask for (the gallery viewer uses `-1600`, its zoom `-4096`), so
the old Framer site can be unpublished without breaking anything here.

## Things left to fill in

- **Gallery metadata** — `visual.html` has a `PIECES` array at the top of its
  script with empty `title`, `year`, `medium`, and `alt` fields. Fill them in and
  captions appear. The alt text matters most; right now it's a placeholder.
- **Toolbelt names** — `index.html` has a `TOOLS` array with empty `name` fields.
  Each name becomes that icon's alt text.
- **Liminal's research paragraph** — marked `DRAFT` in an HTML comment. It replaces
  a paragraph that was copied from the ContentPlus page by mistake.
- **Vibe Coding: the model version numbers** — worth checking before this is public.

## How it's built

- **Global header.** Every page has the same header: wordmark, Home / Work /
  About / Gallery / Contact, the Let's connect pill, and a menu button
  below 760px. It is fixed, transparent over the home hero until you
  scroll, and solid everywhere else; the current page (on a case study, Work)
  gets the orange dot. It is always 84px tall (72px on phones), scrolled or
  not, so nothing in it moves; `--site-header-h` carries that height to anchors
  and sticky elements. Its CSS ("Global header"), markup and script are
  copied identically into each file, so a change to it has to go into all six.
- **One container.** Every page sits in the same container, 1192px wide with
  24px gutters: the case studies' `.layout`, the gallery, the 404, the footers,
  the home page's `.wrap` and hero text, and the header's content. The logo
  therefore lines up with the content on every page.
- **Moving between pages.** Pages cross-fade (cross-document View Transitions,
  typed `page-nav` so Vibe Coding's own simulator transition keeps its rules)
  while the header holds still as its own layer. Chromium also prerenders a page
  as soon as its link is hovered (a Speculation Rules block in each `<head>`),
  so the click is instant. Reduce motion turns the fade off; other browsers just
  navigate. An inline script at the top of each page applies the OS Reduce
  motion setting before the first paint (there is no on-page toggle).
- **Shared chrome.** The case studies, gallery and 404 also share a footer,
  spacing scale, and heading tiers. The home page has its own footer (below).
- **Home page.** Styled after the Design Playbook portfolio: its tokens, its
  fonts (Bricolage Grotesque and Manrope, self-hosted in `assets/fonts/` with
  their OFL licences), and its looping court video. Screens wider than 760px
  (or at least 1280 device pixels) get the 4K cut (`assets/video/hero-loop-4k.mp4`,
  3.6 MB, poster `assets/img/hero-poster-4k.webp` re-encoded from 856 KB to
  102 KB); others get the 1080p one (`assets/video/hero-loop.mp4`, 2.5 MB,
  poster `assets/img/hero-poster.webp` re-encoded from 600 KB to 51 KB), the
  same rule as the Playbook hero. A tiny blurred copy of the poster fills the
  hero until the poster arrives, and the video only starts loading after the
  page has, so it never holds up the first view. The footer has a second, small loop: the
  character at a laptop, under "Let's find the next good move.", sized in ems of the
  headline so he matches it at every width (head level with the cap top of "Let's
  make", soles on the baseline of "move."). On narrow phones the headline type is
  capped so the pair keeps to two lines (`assets/video/footer-character.mp4`,
  112 KB). The studio grey is flattened in the video itself: a clean background
  plate (character and floor shadow masked out, holes filled by normalized
  convolution) is divided out of every frame, so the background lands on the
  footer colour `#EFEDE8` (calibrated against Chrome's decode, within 1 level)
  while his floor shadow stays. Feathered CSS edges hide the rest. He loads as the
  footer approaches and plays only while on screen. The project cards are this site's own:
  a 2 x 2 grid where every card is the same size at every width.
- **Case study side navigation.** A sticky numbered index with a reading-progress
  bar. Progress comes from real scroll position; the time remaining is derived at
  runtime from that page's own word count at 200 wpm, so it never goes stale when
  the copy changes. It is exposed as a `progressbar` with a live `aria-valuetext`
  and as visible text, and it only appears once the script is running. Below
  1000px the rail becomes a horizontal scrolling strip pinned under the header.
- **Footer utilities.** Copy-email and back-to-top (on the home page, back-to-top
  sits at the right end of the email / LinkedIn / Résumé row). Copy-email is
  revealed by script, so it is never present as a dead control without JS.
- **Motion.** CSS transitions and keyframes plus `IntersectionObserver`, tuned per
  project: quick with a slight bounce for ContentPlus, slow and settling for
  Liminal, precise for Vibe Coding. All of it behind `prefers-reduced-motion`.
- **Liminal v3 screens.** Exported at 2x from the Figma page "Liminal — v3" and
  saved as JPEG in `assets/img/liminal/screens/`. The frame's 36px corner radius
  is applied in CSS (`.shot`), so to update a screen, re-export the frame at 2x and
  replace the file under the same name.
- **Liminal phone renders.** The three images under My Roles (`mockup-*.jpg`) are
  generated phone mockups with the v3 screens composited in Photoshop. The layered
  PSDs (one smart object per screen) are kept outside the repo; swap a screen with
  Replace Contents, then re-export as JPEG.
- **Interactive pieces.** The dashboard simulator and iteration comparison in
  Vibe Coding; the zoomable viewer in the gallery.
- **Image strips.** The home page toolbelt, ContentPlus's Sketches and Mid-Fi
  strips, and Liminal's Low-Fi and Mid-Fi strips all loop endlessly the same
  way (a CSS transform on a track cloned once): they pause under the pointer,
  and Reduce motion (the OS setting) turns them back into
  plain scrollers - trackpad, arrow keys, and on ContentPlus a mouse drag.
  Apart from those and the home hero video, nothing moves on its own, and
  there is no pause/play control anywhere on the site. The home hero and
  the footer character are the only `<video>`s (the case studies show still
  renders instead of recordings): they play only while on screen, and Reduce
  motion (the OS setting) holds them on their first frame.
- **Accessibility.** Keyboard operable throughout, visible focus rings, live
  regions for anything that changes on screen, and content that never depends on
  JavaScript or motion to be readable.
