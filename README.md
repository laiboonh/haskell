# Learning Haskell

### Setting up GHCI via stack
1. Install [haskell tool stack](https://docs.haskellstack.org/en/stable/README/#how-to-install)
2. `stack setup`
3. `stack ghci`

### Setting up Atom
1. search for package **atom-beautify** **language-haskell** **linter** **linter-hlint**
2. `stack install stylish-haskell`

### Using GHCI
1. To import modules `:m +Data.List`
2. To undo import modules `:m -Data.List`
3. To load `:l workspace.hs`
4. To reload `:r`
5. To find out more info `:i (++)`
6. To find out type `:t (++)`
7. To key in a block of codes `:{ :}`
```haskell
λ> :{
Prelude| k (x,y) = x
Prelude| :}
k :: (t, t1) -> t
```
8. To browse functions in a module `:browse! Data.Maybe`
```haskell
λ> :browse! Data.Maybe
-- not currently imported
Data.Maybe.catMaybes :: [Maybe a] -> [a]
Data.Maybe.fromJust :: Maybe a -> a
Data.Maybe.fromMaybe :: a -> Maybe a -> a
Data.Maybe.isJust :: Maybe a -> Bool
Data.Maybe.isNothing :: Maybe a -> Bool
Data.Maybe.listToMaybe :: [a] -> Maybe a
Data.Maybe.mapMaybe :: (a -> Maybe b) -> [a] -> [b]
Data.Maybe.maybeToList :: Maybe a -> [a]
-- imported via Prelude
maybe :: b -> (a -> b) -> Maybe a -> b
Just :: a -> Maybe a
data Maybe a = Nothing | Just a
Nothing :: Maybe a
```

### Customize GHCI
#### Edit appropriate ghci.conf file.
#### In Windows :  C:\Users\lbh\AppData\Roaming\ghc\ghci.conf
#### In Mac : /Users/lbh/.ghc/ghci.conf
1. Set ghci to accept multiline input
2. Change the prompt
3. Show type after evaluation
4. Set macro for displaying present working Directory
5. Set macro for git add all
6. Set macro for git commit all with message
7. Set macro for git push
```
:set +m
:set prompt "\x03BB> "
:set +t
:def pwd (\_-> System.Directory.getCurrentDirectory >>= print >> return "")
:def gitA (\_ -> System.Process.rawSystem "git" ["add", "-A"] >>= print >> return "")
:def gitC (\m -> System.Process.rawSystem "git" ["commit", "-am", m] >>= print >> return "")
:def gitP (\_ -> System.Process.rawSystem "git" ["push"] >>= print >> return "")
```

### Changing directory within GHCI
```haskell
--because of macro set in earlier step
λ> :pwd
"C:\\Users\\lbh"
λ> :cd haskell\\
λ> :pwd
"C:\\Users\\lbh\\haskell"
```
### Compiling haskell code
1. `stack ghc -- Main.hs -o simple` generates the **interface file** .hi and **object file** .o as well as linking the executable "simple"
2. If your source file has dependencies on other object files they will be linked automatically assuming they are in the same directory

### Compiling modular haskell files
1. Assuming you have a Listy.hs and a ListIntances.hs depends on it
2. `stack ghc -- ListyInstances.hs -I. --make ` We include the current directory and make modules within it discoverable

### Cabal init
1. `cabal init --help`
2. `cabal init -n -l BSD3 --is-executable --language=Haskell2010 -a 'laiboonh' -s 'Saying Hello' -p hello-haskell`
3. `cabal sandbox init` To isolate dependencies to this project, if not dependencies will be installed into package-db in home directory
4. `cabal install --only-dependencies` To install dependencies
5. `cabal build`
6. `./dist/build/hello-haskell/hello-haskell`
7. `cabal repl`

### Including a locally developed library
1. `cabal sandbox init`
2. `cabal sandbox add-source ../hello-haskell`
3. `cabal install --only-dependencies`

### Including Test suite in Cabal
1. `cabal configure --enable-tests`
