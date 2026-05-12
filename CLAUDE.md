# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal academic portfolio website for George Typaldos, built with Jekyll using the [minimal-light](https://github.com/yaoyao-liu/minimal-light) remote theme. It is hosted on GitHub Pages at `Giotyp.github.io`.

The site uses a custom "Lab Notebook" visual language layered on top of the remote theme: IBM Plex Serif + IBM Plex Mono, a navy primary with a cobalt-cyan (#0891b2) terminal accent, and a persistent left sidebar containing identity + navigation.

## Git Commits
When asked to generate git commits, keep the message short and avoid adding claude as a coauthor.

## After file modifications
Always update the [CLAUDE.md](CLAUDE.md) if you made any important structure changes.

## Commands

```bash
# Install dependencies
bundle install

# Serve locally with live reload
bundle exec jekyll serve

# Build static site
bundle exec jekyll build
```

## Architecture

The site is a **multi-page** academic portfolio. Each section lives in its own top-level Jekyll page with an explicit `permalink`:

| File                | Permalink          | `nav_key`        |
|---------------------|--------------------|------------------|
| `index.md`          | `/`                | `about`          |
| `education.md`      | `/education/`      | `education`      |
| `research.md`       | `/research/`       | `research`       |
| `news.md`           | `/news/`           | `news`           |
| `publications.md`   | `/publications/`   | `publications`   |
| `teaching.md`       | `/teaching/`       | `teaching`       |
| `certifications.md` | `/certifications/` | `certifications` |
| `service.md`        | `/service/`        | `service`        |

Every page declares `layout: homepage`, a `title`, a `permalink`, and a `nav_key`. The `nav_key` is rendered as `~/<key>` in the small monospace page-meta header at the top of the content column (e.g. `~/research`).

Supporting files:

- `_layouts/homepage.html` — The sole layout. Renders the sidebar (avatar, identity, social icons, primary nav) and the content column. The nav iterates over `site.nav` from `_config.yml`; active state is set via `{% if page.url == item.url %}` which adds `.is-active` to the `<li>`.
- `_config.yml` — Site-wide variables AND the `nav:` list used to render the sidebar. Edit `nav` to add/remove/reorder sections; each entry needs `label` and `url`. Restart `jekyll serve` after editing — config is not hot-reloaded.
- `_sass/minimal-light.scss` — Full style override. Defines color tokens (`--paper`, `--ink`, `--primary`, `--accent`, …) with both `prefers-color-scheme` and `[data-theme]` selectors, typography (IBM Plex), layout (fixed sidebar + content column), the sidebar nav with its active-state vertical bar, and the lab-notebook content utilities (`.log`, `.interests`, `.tag`, `.cert-group`, `.page-meta`).
- `assets/css/publications.css` — Publication list styling. Restyles the Bootstrap-ish `.col-sm-3` / `.col-sm-9` markup as numbered footnote-style entries with monospace metadata.
- `assets/files/CV_GT.pdf` — CV file linked from the sidebar.
- `_includes/` — Currently empty. Previously held partials (`publications.md`, `teaching.md`, `certifications.md`) for the single-page layout; those have been promoted to top-level pages.

## Lab-notebook content utilities

These class hooks live in `_sass/minimal-light.scss` and are how each page builds its content. Use them rather than restyling ad-hoc lists.

- `.log` / `.log li > .ts + .entry [+ .sub]` — Two-column timeline. Used by `news.md`, `education.md`, `teaching.md`. The `.ts` column is monospace cobalt, the `.entry` is serif body.
- `.interests` / `.interests li > .field + .desc` — Used by `research.md`. The `.field` is a monospace lowercase tag (e.g. `computer-systems`) followed by a serif description.
- `.tag-row` / `.tag` — Small monospace tag chips with the cobalt accent background.
- `.cert-group` / `.cert-group .org + .cert-list li > <span> + .when` — Used by `certifications.md`. Each group has an organization heading and a list of items with a right-aligned monospace date column.
- `.page-meta` — Auto-rendered by the layout at the top of every content column. Shows `~/<nav_key>` with a blinking caret.

## Key Conventions

- **Adding a new section page:** Create `<section>.md` at the root with `layout: homepage`, `title:`, `permalink: /<section>/`, and `nav_key: <section>`. Then add `{ label: "<section>", url: "/<section>/" }` to the `nav` list in `_config.yml`.
- **Adding a publication:** Copy an existing `<li>` block in `publications.md`. The structure is `.pub-row > .col-sm-3` (optional thumbnail) + `.col-sm-9` (title, author, periodical, links). The list is auto-numbered `[01], [02], …` via CSS counters.
- **Updating site metadata** (name, email, links, avatar): edit `_config.yml`. Restart `jekyll serve` after changes since config is not hot-reloaded.
- **CV:** Replace `assets/files/CV_GT.pdf` in place; the link in `_config.yml` (`cv_link`) already points to it.
- **Palette / fonts:** All color tokens live in `:root` (and the dark-mode overrides) at the top of `_sass/minimal-light.scss`. The fonts are loaded once in the layout `<head>` via Google Fonts.
- **Dark mode** is driven by `prefers-color-scheme` plus an explicit `[data-theme]` override toggled by `assets/js/theme-toggle.js`. Every theme-sensitive style is declared in all three places.
- The remote theme (`yaoyao-liu/minimal-light`) provides the base CSS and layout; local overrides live in `_sass/minimal-light.scss` and `assets/css/style.scss`.
