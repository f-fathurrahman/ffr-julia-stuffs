# Tutorial Singkat Bahasa Pemrograman Julia

## Instalasi Julia

Homepage: [Situs resmi](http://julialang.org/downloads/)

Julia Pro:

## Memulai Julia

Ketik `julia` pada terminal

```julia-repl
   _       _ _(_)_     |  A fresh approach to technical computing
  (_)     | (_) (_)    |  Documentation: https://docs.julialang.org
   _ _   _| |_  __ _   |  Type "?help" for help.
  | | | | | | |/ _` |  |
  | | |_| | | | (_| |  |  Version 0.6.0 (2017-06-19 13:05 UTC)
 _/ |\__'_|_|_|\__'_|  |  Official http://julialang.org/ release
|__/                   |  x86_64-pc-linux-gnu

julia>

```

Tampilan ini akan terlihat familiar bagi yang terbiasa bekerja dengan Python,
Octave, MATLAB, ataupun platform komputasi interaktif yang lain.
Kita dapat menggunakan Julia sebagai kalkulator:

```julia-repl
julia> 2 + 3
5

julia> sin(2.15*pi)
0.4539904997395466

julia> sin(2.15π)
0.4539904997395466
```

## Kode sumber Julia

Perhatikan bahwa kita dapat menggunakan karakter Latin `π` sebagai ganti dari
konstanta built-in `pi`. Berbeda dengan banyak bahasa pemrograman lain, Julia
sudah mendukung UTF-8 sehingga kita dapat menggunakan karakter tersebut sebagai
nama variabel.

```julia-repl
julia> α = 1.1;

julia> β = 2.1;

julia> γ = α + β;

julia> println(γ)
3.2
```

Kode sumber Julia bersifat *case-sensitive*, misalnya `VARIABEL` berbeda dengan
`variabel`.

Kode sumber Julia dapat dibuat dengan editor teks dengan menggunakan ekstensi
`.jl`. Beberapa editor dapat digunakan:

- Atom
- Vim
- Emacs
- Sublime Text
- dan lain-lain

## Menampilkan hasil ke layar

Beberapa fungsi *built-in* dapat digunakan:
- `print` dan `println`
- `@printf`

```julia-repl
julia> println("α = ", α)
α = 1.1

julia> print("β = ", β)
β = 2.1
julia> @printf("γ is %18.10f\n", γ)
γ is       3.2000000000
```

## Help

```julia-repl
help?> sin
search: sin sinh sind sinc sinpi asin using isinf asinh asind isinteger isinteractive sign signif signed Signed signbit

  sin(x)

  Compute sine of x, where x is in radians.
```

## Akses *shell*

```julia-repl
shell> whoami
efefer

shell> uname -s -v
Linux #104-Ubuntu SMP Wed Jun 14 08:17:06 UTC 2017
```

## Percabangan

```julia-repl
julia> x = 5; y = 7;

julia> if x < y
         println("x lebih kecil dari y")
       elseif x > y
         println("x lebih besar dari y")
       else
         println("x sama dengan y")
       end
x lebih kecil dari y
```

## Loop

Menggunakan `for`

```julia-repl
julia> for i = 1:5
         println(i)
       end
1
2
3
4
5
```

Menggunakan `while`

```julia-repl
julia> i = 0;
julia> while i <= 5
         println(i)
         i = i + 1
       end
0
1
2
3
4
5
```


## Misc

Mengetahui informasi mengenai Julia

```julia-repl
julia> versioninfo()
Julia Version 0.6.0
Commit 9036443 (2017-06-19 13:05 UTC)
Platform Info:
  OS: Linux (x86_64-pc-linux-gnu)
  CPU: Intel(R) Pentium(R) CPU B980 @ 2.40GHz
  WORD_SIZE: 64
  BLAS: libopenblas (USE64BITINT DYNAMIC_ARCH NO_AFFINITY Nehalem)
  LAPACK: libopenblas64_
  LIBM: libopenlibm
  LLVM: libLLVM-3.9.1 (ORCJIT, sandybridge)
```

Mengetahui performa FLOP komputer

```julia-repl
julia> peakflops()
8.256808807860796e9

julia> BLAS.set_num_threads(2)

julia> peakflops( )
1.6872977786135246e10
```
