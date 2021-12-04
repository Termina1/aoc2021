open Base

type boards = (int, (int * int * int) list) Hashtbl.t [@@deriving sexp_of]

type canonical_board = ((int * int) * int) list

let print_canonical (board : canonical_board) =
  let open Lwt.Syntax in
  let* _ =
    Lwt_list.fold_left_s
      (fun prev_row ((row, _), num) ->
        let* row =
          if Int.equal prev_row row then Lwt.return row
          else
            let+ () = Lwt_io.printl "" in
            row
        in
        let+ () = Lwt_io.printf "%i " num in
        row)
      0 board
  in
  Lwt_io.printl "\n"

let boards_to_canonical (boards : boards) : canonical_board list =
  let list = Hashtbl.to_alist boards in
  let flattened =
    List.fold list ~init:[] ~f:(fun acc (num, entries) ->
        let mapped =
          List.map entries ~f:(fun (bn, rn, cn) -> (bn, ((rn, cn), num)))
        in
        List.append acc mapped)
  in
  let sorted =
    List.sort flattened ~compare:(fun (ab, ((ar, ac), _)) (bb, ((br, bc), _)) ->
        let b = ab - bb in
        if not (Int.equal b 0) then b
        else
          let r = ar - br in
          if not (Int.equal r 0) then r else ac - bc)
  in
  let _, boards, last =
    List.fold sorted ~init:(0, [], []) ~f:(fun (prev, acc, cur_list) entry ->
        let board_num = fst entry in
        if not (Int.equal board_num prev) then
          (board_num, List.rev cur_list :: acc, [ snd entry ])
        else (prev, acc, snd entry :: cur_list))
  in
  List.rev (last :: boards)

let parse_file name : (int list * boards * int) Lwt.t =
  let open Lwt.Syntax in
  Lwt_io.with_file ~mode:Lwt_io.Input name (fun file ->
      let* line = Lwt_io.read_line file in
      let numbers = List.map ~f:Int.of_string (String.split line ~on:',') in
      let lines = Lwt_io.read_lines file in
      let* board_num, _, boards =
        Lwt_stream.fold
          (fun line (board_num, row, boards) ->
            if String.equal (String.strip "") line then
              (board_num + 1, 0, boards)
            else
              let numbers =
                List.fold ~init:[]
                  ~f:(fun acc str ->
                    try List.append acc [ Int.of_string str ] with _ -> acc)
                  (String.split ~on:' ' line)
              in
              List.iteri numbers ~f:(fun i num ->
                  match Hashtbl.find boards num with
                  | None ->
                      Hashtbl.set boards ~key:num ~data:[ (board_num, row, i) ]
                  | Some lst ->
                      Hashtbl.set boards ~key:num
                        ~data:((board_num, row, i) :: lst));
              (board_num, row + 1, boards))
          lines
          (0, 0, Hashtbl.create (module Int))
      in
      Lwt.return (numbers, boards, board_num))

let key_col (b, _, c) = Printf.sprintf "col%i,%i" b c

let key_row (b, r, _) = Printf.sprintf "row%i,%i" b r

let incr_counter accum key entry =
  match Hashtbl.find accum (key entry) with
  | None ->
      let _ = Hashtbl.add accum ~key:(key entry) ~data:1 in
      None
  | Some cnt ->
      let cnt = cnt + 1 in
      Hashtbl.set accum ~key:(key entry) ~data:cnt;
      if cnt >= 5 then Some entry else None

open Lwt.Syntax

let play_bingo nums boards stop_condition : int Lwt.t =
  let entry =
    List.fold_until nums
      ~finish:(fun _ -> None)
      ~init:(Set.empty (module Int), Hashtbl.create (module String))
      ~f:(fun (called, accum) num ->
        match Hashtbl.find boards num with
        | None -> Continue (Set.add called num, accum)
        | Some entries -> (
            let res =
              List.fold_until ~init:()
                ~finish:(fun _ -> None)
                entries
                ~f:(fun () entry ->
                  match incr_counter accum key_col entry with
                  | Some entry -> stop_condition entry accum
                  | None -> (
                      match incr_counter accum key_row entry with
                      | Some entry -> stop_condition entry accum
                      | None -> Continue ()))
            in
            match res with
            | None -> Continue (Set.add called num, accum)
            | Some (b, _, _) -> Stop (Some (Set.add called num, b, num))))
  in
  match entry with
  | None -> failwith "No winning boards"
  | Some (called, b, num) ->
      let canon = boards_to_canonical boards in
      let* () = Lwt_io.printlf "Winning board: %i, last number: %i" b num in

      let winning = List.nth canon b in
      Lwt.return
        (match winning with
        | None -> failwith "Can't find winning borad"
        | Some board ->
            let not_marked =
              List.filter board ~f:(fun (_, num) -> not (Set.mem called num))
            in
            List.sum (module Int) not_marked ~f:(fun (_, num) -> num) * num)

let main =
  Lwt_main.run
    (let* nums, boards, boards_num = parse_file "day4/day4.txt" in
     let* answer = play_bingo nums boards (fun e _ -> Stop (Some e)) in
     let* () = Lwt_io.printlf "Answer part 1 is: %i" answer in
     let* answer =
       play_bingo nums boards (fun (board, r, c) accum ->
           let board_key = Printf.sprintf "wins%i" board in
           let wins_key = "win" in
           match
             (Hashtbl.find accum wins_key, Hashtbl.find accum board_key)
           with
           | None, _ ->
               Hashtbl.set accum ~key:wins_key ~data:1;
               Hashtbl.set accum ~key:board_key ~data:1;
               Continue ()
           | Some wins, None ->
               if wins >= boards_num - 1 then Stop (Some (board, r, c))
               else
                 let () = Hashtbl.set accum ~key:wins_key ~data:(wins + 1) in
                 let () = Hashtbl.set accum ~key:board_key ~data:(wins + 1) in
                 Continue ()
           | Some _, Some _ -> Continue ())
     in
     Lwt_io.printlf "Answer part 2 is: %i" answer)
