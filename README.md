![edgets](https://user-images.githubusercontent.com/17854950/89108167-99178780-d436-11ea-9a0d-209319390f5b.png)
The main goal of edgets overlay is to bring you the newest versions of modern software available across the internet.

## Getting started

Edgets is available through [eselect/repository](https://wiki.gentoo.org/wiki/Eselect/Repository), so all you need to do is install `app-eselect/eselect-repository` (if you don't have already) and enable the repository.

```
# emerge --ask app-eselect/eselect-repository
# eselect repository enable edgets
# emerge --sync
```

## Unmasking packages

Most of the packages are masked, so you have to unmask them or tell portage to do so.

```
# emerge --ask <package-name> --autounmask   # type yes
# dispatch-conf                              # press u
```

More information about unmasking [here](https://wiki.gentoo.org/wiki/Knowledge_Base:Unmasking_a_package).

If you, for example, want to unmask all packages from this overlay for architecture `amd64`, create file `/etc/portage/package.accept_keywords/edgets` with following content:

```
*/*::edgets ~amd64
```

## Installing packages

Now, when overlay is added and package unmasked, you are ready to install it.

```
# emerge --ask <package-name>
```

## Upgrading packages

Synchronize overlay tree and unmask newest version of package.

```
# emerge --sync
# emerge --ask <package-name> --autounmask   # type yes
# dispatch-conf                              # press u
# emerge --ask <package-name>
```

You can use `>=` in `/etc/portage/package.accept_keywords/package.accept_keywords` to avoid manual unmasking for every version bump.

## Featured packages

See [PACKAGES.md](https://github.com/BlueManCZ/edgets/blob/master/PACKAGES.md)

## Contribution

If you want to add, update or fix some package ebuild in edgets overlay,<br>
you can open new [issue](https://github.com/BlueManCZ/edgets/issues) or create a [pull request](https://github.com/BlueManCZ/edgets/pulls). Your contribution is welcome.
