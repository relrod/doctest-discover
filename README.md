# doctest-discover-configurator

## Note:

This is a fork of [doctest-discover](https://github.com/karun012/doctest-discover) that removes the dependency on aeson and replaces it with configurator.

---

* Do you have to maintain a list of source files that cabal needs to use to run [doctests](https://hackage.haskell.org/package/doctest)?

doctest-discover (inspired by [hspec-discover](https://hackage.haskell.org/package/hspec-discover)) makes it easy to run doctests via [cabal](http://www.haskell.org/cabal/).

doctest-discover is published on [hackage](https://hackage.haskell.org/package/doctest-discover)

The only thing you need to do is create a driver file with one line (let's call it *doctest-driver.hs*):

```haskell
{-# OPTIONS_GHC -F -pgmF doctest-discover #-}
```

Use it as the main for the test-suite in your cabal file: 
```cabal
test-suite cooler-doctests
  default-language:   Haskell2010
  type:               exitcode-stdio-1.0
  ghc-options:        -threaded
  main-is:            doctest-driver.hs
  build-depends:      base >4 && <5, doctest, doctest-discover
  HS-Source-Dirs:     test
```

doctest-discover is used as a pre-processor. Since there is nothing to pre-process in the file, it builds a temporary file with the code needed to run doctests via cabal.

##Configuration
Configuration uses the [configurator](https://hackage.haskell.org/package/configurator) package. Make sure you put the config file in the root directory of your project. 

To use a config file, change your driver to add the config file name with the -optF flag.
```haskell
{-# OPTIONS_GHC -F -pgmF doctest-discover -optF config.cfg #-}
```

###Ignoring files
```ini
ignore = ["foo.hs", "bar.hs", "baz.hs"]
```

###Source folders
```ini
ignore = ["foo.hs", "bar.hs", "baz.hs"],
sourceFolders = ["src", "src/foobar", "someOtherSource"]
```
