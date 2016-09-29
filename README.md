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
ck k
#### Here we set ghci to accept multiline input, change the prompt and to show type for return value
```
:set +m
:set prompt "\x03BB: "
:set +t
```
