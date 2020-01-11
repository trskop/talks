% Let's talk about Dhall v2020.01
% [peter.trsko@habito.com](mailto:peter.trsko@habito.com)
% 27th of December 2019


# Dhall

Homepage [dhall-lang.org](https://dhall-lang.org/)

GitHub [github.com/dhall-lang/](https://github.com/dhall-lang/)


# Configuration Language

![Every Brexit: Get ready for Configuration](every-brexit-configuration.png)

Source: [Twitter \@readyforspoons](https://twitter.com/readyforspoons/status/1196737583327436807)


# Primitive types

TODO

TODO: Where to read more.


# Records and Unions

TODO: Products and Coproducts

TODO: Where to read more.


# Functions

TODO: Functions

TODO: Where to read more.


# Builtins

TODO: Builtins

TODO: Where to read more.


# Syntactic Sugar

TODO: Advanced stuff

TODO: Where to read more.


# Imports

![Every Brexit: Get ready for Anything](every-brexit-anything.jpg)

Source: [Twitter \@readyforspoons](https://twitter.com/readyforspoons/status/1202883141263904769)


# Imports

TODO: By examples:

* URLs
* Files
* Environment variables

TODO: Where to read more.


# Imports

TODO: Few examples and limitations.

TODO: Where to read more.


# Normalisation

![Every Brexit: Get ready for Normalisation](every-brexit-normalisation.png)

Source: [Twitter \@readyforspoons](https://twitter.com/readyforspoons/status/1197236126592970754)


# Normalisation

TODO: What is normalisation. Command line examples.

TODO: Where to read more.


# Integrity

![turnoff.us: file checksum](turnoff.us-file-checksum.png)

Source: [turnoff.us/geek/file-checksum/](https://turnoff.us/geek/file-checksum/)


# Integrity

TODO: How are integrity checksums calculated. Binary encoding.

TODO: Where to read more.


# Disintegrity (1)

How not to run Bash scripts from the internet.

`https://raw.githubusercontent.com/digital-asset/ghcide/master/fmt.sh`
(`@da5ab701da02c3cd34d7da1e48803278f777d9db`):

```Bash
#!/usr/bin/env bash
set -eou pipefail
curl -sSL https://raw.github.com/ndmitchell/hlint/master/misc/run.sh | sh -s .
```


# Disintegrity (2)

`https://raw.github.com/ndmitchell/hlint/master/misc/run.sh`
(`@51096caede55b7dc6387e559e6bb866019d2f297`):

```Bash
#!/bin/sh
curl -sSL https://raw.github.com/ndmitchell/neil/master/misc/run.sh | sh -s -- hlint $*
```


# Disintegrity (3)

`https://raw.github.com/ndmitchell/neil/master/misc/run.sh`
(`@80e8e6b9727929fc1366110874969f532ed47774`):

```Bash
#!/bin/sh
# ... some stuff omitted
RELEASES=$(curl --silent --show-error https://github.com/ndmitchell/$PACKAGE/releases)
URL=https://github.com/$(echo $RELEASES | grep -o '\"[^\"]*-x86_64-'$OS$ESCEXT'\"' | sed s/\"//g | head -n1)
VERSION=$(echo $URL | sed -n 's@.*-\(.*\)-x86_64-'$OS$ESCEXT'@\1@p')
TEMP=$(mktemp -d .$PACKAGE-XXXXXX)

cleanup(){
    rm -r $TEMP
}
trap cleanup EXIT

retry(){
    ($@) && return
    sleep 15
    ($@) && return
    sleep 15
    $@
}

retry curl --progress-bar --location -o$TEMP/$PACKAGE$EXT $URL
# ... some other stuff omitted
```


# Disintegrity (4)

```Bash
dhall hash <<< 'https://raw.github.com/ndmitchell/neil/master/misc/run.sh as Text'
sha256:d7f106894d51ba3b1f06cdc899183765bee5b0316f86eb183ca20e013390c54d
```


# Disintegrity (5)

```Bash
dhall text \
  <<< 'https://raw.github.com/ndmitchell/neil/master/misc/run.sh sha256:d7f106894d51ba3b1f06cdc899183765bee5b0316f86eb183ca20e013390c54d as Text \
  | sh -s -- hlint .
...
```


# Disintegrity (6)

```Bash
dhall text \
  <<< 'https://raw.github.com/ndmitchell/neil/master/misc/run.sh sha256:d7f106894d51ba3b1f06cdc899183765bee5b0316f86eb183ca20e013390c54b as Text' \
  | sh -s -- hlint .
dhall:
↳ https://raw.github.com/ndmitchell/neil/master/misc/run.sh sha256:b7f106894d51ba3b1f06cdc899183765bee5b0316f86eb183ca20e013390c54d as Text

Error: Import integrity check failed

Expected hash:

↳ b7f106894d51ba3b1f06cdc899183765bee5b0316f86eb183ca20e013390c54d

Actual hash:

↳ d7f106894d51ba3b1f06cdc899183765bee5b0316f86eb183ca20e013390c54d


1│ https://raw.github.com/ndmitchell/neil/master/misc/run.sh sha256:b7f106894d51ba3b1f06cdc899183765bee5b0316f86eb183ca20e013390c54d as Text

(stdin):1:1
```


# Cache

TODO: `~/.cache/dhall{,-haskell}`; what's the difference; why have it. Show
difference with and without cache on Prelude.

TODO: Where to read more.


# Prelude

TODO:

<https://prelude.dhall-lang.org/>

<https://prelude.dhall-lang.org/package.dhall> whole latest prelude.

<https://prelude.dhall-lang.org/v12.0.0/package.dhall> whole v12.0.0 prelude.

<https://prelude.dhall-lang.org/List/map> vs.
<https://prelude.dhall-lang.org/v12.0.0/List/map>.

<https://github.com/dhall-lang/dhall-lang/tree/v12.0.0/Prelude>

Importing it in examples.

Documentation:

* [github.com/dhall-lang/dhall-lang: Prelude/README.md
  ](https://github.com/dhall-lang/dhall-lang/blob/master/Prelude/README.md)


# Tooling

* Pure command line.

* LSP


# Integration

<https://github.com/dhall-lang/dhall-lang/wiki/How-to-integrate-Dhall>


# Integration

Basically anything:

* Exec `dhall-to-json` or `dhall-to-yaml`, and read the output.

* Exec `dhall text` and read the output.


# Bash Config Example

TODO:

* Show how environment variables can be used properly.


# Haskell Config Example

TODO: Combinators vs. Type Classes


# Haskell Config Example with Context

TODO: Extend context of config file.


# Haskell Template Example

TODO: Using Dhall as templating language in Haskell.


# Haskell Servant Example

TODO



<!--
vim: ft=markdown spell
-->
