# TalTech HPC Documentation Site

A place to gather notes and documentation. Deployed by GitHub Actions to GitHub Pages.

Created with [Mkdocs](https://www.mkdocs.org/) and beautified with [Material](https://squidfunk.github.io/mkdocs-material/).

## Usage

### Running locally

Install: `pip install -r requirements.txt`

Build and serve locally: `mkdocs serve`

Build: `mkdocs build`

### CI/CD / Workflow info

After build and before deployment, media files are optimized with [jampack](https://github.com/divriots/jampack). It takes about 30 seconds longer than usual to deploy a new build as a result.

Dead links are checked on schedule and on each push. Check Actions to see results and fix dead links!

### Pro tips

Use [admonitions](https://squidfunk.github.io/mkdocs-material/reference/admonitions/) to insert tips, warnings and notices!

---

Use root absolute paths for cross-linking:

```markdown
[Link to another page](/docs/another-page.md)
```

This ensures the link works regardless of the current file's location, thus making it easy to move documentation to other locations/platforms without breaking crosslinks.

Do NOT use relative paths:

```markdown
[Link to another page](../another-page.md)
```

Relative paths can break if the file structure changes.

And do NOT use absolute URLs:

```markdown
[Link to another page](https://docs.example.com/docs/another-page.md)
```

Hardcoding full URLs causes issues with multiple environments (if staging and prod have different domains), when the domain changes, or when doing local development.

### Administration

When changing the domain name (for a custom one or otherwise), following files will need modifications:

- `mkdocs.yml`
- `.github/workflows/deadlink-config.json`
- `CNAME`
