module Mergesort

open FStar.Mul
open FStar.Math.Lib
open FStar.IO

#set-options "--initial_fuel 10 --initial_ifuel 10"

let rec length l : nat =
    match l with
    | [] -> 0
    | _ :: t -> 1 + length t

let rec sorted (l : list int) =
    match l with
    | [] | [ _ ] -> true
    | a :: b :: tl -> a <= b && sorted (b :: tl)

let rec merge (a : list int) (b : list int)
    : c : list int { length c = length a + length b /\ (sorted a /\ sorted b ==> sorted c) } =
    match a, b with
    | [], o | o, [] -> o
    | h1 :: t1, h2 :: t2 ->
        if h1 <= h2 then
            h1 :: merge t1 (h2 :: t2)
        else
            h2 :: merge (h1 :: t1) t2

let rec take #a (l : list a) (n : nat { n <= length l }) : r : list a { length r = n } =
    if n = 0 then []
    else match l with | hd :: tl -> hd :: take tl (n - 1)

let rec drop #a (l : list a) (n : nat { n <= length l }) : r : list a { length r = length l - n } =
    if n = 0 then l
    else match l with | _ :: tl -> drop tl (n - 1)

let rec halve (n : nat) : d : nat { d <= n } =
    match n with
    | 0 | 1 -> 0
    | other -> 1 + halve (n - 2)

let rec divBy2IsLess (n : nat)
    : Lemma (halve n <= n) =
    match n with
    | 0 | 1 -> ()
    | other ->
        divBy2IsLess (other - 1)

let nMinusItsHalfIsLess (n : nat) : Lemma (n - halve n <= n) = ()

(*
let split #a (l : list a)
    : x : (list a & list a) { length (fst x) + length (snd x) = length l } =
    let len = length l in
        (take l (halve len), drop l (len - halve len))
*)

(*
let rec split #a (s left right : list a)
    : x : (list a & list b) {  } =
    match s with
    | [] -> left, right
    | h1 :: [] -> h1 :: left, right
    | h1 :: h2 :: [] -> h1 :: left, h2 :: right
    | h1 :: h2 :: tl -> split tl (h1 :: left) (h2 :: right)
*)

let rec split #a (s : list a) : x : (list a & list a) { length (fst x) + length (snd x) = length s } =
    match s with
    | [] -> [], []
    | h1 :: [] -> [ h1 ], []
    | h1 :: h2 :: [] -> [ h1 ], [ h2 ]
    | h1 :: h2 :: tl ->
        let (l, r) = split tl in
        h1 :: l, h2 :: r


let nMinusHalfPlusHalf (n : nat) : Lemma (halve n + (n - halve n) = n) = ()

// #set-options "--initial_fuel 10 --initial_ifuel 10"

let rec mergeSort (l : list int) : Tot (r : list int { length r = length l }) (decreases (length l)) =
    match l with
    | [] -> []
    | [ a ] -> [ a ]
    | [ a; b ] ->
        if a < b then [ a; b ]
        else [ b; a ]
    | other ->
        // let len = length other in
        // let left = take other (halve len) in
        // let right = drop other (len - halve len) in 
        // merge (mergeSort left) (mergeSort right)
        let (left, right) = split other in
        merge (mergeSort left) (mergeSort right)


let rec mergedCorrectly (l : list int) (r : list int)
    : Lemma (sorted l /\ sorted r ==> sorted (merge l r)) =
    match l, r with
    | [], _ | _, [] -> ()
    | h1 :: t1, h2 :: t2 ->
        mergedCorrectly t1 (h2 :: t2);
        mergedCorrectly (h1 :: t1) t2

(*
let rec sortedCorrectly (l : list int)
    : Lemma (ensures (sorted (mergeSort l))) (decreases (length l)) =
    match l with
    | [] | [ _ ] | [ _; _ ] -> ()
    | other ->
        let (left, right) = split other in
        // assert (sorted (mergeSort left));
        // assert (sorted (mergeSort right));
        sortedCorrectly (merge (mergeSort left) (mergeSort right))
*)

// #reset-options



// let sorts1 = assert(sorted (mergeSort [ 1; 2; 3 ]))
// let sorts2 = assert(sorted (mergeSort [ 4; 5; 1 ]))
// let sorts3 = assert(sorted (mergeSort [ 5; -1 ]))
// let sorts4 = assert(sorted (mergeSort [ 0; 9; 1; 4; 5 ]))

