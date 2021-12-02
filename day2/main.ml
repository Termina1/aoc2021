open Base

let parse_line line =
  match String.split line ~on:' ' with
  | [ "forward"; f ] -> (Int.of_string f, 0)
  | [ "up"; u ] -> (0, -Int.of_string u)
  | [ "down"; d ] -> (0, Int.of_string d)
  | _ -> failwith "Unexpected verb"

let part1 =
  Lwt_main.run
    (let open Lwt.Syntax in
    let* h, v =
      Lwt_io.with_file ~mode:Lwt_io.Input
        (Printf.sprintf "%s/day2/day2.txt" (Unix.getcwd ()))
        (fun file ->
          let stream = Lwt_io.read_lines file in
          Lwt_stream.fold
            (fun ln_ (h_, v_) ->
              let h, v = parse_line ln_ in
              (h_ + h, v_ + v))
            stream (0, 0))
    in
    Lwt_io.printlf "Answer is: %i" (h * v))

let part2 =
  Lwt_main.run
    (let open Lwt.Syntax in
    let* h, v, _ =
      Lwt_io.with_file ~mode:Lwt_io.Input
        (Printf.sprintf "%s/day2/day2.txt" (Unix.getcwd ()))
        (fun file ->
          let stream = Lwt_io.read_lines file in
          Lwt_stream.fold
            (fun ln_ (h_, v_, a_) ->
              let h, v = parse_line ln_ in
              (h_ + h, v_ + (h * a_), a_ + v))
            stream (0, 0, 0))
    in
    Lwt_io.printlf "Answer is: %i" (h * v))
