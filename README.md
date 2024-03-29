# Pontte NIX

General utilities to work with NIX at Pontte

NIX, is a package manager for Linux, Windows and Mac, creating isolated and reproducible environment, may help with problems like 'but it worked on my machine' and others.

Also could help with [config sux](https://github.com/cruel-intentions/stylops#related), since it can be used to generate YAML and JSON or other text files, like this README.md that was created by nix/README.nix

Nix has some concepts:

* NixPkgs: nix packages;
* NixLang: nix packages definition language, [isn't hard](https://github.com/tazjin/nix-1p);
* [Cachix](https://www.cachix.org/): Cache of runs (not configured yet);
* NixOS: Linux distribution, we will not use it;
* NixOps: Distributed NixOS configuration, we will not use it;

Other tools could help us are:

* [Makes](https://github.com/fluidattacks/makes): Help create distributed commands with nix, like npx;
* [Niv](https://github.com/nmattia/niv): Help reuse distributed nix code, like npm.

## About this repo

It has two things:

### Common CI/CD commands (using Makes):

* `nix-shell --run 'm github:pontte/ponttix@main /init'` to create basic nix configs;
* `nix-shell --run 'm github:pontte/ponttix@main /notifySlack'` notify that a build was done;

Basic nix config will create a shell with commands:

* `awscli2`: aws command line interface (cli)
* `gh`:  github cli
* `git`: git cli
* `sam`: aws application model cli
* `m`:   Makes cli
* `niv`: niv cli
* `nix`: nix cli

Basic nix configs will create four 'dumb' step for CI/CD

* `m . /check`  to check  your code (configure it with ie eslint)
* `m . /build`  to build  your code (configure it with ie npm run build)
* `m . /test`   to test   your code (configure it with ie npm run test)
* `m . /deploy` to deploy your code (configure it with ie sam deploy)


### Common NIX Lang lib like [shell env](https://nix.dev/tutorials/declarative-and-reproducible-developer-environments#declarative-reproducible-envs) (using Niv);

