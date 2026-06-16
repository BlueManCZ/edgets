# Edgets Overlay

## Package management rules

- Keep only the latest 4 versions of each package. When bumping, delete older ebuilds to stay within this limit.
- Always run `manifest` (alias for `pkgdev manifest -f --if-modified`) after modifying ebuilds or metadata to regenerate the Manifest.

## metadata.xml conventions

- Do not add `<maintainer>` to package metadata.xml — the overlay has no per-package maintainers.
- Include a `<longdescription>` with a brief summary of the package.
- Include `<upstream>` with the appropriate `<remote-id>` (e.g. `sourceforge`, `github`).

## Ebuild conventions

- Copyright header must use the format `# Copyright 1999-YYYY Gentoo Authors`, where YYYY is the current year.
- When HOMEPAGE has multiple URLs, put each on its own indented line.

## Commit message conventions

- `category/package: Bump version to X.Y.Z` — for version bumps
- `category/package: Add ebuild for X.Y.Z` — for new packages
- `category/package: Update ebuild for X.Y.Z` — for ebuild improvements without version change
- `category/package: treeclean` — for package removal
