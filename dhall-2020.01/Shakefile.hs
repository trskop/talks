#!/usr/bin/env stack
{- stack script
    --resolver lts-14.20
    --package directory
    --package executable-path
    --package shake
    --
-}

{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
--{-# LANGUAGE GeneralizedNewtypeDeriving #-}
--{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE RecordWildCards #-}
--{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeFamilies #-}

{-# OPTIONS_GHC -Wall #-}

-- |
-- Module:      Main
-- Description: Build presentation.
-- Copyright:   (c) 2018-2019 Peter Trško
-- License:     BSD3
--
-- Maintainer:  peter.trsko@gmail.com
-- Stability:   experimental
-- Portability: GHC specific language extensions.
--
-- Build presentation.
module Main (main)
  where

import Control.Monad (unless)
import System.Exit (die)

import System.Directory (setCurrentDirectory)
import System.Environment.Executable (ScriptPath(..), getScriptPath)

import Development.Shake
import Development.Shake.FilePath


data Directories = Directories
    { srcDir :: FilePath
    , outDir :: FilePath
    }

main :: IO ()
main = do
    projectRoot <- getScriptPath >>= \case
        Executable executable ->
            pure $ takeDirectory executable

        RunGHC script ->
            pure $ takeDirectory script

        Interactive ->
            die "Interactive mode not supported; call shakeMain directly."

    let srcDir = projectRoot
        outDir = projectRoot </> "out"

    setCurrentDirectory projectRoot
    shakeMain Directories{..} shakeOptions

shakeMain :: Directories -> ShakeOptions -> IO ()
shakeMain Directories{..} opts = shakeArgs opts $ do
    want [outDir </> "talk.html"]

    fmap (outDir </>) ["*.css", "*.jpeg", "*.jpg", "*.png"] |%> copyAretefact

    (outDir </> "*.html") %> \out -> do
        let src = srcDir </> takeFileName out -<.> "md"
            css = "slides.css"

        need
            [ src
            , outDir </> css
--          , outDir </> "background-1.png"
--          , outDir </> "background-title-page.png"
            , outDir </> "every-brexit-algebra.jpeg"
            , outDir </> "every-brexit-anything.jpg"
            , outDir </> "every-brexit-configuration.png"
            , outDir </> "every-brexit-normalisation.png"
            , outDir </> "turnoff.us-file-checksum.png"
            ]

        targetExists <- doesDirectoryExist outDir
        unless targetExists
            $ cmd_ "mkdir -p" [outDir]

        cmd_ "pandoc --standalone --email-obfuscation=none"
            "--from=markdown --to=slidy"
            ["--output=" <> out, "--css=" <> css, src]
  where
    copyAretefact out = do
        let src = srcDir </> "data" </> takeFileName out
        need [src]
        cmd_ "cp -f" [src, out]

-- vim:ft=haskell
