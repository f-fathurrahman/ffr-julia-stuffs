# Variabel

Dalam Julia, sebuah variabel adalah nama yang diasosiasikan (atau terikat)
pada sebuah nilai. Variabel berguna ketika kita ingin menyimpan sebuah nilai
(misalnya hasil dari suatu perhitungan matematis) untuk digunakan pada
perhitungan lain atau proses selanjutnya. Sebagai contoh:

```julia-repl
# Memberikan nilai 10 ke variabel x
julia> x = 10
10

# Melakukan perhitungan dengan variabel x
julia> x + 1
11

# Memberikan x nilai yang lain
julia> x = 1 + 1
2

# x juga dapat diberikan nilai dengan tipe data yang berbeda, misalnya string/teks
julia> x = "Hello World!"
"Hello World!"
```

Julia memiliki sistem yang sangat fleksibel untuk penamaan variabel.
Nama variabel bersifat *case-sensitive* dan tidak memiliki arti semantik
khusus (artinya, Julia tidak akan memperlakukan variabel secara berbeda
berdasarkan nama variabel tersebut).

```julia-repl
julia> x = 1.0
1.0

julia> y = -3
-3

julia> Z = "My string"
"My string"

julia> customary_phrase = "Hello world!"
"Hello world!"

julia> UniversalDeclarationOfHumanRightsStart = "人人生而自由，在尊严和权利上一律平等。"
"人人生而自由，在尊严和权利上一律平等。"
```

Nama dengan karakter Unicode (enkoding UTF-8) diperbolehkan.

```julia-repl
julia> δ = 0.00001
1.0e-5

julia> 안녕하세요 = "Hello"
"Hello"
```

Di dalam Julia REPL dan beberapa lingkungan editing Julia yang lainnya, kita dapat
mengetikkan simbol matematika Unicode dengan mengetikkan nama simbol LaTeX dengan
*backslash* dan diikuti dengan tab.
Sebagai contoh, nama variabel δ dapat diketikkan dengan mengetik `\delta`-*tab*.
Bahkan simbol yang cukup kompleks seperti α̂₂ dapat diketik dengan
`\alpha`-*tab*-`\hat`-*tab*-`_2`-*tab*.
Jika kita menemukan suatu karakter Unicode pada kode Julia yang ditulis oleh
orang lain namun kita tidak mengetahui bagaimana mengetiknya, kita dapat menggunakan
REPL untuk memberitahu bagaimana cara mengetik simbol tersebut dengan cara:
ketik `?` kemudian *paste* karakter tersebut. Contoh:

```julia-repl
help?> ℒ₂
"ℒ₂" can be typed by \mscrL<tab>\_2<tab>

# .... [pesan mengenai tipe variabel ℒ₂]
```

Julia membolehkan kita untuk mendefinisikan ulang konstanta dan fungsi *built-in*
jika diperlukan. Akan tetapi, tentu saja hal ini tidak direkomendasikan untuk mengurangi
kebingungan nantinya.

```julia-repl
julia> pi
π = 3.1415926535897...

julia> pi = 3
WARNING: imported binding for pi overwritten in module Main
3

julia> pi
3

julia> sqrt(100)
10.0

julia> sqrt = 4
WARNING: imported binding for sqrt overwritten in module Main
4
```

## Nama variabel yang diperbolehkan

Nama variabel harus dimulai dengan huruf (A-Z atau a-z), garis bawah, atau
subset karakter Unicode dengan kode lebih besar dari 00A0, khususnya kategori
karakter Unicode Lu/Ll/Lt/Lm/Lo/Nl (huruf), Sc/So (mata uang dan simbol lain),
beserta karakter menyerupai hurus (seperti subset simbol matematik Sm) diperbolehkan
sebagai karaketer pertama dari nama variabel. Karakter selanjutnya dapat berupa
tanda seru ! dan digit (0-9 dan karaketer lain dalam kategori Nd/No), dan juga
kode titik Unicode: diakritik dan tanda pemodifikasi (kategori Mn/Mc/Me/Sk),
tanda baca penghubung (kategori Pc), tanda aksen (*prime*), dan beberapa
karakter lain.

Operator seperti `+` juga merupakan pengenal valid, namun diartikan (*parsed*)
secara khusus. Dalam beberapa konteks, operator juga dapat digunakan seperti
halnya variabel; misalnya `(+)` merujuk kepada fungsi pemjumlahan, dan
kode `(+) = f` akan mendefinisikan kembali fungsi penjumlahan tersebut.
Sebagian besar operator infiks Unicode (dalam kategori Sm), seperti
`⊕` diartikan sebagai operator infiks dan dapat digunakan pada
metode *user-defined*  (misalnya kita dapat menggunakan ekspresi
`const ⊕ = kron` untuk mendefinisikan `⊕` sebagai operator infiks
perkalian Kronecker).

Nama variabel yang secara eksplisit tidak diperbolehkan adalah kata kunci
*built-in*:

```julia-repl
julia> else = false
ERROR: syntax: unexpected "else"

julia> try = "No"
ERROR: syntax: unexpected "="
```

Beberapa karakter Unicode dianggap sebagai ekuivalen sebagai pengenal.
Beberapa cara berbeda untuk mengetikkan karakter Unicode penggabung (misalnya
aksen) diperlakukan sebagai ekuivalen (secara spesifik, pengenal Julia bersifat
*NFC-normalized*).
Karakter Unicode ɛ (U+025B: LATIN SMALL LETTER OPEN E) dan μ
(U+00B5: MICRO SIGN) diperlakukan sebagai ekuivalen.

## Konvensi style penulisan variabel

Meskipun Julia hanya memiliki sedikit restriksi terhadap nama yang valid,
akan sangat berguna untuk mengadopsi beberapa konvensi berikut.

- Nama variabel ditulis dengan huruf kecil

- Pemisahan kata dapat diindikasikan dengan menggunakan garis bawah `'_'`,
  namun penggunaan garis bawah tidak disarankan kecuali jika nama variabel
  akan sulit dibaca jika tidak demikian.

- Nama dari `Type` dan `Module` dimulai dengan huruf kapital dan pemisahan kata
  ditunjukkan dengan menggunakan *upper camel case*

- Nama fungsi dan makro ditulis dengan huruf kecil, tanpa garis bawah.

- Fungsi yang mengubah nilai argumen memiliki nama yang berakhir dengan
  tanda seru `!`. Fungsi tersebut sering disebut sebagai fungsi *mutating* atau
  *in-place* karena fungsi tersebut akan mengubah argumen fungsi setelah fungsi
  dipanggil, dan tidak hanya mengembalikan suatu nilai.
