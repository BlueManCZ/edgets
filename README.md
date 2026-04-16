![edgets](https://user-images.githubusercontent.com/17854950/89108167-99178780-d436-11ea-9a0d-209319390f5b.png)

Gentoo overlay bringing you the latest versions of modern software.

## Installation

Edgets is available through [`eselect-repository`](https://wiki.gentoo.org/wiki/Eselect/Repository):

```bash
emerge --ask app-eselect/eselect-repository
eselect repository enable edgets
emerge --sync
```

## Usage

Most packages in this overlay are keyword-masked. To accept all of them at once for `amd64`, create `/etc/portage/package.accept_keywords/edgets`:

```
*/*::edgets ~amd64
```

Alternatively, unmask packages individually:

```bash
emerge --ask <package-name> --autounmask
dispatch-conf
```

Then install as usual:

```bash
emerge --ask <package-name>
```

> [!TIP]
> Use `>=category/package-version` in your accept_keywords to automatically cover future version bumps.

## Contributing

Found a bug, want a version bump, or have a new package to add? Open an [issue](https://github.com/BlueManCZ/edgets/issues) or submit a [pull request](https://github.com/BlueManCZ/edgets/pulls).
