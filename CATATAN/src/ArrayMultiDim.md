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
fungsi lebih atas yang memanggil. Seluruh pustaka array
