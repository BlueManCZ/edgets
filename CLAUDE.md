# Edgets Overlay

## Package management rules

- Keep only the latest 4 versions of each package. When bumping, delete older ebuilds to stay within this limit.
- After adding/removing ebuilds, run `manifest` (alias for `pkgdev manifest -f --if-modified`) to regenerate the Manifest.
