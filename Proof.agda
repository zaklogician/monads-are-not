module Proof where
-- we give an example of a structure that satisfies the monad laws, but does not have a join operation.

open import Relation.Binary.PropositionalEquality

F : Set → Set₁
F x = Set → x

return : ∀ {x} → x → F x
return = λ z _ → z

_>>=_ : ∀ {x y} -> F x → (x -> F y) → F y
a >>= f = λ z → f (a z) z

-- Notice that the structure (F,return,>>=) satisfies the monad laws:

left-id : ∀ {S₁ S₂} → (f : S₁ → F S₂) → (a : S₁) →
                      (return a >>= f) ≡ f a
left-id f a = refl


right-id :  ∀ {S₁} → (m : F S₁) →
                     (m >>= return) ≡ m
right-id m = refl


assoc :  ∀ {S₁ S₂ S₃} → (f : S₁ → F S₂) → (g : S₂ → F S₃) → (m : F S₁) →
                        (m >>= f) >>= g ≡ m >>= (λ x → f x >>= g)
assoc f g m = refl


-- One could try to define this monad as the structure (F,return,fmap,join).

fmap : ∀ {S₁ S₂} → (S₁ → S₂) → F S₁ → F S₂
fmap f x = λ z → f (x z)

-- However, a definition with signature
---- join : ∀ {x} → F (F x) → F x
-- cannot typecheck, since
---- Set₁ != Set
---- when checking that the expression F x has type Set.
