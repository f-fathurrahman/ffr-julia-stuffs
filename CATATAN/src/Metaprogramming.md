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

### Simbol

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

## Ekspresi dan evaluasi

### Kutipan (*Quoting*)

Kegunaan sintaktik kedua dari karakter `:` adalah untuk membuat objek
ekspresi tanpa menggunakan konstruktor `Expr` eksplisit. Proses ini dikenal
dengan nama kutipan. Karakter `:`, diikuti dengan tanda kurung di awal dan
di akhir suatu pernyataan dari kode Julia, akan menghasilkan objek `Expr`
berdasarkan kode yang dikutip. Berikut ini adalah contohnya:

```julia-repl
julia> ex = :(a+b*c+1)
:(a + b * c + 1)

julia> typeof(ex)
Expr
```

Perhatikan bahwa ekpresi yang ekuivalen dapat dikonstruksi dengan menggunakan
`parse()` atau bentuk `Expr` sesuai:

```julia-repl
julia>      :(a + b*c + 1)  ==
       parse("a + b*c + 1") ==
       Expr(:call, :+, :a, Expr(:call, :*, :b, :c), 1)
true
```

Ekspresi yang disediakan oleh parser pada umumnya hanya mengandung simbol,
objek `Expr` lain, dan nilai literal sebagai argumennya, di mana ekpresi
dikonstruksi oleh kode Julia dapat memiliki nilai *runtime* yang berbeda
tanpa bentuk literal dalam argumennya. Pada contoh khusus ini, `+` dan `a`
adalah simbol `*(b,c)` adalah subekspresi, dan `1` adalah literal integer
bertanda 64-bit.

Terdapat bentuk sintaktik kedua untuk mengutip ekspresi jamak: blok kode yang
diapit di dalam `quote ... end`. Perhatikan bahwa bentuk ini menghasilkan
elemen `QuoteNode` pada pohon ekspresi, yang harus ditinjau ketika memanipulasi
secara langsung pohon ekspresi yang dihasilkan dari blok `quote`. Untuk keperluan
lain, `:( ... )` dan `quote ... end` diperlakukan sama.

```julia-repl
julia> ex = quote
           x = 1
           y = 2
           x + y
       end
quote  # none, line 2:
    x = 1 # none, line 3:
    y = 2 # none, line 4:
    x + y
end

julia> typeof(ex)
Expr
```

### Interpolasi

Konstruksi langsung dari objek `Expr` dengan nilai argumen cukup berguna, namun
pemanggilannya dapat membosankan dibandingkan dengan sintaks Julia normal.
Sebagai alternatif, Julia membolehkan penyambungan atau interpolasi literal
atau ekspresi menjadi ekspresi yang dikutip. Interpolasi dilakukan dengan
menggunakan prefix `$`.

Pada contoh berikut ini, nilai literal dari `a` akan diinterpolasi:

```julia-repl
julia> a = 1;

julia> ex = :($a + b)
:(1 + b)
```

Interpolasi ke ekspresi yang tidak dikutip tidak didukung oleh Julia dan akan
menghasilkan `compile-time error`:

```julia-repl
julia> $a + b
ERROR: unsupported or misplaced expression $
 ...
```

Pada contoh ini, tupel `(1,2,3)` diinterpolasi sebagai ekspresi ke dalam
tes kondisional:

```julia-repl
julia> ex = :(a in $:((1,2,3)) )
:(a in (1, 2, 3))
```

Interpolasi simbol ke dalam suatu ekspresi bersarang memerlukan enklosing
setiap simbol dalam blok pengutipan.

```julia-repl
julia> :( :a in $( :(:a + :b) ) )
                   ^^^^^^^^^^
                   quoted inner expression
```

Penggunaan `$` untuk interpolasi ekspresi mirip dengan interpolasi string
dan interpolasi perintah. Interpolasi ekspresi memungkin kita untuk menulis
kontruksi ekspresi secara programatik dengan mudah.

### `eval()` dan efek

Diberikan suatu objek ekspresi, kita dapat membuat Julia untuk mengevaluasi
ekspresi tersebut pada ruang lingkup global dengan menggunakan `eval()`:

```julia-repl
julia> :(1 + 2)
:(1 + 2)

julia> eval(ans)
3

julia> ex = :(a + b)
:(a + b)

julia> eval(ex)
ERROR: UndefVarError: b not defined
[...]

julia> a = 1; b = 2;

julia> eval(ex)
3
```

Setiap modul memiliki fungsi `eval()` tersendiri yang mengevaluasi ekspresi
dalam ruang lingkup global dari modul tersebut. Eskpresi yan dilemparkan ke
`eval()` tidak hanyak dibatasi pada pengembalian nilai, mereka juga dapat
memiliki efek samping yang mengubah keadaan dari lingkungan modul yang
melingkupinya.

```julia-repl
julia> ex = :(x = 1)
:(x = 1)

julia> x
ERROR: UndefVarError: x not defined

julia> eval(ex)
1

julia> x
1
```

Pada contoh di atas evaluasi dari suatu objek ekspresi dapat mengakibatkan
suatu nilai memiliki nilai yang diberikan pada variabel global `x`.

Karena ekspresi adalah objek `Expr` yang dapat dikonstruksi secara programatik
dan kemudian dievaluasi, kita dapat secara dinamik menghasilkan kode pada
yang kemudian dapat dievaluasi dengan `eval()`. Berikut ini adalah contoh sederhana

```julia-repl
julia> a = 1;

julia> ex = Expr(:call, :+, a, :b)
:(1 + b)

julia> a = 0; b = 2;

julia> eval(ex)
3
```

Nilai dari `a` digunakan untuk mengkonstruksi `ex` yang diaplikasikan pada
fungsi `+` ke nilai 1 dan variabel `b`. Perhatikan perbedaan penting antara
bagaiman cara `a` dan `d` digunakan:

- Nilai dari variabel `a` pada saat konstruksi ekspresi digunakan sebagai nilai
  langsung pada ekspresi. Dengan demikian, nilai dari `a` ketika ekspresi
  dievaluasi tidak lagi penting: nilai dari ekspresi sudah `1`, tidak bergantung
  pada nilai `a` lagi nantinya.

- Di sisi lain, simbol `:b` digunakan pada konstruksi ekspresi, sehingga nilai
  variabel `b` pada waktu konstruksi tidak penting, `:b` hanyalah sebuah simbol
  dan variabel `b` bahkan tidak harus didefinisikan. Akan tetapi pada saat
  evaluasi, nilai dari simbol `:b` akan disubstitusikan dengan sesuai dengan
  definisi `b` yang tersedia.

### Fungsi pada ekspresi

Sebuah fungsi dapat menerima satu atau lebih objek `Expr` sebagai argumen
dan kemudian mengembalikan `Expr` yang lain, seperti pada contoh berikut.

```julia-repl
julia> function math_expr(op, op1, op2)
           expr = Expr(:call, op, op1, op2)
           return expr
       end
math_expr (generic function with 1 method)

julia>  ex = math_expr(:+, 1, Expr(:call, :*, 4, 5))
:(1 + 4 * 5)

julia> eval(ex)
21
```

Sebagai contoh lain, berikut ini adalah sebuah fungsi yang menggandakan sembarang
argumen numerik, namun tidak melakukan apa-apa jika argumennya adalah objek `Expr`:

```julia-repl
julia> function make_expr2(op, opr1, opr2)
           opr1f, opr2f = map(x -> isa(x, Number) ? 2*x : x, (opr1, opr2))
           retexpr = Expr(:call, op, opr1f, opr2f)
           return retexpr
       end
make_expr2 (generic function with 1 method)

julia> make_expr2(:+, 1, 2)
:(2 + 4)

julia> ex = make_expr2(:+, 1, Expr(:call, :*, 5, 8))
:(2 + 5 * 8)

julia> eval(ex)
42
```

## Makro

Makro menyediakan sebuah metode untuk menyertakan suatu kode yang dibangun
pada tubuh sebuah program. Sebuah makro akan memetakan tupel argumen menjadi
suatu ekspresi, dan ekspresi yang dihasilkan akan di-compile secara langsung
tanpa memerlukan pemanggilan `eval()`. Argumen dari makro dapat berupa ekspresi,
nilai literal, dan simbol.

### Dasar-dasar makro

Berikut ini adalah contoh makro sederhana:

```julia-repl
julia> macro sayhello()
           return :( println("Hello, world!") )
       end
@sayhello (macro with 1 method)
```

Pada sintaks Julia makro dinyatakan dengan sintaks khusus: menggunakan karakter
`@`, diikuti dengan nama unik yang dideklarasi dalam blok `macro NAME ... end`.
Dalam contoh ini, *compiler* akan mengganti semua instans dari `@sayhello` dengan

```julia
:( println("Hello, world!") )
```

Ketika `@sayhello` dimasukkan ke dalam REPL, ekspresi akan dieksekusi langsung
sehingga kita hanya melihat hasilnya saja:

```julia-repl
julia> @sayhello()
Hello, world!
```

Sekarang, tinjau makro yang lebih kompleks:

```julia-repl
julia> macro sayhello(name)
           return :( println("Hello, ", $name) )
       end
@sayhello (macro with 1 method)
```

Makro ini mengambil satu argumen: `name`. Ketika simbol `@sayhello` ditemui,
ekpresi yang dikutip akan diekspansi untuk menginterpolasi nilai dari argumen
menjadi ekspresi akhir:

```julia-repl
julia> @sayhello("human")
Hello, human
```

Kita dapat melihat ekspresi akhir dengan menggunakan fungsi `macroexpand()`
(fungsi ini sangat berguna untuk *debugging* makro):

```julia-repl
julia> ex = macroexpand( :(@sayhello("human")) )
:((println)("Hello, ", "human"))

julia> typeof(ex)
Expr
```

Kita dapat melihat bahwa literal "human" telah diinterpolasi menjadi ekspresi.

Terdapat juga makro `@macroexpand` yang mungkin lebih mudah untuk digunakan.

```julia-repl
julia> @macroexpand @sayhello "human"
:((println)("Hello, ", "human"))
```

### Mengapa menggunakan makro?

Kita telah melihat bahwa fungsi `f(::Expr...) -> Expr` pada bagian sebelumnya.
Faktanya, `macroexpand()` termasuk contoh fungsi tersebut. Jadi, mengapa ada
makro?

Makro diperlukan karena makro dieksekusi ketika kode di-*parse*, sehingga
makro memungkinkan programer untuk menghasilkan dan memasukkan fragmen kode
khusus sebelum seluruh program dijalankan. Untuk mengilustrasikan perbedaan ini,
tinjau contoh berikut.

```julia-repl
julia> macro twostep(arg)
           println("I execute at parse time. The argument is: ", arg)
           return :(println("I execute at runtime. The argument is: ", $arg))
       end
@twostep (macro with 1 method)

julia> ex = macroexpand( :(@twostep :(1, 2, 3)) );
I execute at parse time. The argument is: $(Expr(:quote, :((1, 2, 3))))
```

Pemanggilan pertama dari `println()` dieksekusi ketika `macroexpand()`
dipanggil. Ekspresi yang dihasilkan hanyak mengandung `println`
kedua:

```julia-repl
julia> typeof(ex)
Expr

julia> ex
:((println)("I execute at runtime. The argument is: ", $(Expr(:copyast, :($(QuoteNode(:((1, 2, 3)))))))))

julia> eval(ex)
I execute at runtime. The argument is: (1, 2, 3)
```

### Pemanggilan makro

Makro dapat dipanggil dengan menggunakan sintaks umum berikut.

```julia
@name expr1 expr2 ...
@name(expr1, expr2, ...)
```

Kita dapat menggunakan kedua sintaks di atas, namun sangat disarankan hanya
menggunakan salah satu dari sintaks tersebut saja.
Perhatikan perbedaan antara kedua sintaks tersebut. Pada sintaks kedua tidak
ada spasi setelah `@name`. Sintaks di bawah ini akan melemparkan tupel
`(expr1, expr2, ...)` sebagai argumen ke makro:

```julia
@name (expr1, expr2, ...)
```

Sangat penting untuk menekankan bahwa makro menerima argumen mereka sebagai
ekspresi, literal, atau simbol. Salah satu cara untuk mengeksplorasi argumen
makro adalah dengan memanggil fungsi `show()` di dalam tubuh makro.

```julia-repl
julia> macro showarg(x)
           show(x)
           # ... remainder of macro, returning an expression
       end
@showarg (macro with 1 method)

julia> @showarg(a)
:a

julia> @showarg(1+1)
:(1 + 1)

julia> @showarg(println("Yo!"))
:(println("Yo!"))
```

### Membangun makro lanjut (*advanced*)

Berikut ini adalah definisi makro Julia standard `@assert`:

```julia-repl
macro assert(ex)
    return :( $ex ? nothing : throw(AssertionError($(string(ex)))) )
end
```

Makro ini dapat digunakan sebagai berikut:

```julia-repl
julia> @assert 1==1.0

julia> @assert 1==0
ERROR: AssertionError: 1 == 0
 ...
```

Sebagai ganti dari sintaks yang tertulis, makro dapat diekspansi pada saat
`parse time` untuk mengembalikan hasil. Hal ini ekuivalen dengan menuliskan:

```julia
1==1.0 ? nothing : throw(AssertionError("1==1.0"))
1==0 ? nothing : throw(AssertionError("1==0"))
```

Yaitu, pada pemanggilan pertama, ekspresi `:(1==1.0)` dibagi
