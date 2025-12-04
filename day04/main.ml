(* Read all lines of a file *)
let rec readLines file =
  try
    let line = input_line file in
    line :: readLines file
  with e -> []

(* Open File and read lines *)
let file = open_in "input2.txt"
let lines = readLines file;;

close_in file;;

(* Get an value for @ and . on in a position of the text *)
let getLine (lines : 'string list) (posY : int) : string =
  try List.nth lines posY
  with e ->
    (* print_string "error Nothing"; *)
    "Nothing"

let getChar (lines : 'string list) (posX : int) (posY : int) : int =
  let str = getLine lines posY in
  if String.length str <= posX || posX < 0 then 0
  else
    let character = String.get str posX in
    if character == '@' then 1 else if character == '.' then 0 else 0

(* Get how much not empty arround *)
let countAdjacent (lines : 'string list) (posX : int) (posY : int) : int =
  getChar lines (posX - 1) (posY - 1)
  + getChar lines (posX - 0) (posY - 1)
  + getChar lines (posX + 1) (posY - 1)
  + getChar lines (posX - 1) (posY - 0)
  + getChar lines (posX + 1) (posY - 0)
  + getChar lines (posX - 1) (posY + 1)
  + getChar lines (posX - 0) (posY + 1)
  + getChar lines (posX + 1) (posY + 1)

(* Variables *)
let maxX = String.length (getLine lines 0) - 1
let maxY = List.length lines - 1

let rec thoughAllCpt (lines : 'string list) (posX : int) (posY : int) : int =
  if posY > maxY then 0
  else if posX > maxX then thoughAllCpt lines 0 (posY + 1)
  else if getChar lines posX posY == 0 then thoughAllCpt lines (posX + 1) posY
  else
    let accessible = countAdjacent lines posX posY < 4 in
    if accessible == true then 1 + thoughAllCpt lines (posX + 1) posY
    else thoughAllCpt lines (posX + 1) posY
;;

(* Calcul Part 1 *)
print_int (countAdjacent lines 0 0);;
print_char '\n';;
print_int (thoughAllCpt lines 0 0);;
print_char '\n';;

(* Partie 2 *)
(* Give the list of what should be delete *)
let rec thoughAllToDelete (lines : 'string list) (posX : int) (posY : int) =
  if posY > maxY then []
  else if posX > maxX then thoughAllToDelete lines 0 (posY + 1)
  else if getChar lines posX posY == 0 then
    thoughAllToDelete lines (posX + 1) posY
  else
    let accessible = countAdjacent lines posX posY < 4 in
    if accessible == true then
      (posX, posY) :: thoughAllToDelete lines (posX + 1) posY
    else thoughAllToDelete lines (posX + 1) posY

(* Modify lines by new *)
let rec removeFromLines (lines : 'string list) toRemoveData (posX : int)
    (posY : int) =
  match lines with
  | h :: t ->
      inLineRemove h toRemoveData posX posY
      :: removeFromLines t toRemoveData posX (posY + 1)
  | [] -> []

and inLineRemove (line : string) toRemoveData (posX : int) (posY : int) =
  if List.mem (posX, posY) toRemoveData == false then
    if posX <= maxX then
      String.cat
        (String.make 1 (String.get line posX))
        (inLineRemove line toRemoveData (posX + 1) posY)
    else ""
  else if posX <= maxX then
    (* let _ = print_string "dd\n" in *)
    String.cat "." (inLineRemove line toRemoveData (posX + 1) posY)
  else ""

(* Test of part 2 *)
let toRemove = thoughAllToDelete lines 0 0
let newLines = removeFromLines lines toRemove 0 0;;

print_int (thoughAllCpt newLines 0 0);;
print_char '\n';;
print_char '\n';;
print_char '\n';;
print_char '\n';;

(* Loop on all step of removing *)
let rec whileEqual (lines : 'string list) (pred : int) =
  let res = thoughAllCpt lines 0 0 in
  let toRemove = thoughAllToDelete lines 0 0 in
  let newLines = removeFromLines lines toRemove 0 0 in
  (* let _ = print_int res in *)
  (* let _ = print_char '\n' in *)
  if List.length toRemove == 0 && pred == 0 then 0
  else res + whileEqual newLines res
;;

(* End result *)
print_int (whileEqual lines 0)
