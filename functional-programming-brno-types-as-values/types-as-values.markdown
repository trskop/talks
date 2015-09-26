% Types as Values
% Peter Trško \<<peter.trsko@gmail.com>\>
% 30th May, 2015


# Introduction

# Values, Types, and Kinds

## Haskell Type Hierarchy

```Haskell
value :: type
type :: kind
```

## Haskell Type Hierarchy (example)

```Haskell
1 :: Int
Int :: *
```

# Information Loss

## read . show

```Haskell
read . show
```

<div class="incremental">
Have you ever tried this? Lets try it together, in GHCi.

```
[ someone@something types-as-values ]$ ghci
GHCi, version 7.10.1: http://www.haskell.org/ghc/  :? for help
Prelude> read . show $ True
*** Exception: Prelude.read: no parse
```

What the `<$>` happened? Let us investigate.

```
Prelude> :set -Wall
Prelude> read . show $ True

<interactive>:4:1: Warning:
    Defaulting the following constraint(s) to type ‘()’
      (Read a0) arising from a use of ‘it’ at <interactive>:4:1-18
      (Show a0) arising from a use of ‘print’ at <interactive>:4:1-18
    In the first argument of ‘print’, namely ‘it’
    In a stmt of an interactive GHCi command: print it
*** Exception: Prelude.read: no parse
```
</div>

## read . show (again)

<div class="incremental">

```Haskell
-- Type signature intentionally omitted.
example = read . show $ True
```

```Haskell
[ someone@something types-as-values ]$ ghci information-loss-example.hs 
GHCi, version 7.10.1: http://www.haskell.org/ghc/  :? for help
[1 of 1] Compiling Main             ( information-loss-example.hs, interpreted )

information-loss-example.hs:2:8:
    No instance for (Read c0) arising from a use of ‘read’
    The type variable ‘c0’ is ambiguous
    Relevant bindings include
      bool :: c0 (bound at information-loss-example.hs:2:1)
    Note: there are several potential instances:
      instance (GHC.Arr.Ix a, Read a, Read b) => Read (GHC.Arr.Array a b)
        -- Defined in ‘GHC.Read’
      instance Read a => Read (Maybe a) -- Defined in ‘GHC.Read’
      instance (Integral a, Read a) => Read (GHC.Real.Ratio a)
        -- Defined in ‘GHC.Read’
      ...plus 25 others
    In the first argument of ‘(.)’, namely ‘read’
    In the expression: read . show
    In the expression: read . show $ True
Failed, modules loaded: none.
```

</div>

## Phantom of The Type (Soap)Opera

We lost the type information. How can we pass it around?

<div class="incremental">
```Haskell
data Proxy a = Proxy
```

Eh, not really.

```Haskell
{-# LANGUAGE PolyKinds #-}

data Proxy (a :: k) = Proxy
```

Do I need to care about `PolyKinds`? That depends. Do you want to be ready for
dependent types in Haskell?

```Haskell
{-# LANGUAGE TupleSections #-}

import Data.Proxy -- Surprisingly, this is in base. And the Thanks goes to ekmett.


readMe :: Read a => (String, Proxy a) -> a
readMe (str, _) = read str

showMe :: Show a => a -> (String, Proxy a)
showMe = (, Proxy) . show

example = readMe . showMe $ True
```
</div>

We have just successfully passed around a type variable.


# The Phantom Menace, err, Delight

## This Tea You Serve is Delightful 

<div class="incremental">

<div>
* We can pass around types as first class citizens.
</div><div>
* Phantom types passed using `Proxy` allow us to get rid of those ugly
  `undefined :: Type` expressions.
</div><div>
Wait, that's it?! No, we are just getting started.
</div>

</div>

## Exception Handling

```Haskell
import Control.Exception
import Data.Proxy


someException :: Proxy SomeException
someException = Proxy

ignoring :: Exception e => IO () -> Proxy e -> IO ()
ignoring m proxy = m `catch` \e -> handler (e `asProxyTypeOf` proxy)
  where
    handler _ = return ()

example :: IO ()
example = do
    error "Hear, hear, we have an ERROR in our land!"
        `ignoring` someException
    putStrLn "Nothing ever happens in this town."
```

## Apples And Oranges Do Not Mix Well

```Haskell
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE PolyKinds #-}

import Data.Coerce


newtype Weight (t :: k) = Weight {getWeight :: Rational}

data Apple
data Orange

type AppleIdx = Weight Apple
type OrangeIdx = Weight Orange

sumWeight :: [Weight t] -> Weight t
sumWeight = Weight . sum . map getWeight
```

<div class="incremental">
```Haskell
sumWeight' :: [Weight t] -> Weight t
sumWeight' = coerce . sumRational . coerce
  where
    sumRational = sum :: [Rational] -> Rational
```
</div>


## Same Food, Multiple Flavors

Get down and dirty with phantom types on a first date. Don't forget to be safe
with [tagged](https://hackage.haskell.org/package/tagged).

```Haskell
{-# LANGUAGE DefaultSignatures #-}
{-# LANGUAGE FlexibleContexts #-}
import Data.Tagged
import Data.Monoid
import Data.Coerce
import Data.Proxy


class Wrapp t where
    wrapped :: Proxy t -> (t a -> t a) -> a -> a

    default wrapped
        :: (Coercible a (t a), Coercible (t a) a)
        => Proxy t -> (t a -> t a) -> a -> a
    wrapped _ = (coerce .) . (. coerce)

    wrappedFold :: Proxy t -> ([t a] -> t a) -> [a] -> a

    default wrappedFold
        :: (Coercible [a] [t a], Coercible (t a) a)
        => Proxy t -> ([t a] -> t a) -> [a] -> a
    wrappedFold _ = (coerce .) . (. coerce)

instance Wrapp Sum
instance Wrapp Product
```

<!--
vim: filetype=markdown spell spelllang=en
-->
