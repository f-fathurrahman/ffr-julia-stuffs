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

Ekspresi juga dapat dikonstruksi dengan menggunakan notasi prefix:

```julia-repl
julia> ex2 = Expr(:call, :+, 1, 1)
:(1 + 1)
```

Dua ekspresi yang dikonstruksi di atas, yakni dengan interpretasi dan konstruksi
langsung adalah sama:

```julia-repl
julia> ex1 == ex2
true
```

Poin penting dari diskusi di atas adalah untuk menunjukkan bahwa kode Julia
secara internal direpresentasikan sebagai data struktur yang dapat diakses
dari bahasa Julia itu sendiri.

Fungsi `dump()` dapat digunakan untuk menampilkan anotasi dari objek `Expr`:

```julia-repl
julia> dump(ex2)
Expr
  head: Symbol call
  args: Array{Any}((3,))
    1: Symbol +
    2: Int64 1
    3: Int64 1
  typ: Any
```

Objek `Expr` dapat bersarang (mempunya objek dengan tipe `Expr` juga):

```julia-repl
julia> ex3 = parse("(4 + 4) / 2")
:((4 + 4) / 2)
```

Cara lain untuk memandang ekspresi adalah dengan menggunakan `Meta.show_sexpr`,
yang menampilkan bentuk ekspresi-S dari `Expr` yang diberikan, yang akan terlihat
familiar bagi para pengguna Lisp. Berikut ini adalah contoh yang mengilustrasikan
tampilan dari `Expr` bersarang:

```julia-repl
julia> Meta.show_sexpr(ex3)
(:call, :/, (:call, :+, 4, 4), 2)
```

Symbols

Karakter `:` memiliki dua kegunaan sintaktis pada Julia. Bentuk pertama menghasilkan
objek `Symbol` yang diinterpretasikan sebagai *interned string* dan digunakan
sebagai `building-block` dari ekspresi

```julia-repl
julia> :foo
:foo

julia> typeof(ans)
Symbol
```

Konstruktor `Symbol` menerima sembarang jumlah argument dan menghasilkan
simbol baru dengan menyambungkan representasi string dari argumen yang diterima:

```julia-repl
julia> :foo == Symbol("foo")
true

julia> Symbol("func",10)
:func10

julia> Symbol(:var,'_',"sym")
:var_sym
```

Dalam konteks sebuah ekspresi, simbol digunakan untuk mengindikasikan akses
ke suatu variabel; ketika suatu ekspresi dievaluasi, sebuah simbol
akan diganti dengan nilai yang terikat pada simbol tersebut dalam ruang lingkup
yang sesuai.

Terkadang, tanda kurung ekstra diperlukan sebagai argumen bagi `:` untuk
menghindari ambiguitas pada saat interpretasi:

```julia-repl
julia> :(:)
:(:)

julia> :(::)
:(::)
```
