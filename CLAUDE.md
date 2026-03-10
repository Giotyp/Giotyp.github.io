# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal academic portfolio website for George Typaldos, built with Jekyll using the [minimal-light](https://github.com/yaoyao-liu/minimal-light) remote theme. It is hosted on GitHub Pages at `Giotyp.github.io`.

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

The site is a single-page academic portfolio. Content is split across:

- `index.md` — Main page content (About, Education, Research Interests, News). Uses `layout: homepage` and includes the two partials at the bottom via `{% include_relative %}`.
- `_includes/publications.md` — Publications list in raw HTML (Bootstrap-style grid with `.pub-row` and `.col-sm-3/9` classes).
- `_includes/certifications.md` — Certifications section in Markdown.
- `_layouts/homepage.html` — The sole layout: renders the sidebar (avatar, name, position, social icons) and injects `{{ content }}`.
- `_config.yml` — Site-wide variables: `title`, `position`, `affiliation`, `email`, `google_scholar`, `cv_link`, `github_link`, `linkedin`, `avatar`, `favicon`.
- `_sass/minimal-light.scss` — Style overrides on top of the remote theme.
- `assets/css/publications.css` — Styles specific to the publications list.
- `assets/files/CV_GT.pdf` — CV file linked from the sidebar.

## Key Conventions

- **Adding a publication:** Copy an existing `<li>` block in `_includes/publications.md`. The structure is `.pub-row > .col-sm-3` (optional thumbnail) + `.col-sm-9` (title, author, periodical, links).
- **Updating site metadata** (name, email, links, avatar): edit `_config.yml`. Restart `jekyll serve` after changes since config is not hot-reloaded.
- **CV:** Replace `assets/files/CV_GT.pdf` in place; the link in `_config.yml` (`cv_link`) already points to it.
- The remote theme (`yaoyao-liu/minimal-light`) provides the base CSS and layout; local overrides live in `_sass/minimal-light.scss` and `assets/css/style.scss`.
