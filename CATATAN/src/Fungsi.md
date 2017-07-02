# Fungsi

Dalam Julia, sebuah fungsi adalah objek yang memetakan tupel nilai argument
ke suatu nilai yang akan dikembalikan. Fungsi pada Julia bukanlah fungsi
matematika murni dalam artian bahwa fungsi dapat berubah dan dipengaruhi oleh
keadaan global dari program.
Sintaks dasar untuk mendefinisikan fungsi pada Julia adalah sebagai berikut.

```julia-repl
julia> function f(x,y)
           x + y
       end
f (generic function with 1 method)
```

Terdapat sintaks kedua yang lebih singkat untuk mendefinisikan fungsi pada
Julia. Fungsi yang dideklarasi di atas juga dapat didefinisikan dengan
bentuk *assignment*:

```julia-repl
julia> f(x,y) = x + y
f (generic function with 1 method)
```

Dalam bentuk *assignment*, tubuh dari fungsi harus berupa ekspresi tunggal,
meskipun juga dapat berupa ekspresi jamak (*compound expression*).
Definisi fungsi dengan pendek dan sederhana sering ditemukan pada Julia.
Sintaks pendek ini idiomatik di Julia dan dapat mengurangi kemungkinan
kesalahan dalam pengetikan maupun secara visual.

Fungsi dapat dipanggil dengan menggunakan sintaks tradisional dengan
menggunakan tanda kurung:

```julia-repl
julia> f(2,3)
5
```

Tanpa tanda kurung, ekspresi `f` merujuk kepada objek fungsi dan dapat
dilempar seperti halnya semua nilai / variabel:

```julia-repl
julia> g = f;

julia> g(2,3)
5
```

Sepertinya halnya variabel, karakter Unicode juga dapat digunakan sebagai nama
fungsi:

```julia-repl
julia> ∑(x,y) = x + y
∑ (generic function with 1 method)

julia> ∑(2, 3)
5
```

## Perilaku pelemparan argumen

Pelemparan argumen pada Julia mengikuti konvensi yang dikenal dengan nama
*pass-by-sharing* yang berarti bahwa nilai tidak dikopi ketika mereka dilempar
ke dalam fungsi. Argumen fungsi sendiri berlaku sebagai *binding* variabel baru
(lokasi baru yang dapat merujuk pada nilai), namun nilai yang dirujuk sama
dengan nilai yang dilempar. Modifikasi nilai *mutable* (seperti `Array`)
yang dilakukan di dalam fungsi akan dapat dilihat oleh pemanggil fungsi.
Perilaku ini sama dengan perilaku yang ditemukan pada bahasa pemrograman
dinamik lain, diantaranya Scheme, sebagian besar
implementasi Lisp, Python, Ruby dan Perl.

## Kata kunci `return`

Nilai yang dikembalikan oleh fungsi adalah nilai dari ekspresi terakhir yang
dievaluasi pada fungsi, yang secara default adalah ekspresi terakhir dari
bagian tubuh definisi fungsi. Pada contoh sebelumnya, ekspresi ini adalah
`x + y`. Seperti pada bahasa pemrograman C dan sebagian besar bahasa pemrograman
imperatif atau fungsional, kata kunci `return` menyebabkan fungsi untuk
segera mengembalikan nilai, dan menyediakan ekspresi yang menyatakan nilai yang
dikembalikan:

```julia
function g(x,y)
    return x * y
    x + y
end
```

Karena definisi fungsi dapat diketikkan pada sesi interaktik REPL, kita dapat
dengan mudah membandingkan definisi tersebut.

```julia-repl
julia> f(x,y) = x + y
f (generic function with 1 method)

julia> function g(x,y)
           return x * y
           x + y
       end
g (generic function with 1 method)

julia> f(2,3)
5

julia> g(2,3)
6
```

Tentu saja pada tubuh fungsi yang linear seperti `g`, penggunaan kata kunci
`return` tidak diperlukan karena ekspresi `x + y` tidak pernah dievaluasi dan
kita dapat membuat `x * y` sebagai ekspresi terakhir dan menghilangkan kata
kunci `return`. Dalam penggunaan yang lebih kompleks tentu saja kata kunci
`return` dapat memiliki signifikansi. Contoh berikut ini adalah sebuah fungsi
yang menghitung sisi miring dari segitiga siku-siku dengan panjang sisi
`x` dan `y`, dengan menghindari kasus *overflow*:

```julia-repl
julia> function hypot(x,y)
           x = abs(x)
           y = abs(y)
           if x > y
               r = y/x
               return x*sqrt(1+r*r)
           end
           if y == 0
               return zero(x)
           end
           r = x/y
           return y*sqrt(1+r*r)
       end
hypot (generic function with 1 method)

julia> hypot(3, 4)
5.0
```

Terdapat tiga kemungkinan titik kembalian dari fungsi ini, mengembalika nilai
dari tiga ekspresi berbeda, bergantung dari nilai `x` dan `y`. Kata kunci
`return` pada baris terakhir dapat dihilangkan karena ekspresi ini adalah
ekspresi terakhir dari tubuh fungsi.

## Operator adalah fungsi

Dalam Julia, sebagian besar operator adalah fungsi yang memiliki sintaks
khusus.
(Pengecualian dalam hal ini
adalah operator dengan semantik evaluasi khusus seperti
`&&` dan `||`. Operator tersebut tidak dapat diimplementasikan sebagai fungsi
karena evaluasi *short-circuit* memerlukan operan tidak dievaluasi sebelum
operasi dari operator.)
Dengan demikian kita juga dapat mengoperasikan operator
dengan menggunakan sintaks fungsi yang menggunakan
tanda kurung seperti halnya fungsi lain.

```julia-repl
julia> 1 + 2 + 3
6

julia> +(1,2,3)
6
```

Bentuk infiks ini ekuivalen dengan bentuk evaluasi fungsi.
Faktanya, secara internal, ekspresi pertama ditranslasikan menjadi pemanggilan
fungsi. Hal ini juga berarti bahwa kita dapat melakukan *assignment* dan
melemparkan operator seperti `+()` dan `*()` seperti halnya variabel dan nilai
fungsi lain.

```julia-repl
julia> f = +;

julia> f(1,2,3)
6
```

Meskipun demikian, dengan nama `f`, fungsi ini tidak dapat mendukung notasi
infiks seperti halnya `+`.

## Operator dengan nama khusus

Beberapa ekspresi khusus memiliki bentuk pemanggilan fungsi khusus dengan
nama khusus. Ekspresi tersebut adalah sebagai berikut.

| Ekspresi | Pemanggilan |
| ---------| ----------- |
| `[A B C ...]` | `hcat()` |
| `[A; B; C; ...]` | `vcat()` |
| `[A B; C D; ...]` |`hvcat()` |
| `A'` | `ctranspose()` |
| `A.'` | `transpose()` |
| `1:n` | `colon()` |
| `A[i]` | `getindex'()` |
| `A[i] = x` | `setindex!()` |

Fungsi tersebut termasuk dalam modul `Base.Operators` meskipun mereka tidak
memiliki nama operator.

## Fungsi anonim

Fungsi dalam Julia adalah objek kelas pertama (*first-class object*). Mereka
dapat di-*assign* ke variabel dan dipanggil dengan sintaks pemanggilan fungsi
standard dari variabel yang telah di-*assign*. Mereka dapat digunakan sebagai
argumen dan dapat dikembalikan sebagai nilai. Mereka juga dapat dibuat secara
anonim, tanpa diberikan nama, dengan menggunakan salah satu dari sintaks
berikut.

```julia-repl
julia> x -> x^2 + 2x - 1
(::#1) (generic function with 1 method)

julia> function (x)
           x^2 + 2x - 1
       end
(::#3) (generic function with 1 method)
```

Sintaks ini akan membuat sebuah fungsi yang mengambil satu argumen `x` dan
mengembalikan nilai dari polinom `x^2 + 2x - 1` pada nilai `x` yang
diberikan. Perhatikan bahwa hasil dari sintaks ini adalah fungsi generik,
dengan nama yang diberikan oleh kompiler secara otomatis berdasarkan penomoran
urut.

Kegunaan utama fungsi anonim adalah untuk dilemparkan pada fungsi yag mengambil
fungsi lain sebagai argumen. Contohnya adalah fungsi `map()` yang mengaplikasikan
sebuah fungsi ke setiap nilai dari array dan mengembalikan array baru yang berisi
hasil dari aplikasi ini.

```julia-repl
julia> map(round, [1.2,3.5,1.7])
3-element Array{Float64,1}:
 1.0
 4.0
 2.0
```

Hal ini dapat bekerja apabila fungsi bernama yang melakukan transformasi
sudah tersebut untuk dilemparkan sebagai argumen pertama pada `map()`.
Seringkali, fungsi bernama ini belum ada. Pada situasi tersebut, fungsi
anonim dapat dikonstruksi:

```julia-repl
julia> map(x -> x^2 + 2x - 1, [1,3,-1])
3-element Array{Int64,1}:
  2
 14
 -2
```

Fungsi anonim yang menerima argumen lebih bari satu dapat ditulis dengan menggunakan
sintaks `(x,y,z) -> 2x + y - z`, misalnya. Fungsi anonim yang tidak memiliki
argument dapat ditulis sebagai `() -> 3`. Konsep fungsi tanpa argumen terlihat aneh,
namun berguna untuk "menunda" perhitungan. Dalam penggunaan ini, sebuat blok
kode dibungkus dalam suatu fungsi tanpa argumen yang nantinya dipanggil dengan
`f()`.

## Nilai kembalian jamak

Dalam Julia, kita menggunakan tupel untuk mengembalikan nilai lebih dari satu.
Tupel dapat dikonstruksi dan didekonstruksi tanpa memerlukan tanda kurung,
sehingga memberikan kesan bahwa lebih dari satu nilai yang dikembalikan.
Sebagai contoh:

```julia-repl
julia> function foo(a,b)
           a+b, a*b
       end
foo (generic function with 1 method)
```

Jika fungsi ini dipanggil pada sesi interaktif tanpa melakukan *assignment*
ke suatu variabel, kita akan mengamati bahwa tupel akan diberikan.

```julia-repl
julia> foo(2,3)
(5, 6)
```

Penggunaan tipikal dari kasus ini adalah mengekstraksi setiap nilai ke variabel.
Julia dapat melakukan 'destrukturisasi' tupel untuk memfasilitasi hal ini.

```julia-repl
julia> x, y = foo(2,3)
(5, 6)

julia> x
5

julia> y
6
```

Kita juga dapat mengembalikan nilai melalui penggunaan eksplit kata kunci
`return`:

```julia
function foo(a,b)
    return a+b, a*b
end
```

Pendefinisian ini memiliki efek yang sama dengan definisi sebelumnya dari fungsi
`foo`.



## Fungsi `varargs`

Kadang kala kita perlu menulis fungsi yang dapat mengambil sembarang jumlah
argumen. Fungsi ini dikenal sebagai fungsi `varargs`, yang merupakan singkatan
argumeo. dari *variable number of arguments*. Kita dapat mendefinisikan
fungsi *varargs* dengan cara menambahkan elipsis `...`
pada argumen terakhir:

```julia-repl
julia> bar(a,b,x...) = (a,b,x)
bar (generic function with 1 method)
```

Seperti fungsi biasa, variabel `a` dan `b` terikat pada dua nilai pertama
argumen fungsi, dan variabel x terikat pada koleksi iterabel dari 0 atau lebih
nilai yang diberikan ke fungsi `bar` setelah dua argumen pertama:

```julia-repl
julia> bar(1,2)
(1, 2, ())

julia> bar(1,2,3)
(1, 2, (3,))

julia> bar(1, 2, 3, 4)
(1, 2, (3, 4))

julia> bar(1,2,3,4,5,6)
(1, 2, (3, 4, 5, 6))
```

Pada semua kasus di atas, `x` terikat pada tupel dari nilai selain `a`
dan `b` yang dilempar ke fungsi `bar`.

Kita dapat memberikan batasan terhadap jumlah nilai yang dilempar sebagai
argumen variabel; hal ini akan didiskusikan lebih lanjut pada
metode `varargs` terbatas-parameter.

Terkadang berguna untuk memisahkan variabel yang berada pada koleksi iterabel
menjadi pemanggilan fungsi sebagai argumen individual. Untuk melakukan hal ini,
kita juga dapat menggunakan elipsis `...` namun di dalam pemanggilan fungsi.

```julia-repl
julia> x = (3, 4)
(3, 4)

julia> bar(1,2,x...)
(1, 2, (3, 4))
```

Dalam kasus ini, tupel nilai akan dipecah menjadi `varargs`.

```julia-repl
julia> x = (2, 3, 4)
(2, 3, 4)

julia> bar(1,x...)
(1, 2, (3, 4))

julia> x = (1, 2, 3, 4)
(1, 2, 3, 4)

julia> bar(x...)
(1, 2, (3, 4))
```

Objek iterabel yang dipecah dalam pemanggilan fungsi tidak harus berupa
tupel:

```julia-repl
julia> x = [3,4]
2-element Array{Int64,1}:
 3
 4

julia> bar(1,2,x...)
(1, 2, (3, 4))

julia> x = [1,2,3,4]
4-element Array{Int64,1}:
 1
 2
 3
 4

julia> bar(x...)
(1, 2, (3, 4))
```

Selain itu, fungsi yang argumennya dipecah tidak perlu berupa fungsi `varargs`
(meskipun seringkali adalah fungsi `varargs`):

```julia-repl
julia> baz(a,b) = a + b;

julia> args = [1,2]
2-element Array{Int64,1}:
 1
 2

julia> baz(args...)
3

julia> args = [1,2,3]
3-element Array{Int64,1}:
 1
 2
 3

julia> baz(args...)
ERROR: MethodError: no method matching baz(::Int64, ::Int64, ::Int64)
Closest candidates are:
  baz(::Any, ::Any) at none:1
```

Seperti yang bisa diamati dari contoh di atas, jika jumlah elemen yang dipecah
tidak cocok, pemanggilan fungsi akan gagal karena fungsi diberikan jumlah argumen
yang lebih banyak dari yang seharusnya.

## Argumen opsional

Pada banyak kasus, argumen fungsi harus memiliki nilai default yang masuk akal
sehingga tidak perlu diberikan secara eksplisit pada setiap pemanggilan fungsi.
Sebagai contoh, fungsi pustaka standard `parse(T, num, base)` menginterpretasi
suatu string sebagai bilangan dalam basis tertentu. Argumen `base` memiliki
nilai default `10`. Perilaku ini dapat diimplementasikan dengan menuliskan
definisi fungsi sebagai:

```julia-repl
function parse( type, num, base=10)
    ###
end
```

Dengan definisi ini, fungsi dapat dipanggil dengan dua atau tiga argumen, dan
`10` secara otomatis dilemparkan ketika argumen ketiga tidak diberikan.

```julia-repl
julia> parse(Int,"12",10)
12

julia> parse(Int,"12",3)
5

julia> parse(Int,"12")
12
```

Argumen opsional sebenarnya hanyalah sintaks praktis untuk menuliskan definisi
metode jamak dengan jumlah argumen yang berbeda.
(Lihat juga **Catatan mengenai argumen opsional dan kata kunci**).

## Argumen kata kunci

Beberapa fungsi memerlukan jumlah argumen yang banyak, atau memiliki banyak
perilaku yang berbeda. Mengingat bagaimana memanggil fungsi tersebut dapat menjadi
sulit. Argumen kata kunci dapat digunakan untuk membuat antarmuka fungsi tersebut
menjadi lebih mudah untuk digunakan dan dikembangkan dengan memungkinkan argument
diidentifikasi dengan nama selain dari hanya posisinya.

Sebagai contoh, tinjau sebuah fungsi `plot` yang menggambar sebuah garis. Fungsi
ini dapat memiliki banyak opsi, seperti bagaimana gaya garis, ketebalan, warna,
dan sebagainya. Apabila fungsi ini menerima argumen kata kunci, pemanggilan fungsi
tersebut dapat seperti `plot(x, y, width=2)`, di mana kita hanya memilih untuk
memberikan spesifikasi ketebalan garis. Perhatikan bahwa hal ini memiliki dua tujuan.
Pemanggilan fungsi menjadi lebih mudah untuk dibaca karena kita melabeli sebuah
argumen dengan artinya. Hal ini juga memungkinkan kita untuk melemparkan
banyak argumen dengan posisi sembarang.

Fungsi dengan argumen kata kunci didefinisikan dengan menggunakan tanda titik-koma
`;` pada signature fungsi.

```julia
function plot(x, y; style="solid", width=1, color="black")
    ###
end
```

Ketika fungsi ini dipanggil, tanda titik-koma bersifat opsional: kita dapat
memanggil fungsi dengan sintaks `plot(x, y, width=2)` atau `plot(x, y; width=2)`,
namun sintaks pertama lebih umum digunakan. Tanda titik-koma eksplit
hanya diperlukan ketika melemparkan `varargs` atau kata kunci yang dihitung
seperti yang akan dijelaskan di bawah ini.

Argumen kata kunci default dievaluasi hanya jika diperlukan (ketika kata kunci
argumen yang terkait tidak dilemparkan ke fungsi), dan dalam urutan dari kiri
ke kanan. Dengan demikinan, eskpresi default dapat merujuk pada argumen kata
kunci sebelumnya.

Tipe dari argumen kata kunci dapat diberikan secara eksplisit:

```julia
function f(; x::Int64=1)
    ###
end
```

Argumen kata kunci esktra dapat dikumpulkan dengan menggunakan elipsis `...`
seperti pada kata kunci `varargs`.

```julia
function f(x; y=0, kwargs...)
    ###
end
```

Di dalam fungsi `f`, `kwargs` akan berupa koleksi dari tupel `(key,value)`,
di mana setiap `key` adalah sebuah simbol. Koleksi tersebut dapat dilemparkan
sebagai argumen kata kunci dengan menggunakan titik-koma pada pemanggilan fungsi,
misalnya `f(x, z=1; kwargs...)`. Dictionary juga dapat digunakan untuk
keperluan ini.

Kita juga dapat melemparkan tupel `(key,value)` atau sembarang ekpresi iterabel
(seperti pasangan `=>`) yang dapat di-*assign* pada tupel tersebut, secara
eskplisit setelah titik-koma.
Sebagai contoh, `plot(x, y; (:width,2))` dan `plot(x, y; :width => 2)` ekuivalen
dengan `plot(x, y, width=2)`.
Hal ini berguna pada situasi di mana argumen kata kunci ditentukan/dihitung
pada *runtime*.

Sifat dari argumen kata kunci memungkinkan kita untuk menspesifikasikan argumen
yang sama lebih dari sekali. Sebagai contoh, dalam pemanggilan
`plot(x, y; options..., width=2)` mungkin saya struktur `options` juga mengandung
nilai untuk `width`. Dalam kasus tersebut, argumen paling kanan akan
diprioritaskan, sehingga dalam hal ini `width` akan memiliki nilai `2`.



## Evaluasi ruang lingkup dari nilai default

Argumen default dan kata kunci memiliki sedikit perbedaan dalam hal bagaimana
nilai default mereka dievaluasi.
Ketika ekspresi argumen default dievaluasi, hanya argumen sebelunya yang berada
dalam ruang lingkup. Sebaliknya, semua argumen berada dalam ruang lingkup ketika
argumen kata kunci dievaluasi. Sebagai contoh, diberikan definisi berikut:

```julia
function f(x, a=b, b=1)
    ###
end
```

`b` dalam `a=b` berada dalam ruang lingkup luar, namun tidak pada argumen `b`
setelahnya. Akan tetapi, jika `a` dan `b` adalah argumen kata kunci, maka
keduanya akan dibuat dalam ruang lingkup yang sama dan `b` dalam `a=b` akan
merujuk pada argumen `b` setelahnya (dan menutupi semua definisi `b` pada
ruang lingkup lebih luar), dan akan menghasilkan *undefined variable error*
karena ekspresi default dievaluasi dari kiri-ke-kanan, dan `b` belum diberikan
nilai apapun.

## Sintaks Blok-`do` untuk argumen fungsi

Melemparkan fungsi sebagai argumen ke fungsi lain merupakan teknik yang sangat
berguna, namun tidak selalu mudah untuk menggunakannya. Pemanggilan fungsi
teknik ini terlihat janggal untuk ditulis ketika argument fungsi memerlukan
lebih dari satu baris. Sebagai contoh, tinjau pemanggilan fungsi `map()`
pada fungsi dengan beberapa kasus:

```julia
map(x->begin
           if x < 0 && iseven(x)
               return 0
           elseif x == 0
               return 1
           else
               return x
           end
       end,
    [A, B, C])
```

Julia menyediakan kata kunci `do` untuk menulis kode ini dengan lebih
jelas:

```julia
map([A, B, C]) do x
    if x < 0 && iseven(x)
        return 0
    elseif x == 0
        return 1
    else
        return x
    end
end
```

Sintaks `do x` akan menghasilkan fungsi anonim dengan argumen `x` dan melemparkan
fungsi ini sebagai argumen pertama ke fungsi `map()`. Begitu juga `do a,b` akan
menghasilkan fungsi anonim dengan dua argumen dan `do` saja akan mendeklarasikan
bahwa pernyataan selanjutnya adalah fungsi anonim dengan bentuk `() -> ...`.

Bagaimana argumen tersebut diinisialisasi bergantung pada fungsi 'lebih luar';
dalam kasus ini adalah `map()` yang akan berturut-turut memberikan nilai `x`
ke `A`, `B`,`C`, memanggil fungsi anonim pada tiap-tiap nilai tersebut, sebagaimana
yang dilakukan dengan sintaks `map(func, [A,B,C])`

Sintaks ini memudahkan penggunaan fungsi untuk mengekstensi bahasa, karena pemanggilan
ini mirip seperti blok kode biasa. Terdapat banyak penggunaan yang cukup berbeda
dengan contoh yang baru saja diberikan untuk fungsi `map()`, seperti dalam kasus
pengaturan keadaan sistem. Sebagai contoh, terdapat satu versi dari fungsi
`open()` yang menjalankan kode yang menjamin bahwa file yang dibuka akan ditutup
pada akhirnya:

```julia
open("outfile", "w") do io
    write(io, data)
end
```

Hal ini dicapai dengan menggunakan definisi berikut untuk fungsi `open()`:

```julia
function open(f::Function, args...)
    io = open(args...)
    try
        f(io)
    finally
        close(io)
    end
end
```

Di sini, pertama-tama `open()` akan membuka file untuk ditulis dan kemudian
melemparkan output stream yang dihasilkan ke fungsi anonim yang didefinisikan
dalam blok `do ... end`. Setelah pemanggilan fungsi anonim ini keluar, `open()`
akan menjamin bahwa stream yang dibuka akan ditutup sebagaimana mestinya,
tidak bergantung pada apakah fungsi anonim yang kita tulis keluar dengan normal
atau melemparkan eksepsi.
(Konstruksi `try ...  finally` akan dijelaskan pada **Alur Kontrol**).

Sintaks blok `do` membantu untuk mengecek dokumentasi atau implementasi untuk
mengetahui bagaimana fungsi pengguna diinisialisasi.
