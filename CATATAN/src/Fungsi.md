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
