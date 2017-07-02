# Operasi matematika dan fungsi elementer

Julia menyediakan kumpulan lengkap dari operator dasar aritmatika dan bit untuk
semua tipe numerik primitif, dan juga menyediakan implementasi portabel dan
efisien dari sekumpulan fungsi matematika standard.

## Operator aritmatika

Operator aritmatika berikut dapat digunakan pada semua tipe numerik primitif:

| Ekspresi | Nama | Deskripsi |
| -------- |------| --------- |
| `+x` | unary plus | operasi indentitas |
| `-x` | unary minus | memetakan nilai ke invers aditif |
| `x + y` | binary plus | operasi penjumlahan |
| `x - y` | binary minus | operasi pengurangan |
| `x * y` | perkalian | operasi perkalian |
| `x / y` | pembagian | operasi pembagian |
| `x \ y` | pembagian invers | ekuivalen dengan `y / x` |
| `x ^ y` | pemangkatan | menghitung `x` pangkat `y` |
| `x % y` | sisa pembagian | ekuivalen dengan `rem(x,y)` |

dan juga operasi negasi pada tipe `Bool`:

| Ekspresi | Nama | Deskripsi |
| -------- |------| --------- |
| `!x` | negasi | mengubah `true` menjadi `false` dan sebaliknya |
