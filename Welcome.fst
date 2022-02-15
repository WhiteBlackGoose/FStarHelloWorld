module Welcome

open FStar.Mul
open FStar.Math.Lib
open FStar.String
open FStar.IO

let id a = a

let first : Type = x : int { x > 0 }

let greaterThan (a : int) : Type = x : int { x > a }

let n1 : greaterThan 3 = 5

// let n2 : greaterThan 3 = 2

let apply (a b:Type) (f:a -> b) = f

// let (|>) x f = f x

// let compose (a b c:Type) (f: b -> c) (g : a -> b) : a -> c = fun x -> x |> (f << g)

let nat = x : int { x >= 0 }

let snat = x : nat { x <> 0 }

let rec factorial (n : nat) : snat =
    if n = 0
    then 1
    else n * factorial (n - 1)

let sqr n = n * n

// let 

let a = assert(forall (x : int) . x >= 0 \/ x < 0)

// let f = forall (n : nat) . sqr n > 0

// let prime = x : int { x > 1 && (forall (y : int { y > 1 && y < x }) . x % 1 <> 0) }

type expr (a : Type) =
    | Sum : left : expr a -> right : expr a -> expr a
    | Const : v : a -> expr a


let e = Sum (Sum (Const "aaa") (Const "xixi")) (Const "ii")

let rec eval (e : expr int) =
    match e with
    | Sum a b -> eval a + eval b
    | Const a -> a

let rec listLength a (l : list a) : nat =
    match l with
    | [] -> 0
    | hd :: tl -> 1 + listLength a tl

let one a (v : a { hasEq a }) = x : a { x = v }

let two (a : Type { hasEq a }) (v : a) (w : a) = x : a { x = v \/ x = w }

let s1 : two int 1 2 = 1
let s2 : two int 1 2 = 2

let anythingIsEqualToItself = assert (forall (a : Type { hasEq a }) (v : a) . v = v)

type set (a : Type { hasEq a }) : nat -> Type =
    | Empty : set a 0
    | Next : #n:nat -> (hd : a) -> (tl : set a n) -> set a (n + 1)

let rec contains (#n : nat) (#a : Type { hasEq a }) (v : a) (s : set a n) =
    match s with
    | Empty -> false
    | Next hd tl -> hd = v || (contains v tl)

let containsWorks1 = assert(~(contains 3 Empty))
let v = (Next 3 Empty)
let containsWorks2 = assert(contains 3 v)
let containsWorks3 = assert(contains 5 (Next 3 (Next 5 Empty)))
let containsWorks4 = assert(contains 3 (Next 3 (Next 5 Empty)))
let containsWorks5 = assert(~(contains 4 (Next 3 (Next 5 Empty))))



let oneOf (n : nat) (a : eqtype) (s : set a n) = x : a { contains x s }


let j = (Next 3 Empty)
let k = (Next 3 (Next 5 (Next 7 Empty)))


let aaa : oneOf 1 int j = 3
// let aaa : oneOf 1 int (Next 3 Empty) = 3
let bbb : oneOf 3 int k = 5
// let ccc : oneOf 3 int (Next 3 (Next 5 (Next 7 Empty))) = 7
// let ddd : oneOf 3 int (Next 3 (Next 5 (Next 7 Empty))) = 8
// let eee : oneOf 2 int (Next 3 (Next 5 Empty)) = 5

// let r = contains 3 int 5 (Next 3 (Next 6 (Next 7 Empty)))

// let off (a : Type) = x : a { true }

// let hhh : off int = 4

//let rec ohnmmo_terminates (n : nat) : 

// let rec ohnmmo (n : nat) : Tot nat (decreases n) = 
//     if n = 0 then 0
//     else if n % 2 = 1 then ohnmmo (n + 1)
//     else ohnmmo (n - 2)



(*
let rec fact = function
    | 0 -> 1
    | n -> n * fact (n - 1)
*)


let prime = x : int { x > 1 /\ (forall (y : int { y > 1 && y < x }) . x % y <> 0) }

let p1 : prime = 2
let p2 : prime = 5
let p3 : prime = 11
// let p4 : prime = 8

// let afgd : unit -> int = (fun _ -> 3)

// let b = afgd()

let _ = print_string stdout "hello"

(*
let main (input : unit -> string) (output : string -> unit) : int =
    let name = input() in
        let toOut = concat "" [ "Hello, "; name; "!" ] in
            output toOut;
            3

*)