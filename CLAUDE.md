# Edgets Overlay

## Package management rules

- Keep only the latest 4 versions of each package. When bumping, delete older ebuilds to stay within this limit.
- After adding/removing ebuilds, run `manifest` (alias for `pkgdev manifest -f --if-modified`) to regenerate the Manifest.

## Commit message conventions

- `category/package: Bump version to X.Y.Z` — for version bumps
- `category/package: Add ebuild for X.Y.Z` — for new packages
- `category/package: Update ebuild for X.Y.Z` — for ebuild improvements without version change
- `category/package: treeclean` — for package removal
