# IO

## Points to note
1. To compile haskell file `stack ghc helloworld`
2. *main* has type of the last action in do block
3. <- is to take value out of IO action (helloworld0.hs)
4. *return* makes an IO action out of some value (helloworld1.hs)
5. return **does not** cause IO *do* block to end in execution
6. Last action in a *do* block cannot be bound to a name
7. You can use *let* in *do* block (helloworld2.hs)

---

## Glossary
1. action : Something when performed will have a side effect
2. unit : empty tuple ()
3. IO () : IO action with a **result type** of unit
