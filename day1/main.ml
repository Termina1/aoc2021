open Base

let part1 () =
  Lwt_main.run
    (let open Lwt.Syntax in
    let* count, _ =
      Lwt_io.with_file ~mode:Lwt_io.Input
        (Printf.sprintf "%s/day1/day1.txt" (Unix.getcwd ()))
        (fun file ->
          let stream = Lwt_io.read_lines file in
          Lwt_stream.fold
            (fun line (count, prev) ->
              let num = Int.of_string line in
              let count = if num > prev then count + 1 else count in
              (count, num))
            stream (0, Int.max_value))
    in
    Lwt_io.printlf "Answer is: %i" count)

let drop n stream =
  let x = ref 0 in
  Lwt_stream.filter
    (fun _ ->
      if !x >= n then true
      else
        let () = x := !x + 1 in
        false)
    stream

let part2 () =
  Lwt_main.run
    (let open Lwt.Syntax in
    let* count, _ =
      Lwt_io.with_file ~mode:Lwt_io.Input
        (Printf.sprintf "%s/day1/day1.txt" (Unix.getcwd ()))
        (fun file ->
          let stream = Lwt_io.read_lines file |> Lwt_stream.map Int.of_string in
          let stream3 =
            Lwt_stream.combine
              (Lwt_stream.combine stream (Lwt_stream.clone stream |> drop 1))
              (Lwt_stream.clone stream |> drop 2)
          in
          Lwt_stream.fold
            (fun ((a, b), c) (count, prev) ->
              let num = a + b + c in
              let count = if num > prev then count + 1 else count in
              (count, num))
            stream3 (0, Int.max_value))
    in
    Lwt_io.printlf "Answer is: %i" count)

let main = part2 ()
