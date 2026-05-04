# Gabriele Mantovani Banella resume

This repository contains the Hugo source for https://mantoga.github.io.

The generated site is published from the `public/` submodule, which points to
https://github.com/mantoga/mantoga.github.io.

## Repository layout

- `config.toml`: main Hugo configuration.
- `content/`: Markdown pages and project entries.
- `static/`: images, PDFs, and other static assets copied into the generated site.
- `themes/coder/`: active Hugo theme.
- `public/`: generated GitHub Pages site, tracked as a separate Git repository.

## Local development

Install Hugo Extended, then run:

```bash
hugo server -D
```

The local site is served at http://localhost:1313.

## Build

```bash
hugo -t coder
```

This writes the generated site into `public/`.

## Publish

The publishing flow has two Git repositories:

1. Commit source changes in this repository.
2. Build with Hugo.
3. Commit and push the generated output from `public/`.

The helper script does step 2 and step 3:

```bash
./deploy.sh "Update site"
```

After publishing, commit the source changes from the project root:

```bash
git add .
git commit -m "Update resume source"
git push origin master
```
