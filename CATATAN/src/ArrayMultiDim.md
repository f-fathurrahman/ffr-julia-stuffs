# Array Multidimensional

Julia, seperti halnya bahasa komputasi teknis lain, menyediakan implementasi
array kelas pertama. Sebagian besar bahasa komputasi teknis memberikan perhatian
lebih terhadap implementasi array dengan mengorbankan kontainer data lain.
Julia tidak memperlakukan array secara khusus. Pustaka array diimplementasikan
hampir sepenuhnya dalam bahasa Julia itu sendiri, dan mendapatkan performansinya
secara langsung dari kompiler, seperti kode lain yang ditulis dalam Julia.
Dengan demikian kita dapat mendefinisikan tipe array kustom dengan memperluas
tipe `AbstractArray`.

Sebuah array adalah kumpulan dari objek yang disimpan dalam suatu grid
multidimensi. Pada kasus yang paling umum, sebuah array dapat terdiri dari dengan
tipe `Any`. Untuk sebagian besar kebutuhan komputasi, array harus mengandung
objek dengan tipe yang lebih spesifik seperti `Float64` atau `Int32`.

Secara umum, tidak seperti bahasa komputasi teknis lain, Julia tidak mewajibkan
pemrogram untuk menulis program dengan gaya tervektorisasi untuk mendapatkan
performansi yang baik. Kompiler Julia menggunakan inferensi tipe dan menghasilkan
kode teroptimasi untuk pengindeksan array skalar, memungkinkan program
untuk ditulis dalam style yang nyaman dan mudah dibaca, tanpa mengorbankan
performansi dan menggunakan memori yang lebih sedikit.

Dalam Julia, semua argumen ke fungsi akan dilemparkan dengan referensi
(*passed by reference*). Dalam beberapa bahasa komputasi teknis, array dilemparkan
dengan nilai (*pass by value*) dan hal ini berguna dalam banyak kasus.
Dalam Julia, modifikasi yang dilakukan pada array input akan terlihat pada
fungsi lebih atas yang memanggil. Seluruh pustaka array Julia telah didesain
agar input tidak dimodifikasi oleh fungsi yang ada dalam pustaka. Kode yang
ditulis oleh pengguna, jika ingin memiliki kelakuan yang sama, harus membuat
kopi dari input yang mungkin diubahnya.

## Array

### Fungsi-fungsi dasar

| Fungsi | Deskripsi |
| ------ | --------- |
| `eltype(A)` | tipe dari elemen yang terkandung dalam `A` |
| `length(A)` | jumlah elemen di dalam `A` |
| `ndims(A)` | jumlah dimensi `A` |
| `size(A)` | tupel yang berisi dimensi-dimensi dari `A` |
| `suze(A,n)` | ukuran `A` sepanjang dimensi ke-`n` |
| `indices(A)` | tupel yang berisi indeks valid dari `A` |
| `eachindex(A)` | iterator efisien untuk setiap posisi dalam `A` |
| `stride(A,k)` | stride (jarak indeks linear antara elemen yang berdekatan) sepanjand dimensi `k` |
| `strides(A)` | tupel dari stride pada masing-masing dimensi dari `A` |
