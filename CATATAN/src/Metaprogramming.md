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
