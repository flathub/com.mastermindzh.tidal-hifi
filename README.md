# tidal-hifi-flatpak

[Tidal-hifi](https://github.com/Mastermindzh/tidal-hifi) build for flatpak

## Building

```sh
flatpak-builder build-dir --user --ccache --force-clean --install com.mastermindzh.tidal-hifi.yml
```

Then you can run it via the command line:

```sh
flatpak run com.mastermindzh.tidal-hifi
```

or just search for the installed app on your system
