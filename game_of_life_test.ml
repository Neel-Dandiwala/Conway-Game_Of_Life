let grid_size = 10;;
let generations = 10;;

let grid = Array.make_matrix grid_size grid_size false;;

(* Just as an example, I'll provide the initial seed *)
let () = List.iter (fun (x, y) -> grid.(x).(y) <- true) [(1, 2); (2, 3); (3, 1); (3, 2); (3, 3)]

let count_live_neightbors grid x y =
  let neighbors = [(-1, -1); (-1, 0); (-1, 1); (0, -1); (0, 1); (1, -1); (1, 0); (1, 1)] in
  List.fold_left (fun acc (dx, dy) -> 
    let nx, ny = x + dx, y + dy in
    if nx >= 0 && nx < grid_size && ny >= 0 && ny < grid_size && grid.(nx).(ny) then acc + 1 else acc
    ) 0 neighbors;;

let evaluate_grid grid = 
  let new_grid = Array.make_matrix grid_size grid_size false in
  for x = 0 to (grid_size - 1) do
    for y = 0 to (grid_size - 1) do
      let live_neightbors = count_live_neightbors grid x y in
      new_grid.(x).(y) <- match grid.(x).(y), live_neightbors with 
      | true, 2 | true, 3 | false, 3 -> true 
      | _ -> false
    done;
  done;
  new_grid;;

let print_grid grid = 
  for x = 0 to (grid_size - 1) do
    for y = 0 to (grid_size - 1) do
      print_string (if grid.(x).(y) then "▮" else "▯");
    done;
    print_newline();
  done;
  print_newline();;

let () = 
  let rec loop grid generation = 
    if generation > generations then () 
    else (
      print_endline ("Generation " ^ string_of_int generation);
      print_grid grid;
      loop (evaluate_grid grid) (generation + 1);
    ) in 
    loop grid 1;;

