# nix

These files control the configuration of my system and home environment.

## Installing

To install and the system-wide configuration run:

```
sudo make install-system
```

For user-specific configuration run:

```
make install-user
```

Or for both:

```
make install
```

## Development

You can use the `shell.nix` file to configure your environment with `nixfmt`.
