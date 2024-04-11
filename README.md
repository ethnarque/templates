# ethnarque Nix Templates

This is my collection of templates to start project is Nix or different languages using Nix.

## Quick start

Create template in `pwd`

```sh
$ git clone git@codeberg.org:ethnarque/templates.git /tmp/templates
$ nix flake init --template /tmp/templates#vala-hello
```

or create a new project directory

```sh
$ git clone git@codeberg.org:ethnarque/templates.git /tmp/templates
$ nix flake new --template /tmp/templates#c-hello ./my-new-project
```

or create a new registry

```sh
$ nix registry monologiques github:monologiques/templates
```

Each template ships with a tutorial (README.md) which explains in details how to use it and extend it.
