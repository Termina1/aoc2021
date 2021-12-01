(lang dune 2.8)

(name aoc2021)

(generate_opam_files true)

(package
 (name aoc2021)
 (synopsis "AoC 2021 event")
 (depends
  (dune
   (>= 2.8))
  base
  fmt
  ppx_deriving
  ocaml-lsp-server
  ocamlformat))
