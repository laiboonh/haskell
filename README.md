# Learning Haskell

### Setting up GHCI via stack
1. Install [haskell tool stack](https://docs.haskellstack.org/en/stable/README/#how-to-install)
2. `stack setup`
3. `stack ghci`

### Setting up Atom
1. search for package **atom-beautify** **language-haskell**
2. `stack install stylish-haskell`

### Using GHCI
1. To import modules `:m +Data.List`
2. To undo import modules `:m -Data.List`
3. To load `:l workspace.hs`
4. To reload `:r`
5. To find out more info `:i (++)`
6. To find out type `:t (++)`

### Customize GHCI
1. Edit appropriate ghci.conf file. In Windows :  C:\Users\lbh\AppData\Roaming\ghc\ghci.conf
####
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
1. `stack ghc helloworld`
2. Run helloworld.exe
