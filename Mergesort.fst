module Mergesort

open FStar.Mul
open FStar.Math.Lib
open FStar.IO

let rec length l : nat =
    match l with
    | [] -> 0
    | _ :: t -> 1 + length t

let rec sorted (l : list int) =
    match l with
    | [] | [ _ ] -> true
    | a :: b :: tl -> a <= b && sorted (b :: tl)


// MERGE


let rec merge (a : list int) (b : list int)
    : c : list int { length c = length a + length b } =
    match a, b with
    | [], o | o, [] -> o
    | h1 :: t1, h2 :: t2 ->
        if h1 <= h2 then
            h1 :: merge t1 b
        else
            h2 :: merge a t2


let rec mergedCorrectly (l : list int) (r : list int)
    : Lemma (requires sorted l /\ sorted r)
            (ensures sorted (merge l r)) =
    match l, r with
    | [], _ | _, [] -> ()
    | h1 :: t1, h2 :: t2 ->
        mergedCorrectly t1 (h2 :: t2);
        mergedCorrectly (h1 :: t1) t2


// SPLIT


let rec split #a (s : list a) : x : (list a & list a) { length (fst x) + length (snd x) = length s } =
    match s with
    | [] -> [], []
    | h1 :: [] -> [ h1 ], []
    | h1 :: h2 :: [] -> [ h1 ], [ h2 ]
    | h1 :: h2 :: tl ->
        let (l, r) = split tl in
        h1 :: l, h2 :: r

let splitLemma #a (s : list a)
    : Lemma (requires length s >= 2)
            (ensures length (fst (split s)) < length s /\ length (snd (split s)) < length s)
    = ()


// MERGE SORT


let rec mergeSort (l : list int) : Tot (r : list int { length r = length l }) (decreases (length l)) =
    match l with
    | [] -> []
    | [ a ] -> [ a ]
    | [ a; b ] ->
        if a < b then [ a; b ]
        else [ b; a ]
    | other ->
        let (left, right) = split other in
        merge (mergeSort left) (mergeSort right)


let rec sortReturnsSorted (l : list int)
    : Lemma (ensures sorted (mergeSort l)) (decreases length l) =
    match l with
    | [] | [ _ ] | [ _; _ ] -> ()
    | other ->
        let (left, right) = split other in
        assert(length left < length other /\ length right < length other); 
        sortReturnsSorted left;
        sortReturnsSorted right;
        mergedCorrectly (mergeSort left) (mergeSort right)
      


