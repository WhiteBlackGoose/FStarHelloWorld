module Mergesort

open FStar.Mul
open FStar.Math.Lib
open FStar.IO

let rec length l : nat =
    match l with
    | [] -> 0
    | _ :: t -> 1 + length t

let rec merge (a : list int) (b : list int) : c : list int { length c = length a + length b } =
    match a, b with
    | [], o | o, [] -> o
    | h1 :: t1, h2 :: t2 ->
        if h1 < h2 then
            h1 :: merge t1 b
        else
            h2 :: merge a t2

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
let split #a (l : list a) : (le : list a { length le = halve (length l) }) & (ri : list a { length ri = length l - halve (length l) }) =
    let len = length l in
        (take l (halve len), drop l (len - halve len))
*)

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
        let len = length other in
        let left = take other (halve len) in
        let right = drop other (len - halve len) in 
        merge (mergeSort left) (mergeSort right)
        // let (left, right) = split other in   
        //     merge (mergeSort left) (mergeSort right)

// #reset-options