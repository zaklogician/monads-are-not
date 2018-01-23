# monads-are-not

*Monads are not just monoids in the category of endofunctors.*

Haskell monads have two associated functions: 

```
return :: a -> m a
(>>=) :: m a -> (a -> m b) -> m b
```

These should obey the three [monad laws](https://wiki.haskell.org/Monad_laws):

* Left identity: `return a >>= f  ==  f a`
* Right identity: `m >>= return  ==  m`
* Associativity: `(m >>= f) >>= g  ==  m >>= (\x -> f x >>= g)` 


However, it is also possible to define a monad in terms of `return`, `fmap` and
`join`:

```
return :: a -> m a
fmap :: (a -> b) -> m a -> m b
join :: m (m a) -> m a
```

This formulation fits more closely with the original definition of monads in 
category theory, and gives rise to the popular joke-explanation:

*Monads are just monoids in the category of endofunctors.*

Unfortunately, this summary is subtly wrong. Some type theories (such as the dependent
type theory of Agda) have universes of types, which makes the two definitions
different. The problem is that the types `a` and `m a` may live in two different
universes, and then the expression `m (m a)` does not make sense.

We give an Agda example of a "monad" `F` that satisfies the first definition, 
but not the second one. This `F` is a monad in the sense of functional
programming, but not in the sense of category theory, thus showing that monads 
are more than just monoids in the category of endofunctors.
