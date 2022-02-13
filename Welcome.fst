module Welcome

open FStar.Mul

let id a = a

let first : Type = x : int { x > 0 }

let greaterThan (a : int) : Type = x : int { x > a }

let n1 : greaterThan 3 = 5

// let n2 : greaterThan 3 = 2

let apply (a b:Type) (f:a -> b) = f

let compose (a b c:Type) (f: b -> c) (g : a -> b) : a -> c = fun x -> f (g(x))

let nat = x : int { x >= 0 }

let snat = x : nat { x <> 0 }

let rec factorial (n : nat) : snat =
    if n = 0
    then 1
    else n * factorial (n - 1)
