# Metaprogramming

Fitur turunan dari Lisp di dalam bahasa Julia yang paling dominan adalah
dukungan terhadap metaprogramming. Karena kode direpresentasikan dengan
objek yang dapat dibuat dan dimanipulasi dari dalam bahasa pemrograman itu
sendiri, maka mungkin bagi suatu program untuk mengubah dan menghasilkan kodenya
sendiri. Hal ini memungkinkan pembuatan kode tanpa langkah *build* tambahan,
serta memungkinkan untuk makro ala-Lisp pada level *abstract syntax tree*.
Hal ini berbeda dengan makro ala-preprosesor, seperti yang ditemukan pada
bahasa C/C++, yang memerlukan manipulasi teks dan substitusi sebelum program
dibaca dan diinterpretasikan. Karena seluruh tipe data dan kode di dalam Julia
direpresentasikan dengan data struktur Julia, kemampuan refleksi yang ampuh juga
tersedia untuk mengeksplorasi internal program dan tipe-tipe di dalamnya
sebagaimana data lainnya.

## Representasi program

Setiap program Julia memulai siklus hidupnya sebagai string.

```julia-repl
julia> prog = "1 + 1"
"1 + 1"
```

### Apa yang terjadi selanjutnya ?

Langkah selanjutnya adalah menginterpretasikan setiap string ke dalam suatu
objek yang disebut ekspresi, dinyatakan oleh Julia dengan tipe `Expr`:

```julia-repl
julia> ex1 = parse(prog)
:(1 + 1)

julia> typeof(ex1)
Expr
```

Setiap objek `Expr` terdiri dari tiga bagian:

- Bagian pertama adalah sebuah `Symbol` yang mengidentifikasikan jenis ekspresi.
  Sebuah simbol adalah pengenal *interned string*.

```julia-repl
julia> ex1.head
:call
```
- Bagian kedua adalah argumen ekspresi, yang dapat berupa simbol, ekspresi lain,
  atau nilai literal:

```julia-repl
julia> ex1.args
3-element Array{Any,1}:
  :+
 1
 1
```

- Bagian ketiga adalah tipe hasil, yang dapat dianotasi oleh pengguna atau
  disimpulkan oleh kompiler (dan dapat kita abaikan pada bab ini).

```julia-repl
julia> ex1.typ
Any
```
