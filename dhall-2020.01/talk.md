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
