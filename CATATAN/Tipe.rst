===========
Sistem Tipe
===========

Sistem tipe pada Julia bersifat dinamik, namun juga dapat mengambil keuntungan dari
sistem tipe statik karena juga memungkinkan kita untuk mengindikasikan tipe dari
suatu variabel atau data.

Secara default, tipe data pada Julia dapat dihilangkan sehingga suatu variabel
dapat memiliki tipe apa saja.


Deklarasi tipe
--------------

Deklarasi tipe pada Julia dapat dilakukan dengan menggunakan operator ``::``.
Misalkan:

.. code:: julia

  N::Int64 = 10
  a::Float64 = 34.1

Ketika operator ``::`` diberikan setelah suatu ekspresi, maka operator ``::``
dibaca sebagai *is an instance of* yang digunakan sebagai penegasan suatu
ekspresi akan memiliki suatu tipe tertentu.

Deklarasi juga dapat disematkan pada definisi fungsi:

.. code:: julia

  function sinc(x)::Float64
    if x == 0
      return 1
    end
    return sin(pi*x)/(pi*x)
  end


Tipe abstrak
------------

Tipe abstrak tidak dapat diinstansiasi dan hanya berfungsi sebagai node pada
graf tipe, sehingga mendeskripsikan himpunan dari tipe-tipe konkrit yang saling
berkaitan: tipe konkrit yang merupakan turunan dari tipe abstrak ini.
Meskipun tidak memiliki instansiasi, tipe abstrak diperlukan karena tipe abstrak
merupakan tulang punggung dari sistem tipe, sebagai hierarki konseptual yang
membuat tipe sistem pada Julia lebih dari sekedar kumpulan dari implementasi obyek.

Sintaks:

.. code:: julia

  abstract type NamaTipe end
  abstract type NamaTipe <: TipeSuper end




Misc
----

Untuk mengkonversi dari suatu tipe ke tipe yang lain dapat digunakan
fungsi ``convert()``.

Fungsi ``typeof()`` dapat digunakan untuk mengetahui tipe suatu variabel:


.. code:: julia

  julia> typeof(3.14)
  Float64

  julia> typeof(11)
  Int64

  julia> typeof(2//5)
  Rational{Int64}

  julia> typeof( (1,4,2) )
  Tuple{Int64,Int64,Int64}


Fungsi ``subtypes()`` dapat digunakan untuk mengetahui subtipe dari suatu tipe
dan ``supertype()`` digunakan untuk mengetahui supertipe dari suati tipe.
