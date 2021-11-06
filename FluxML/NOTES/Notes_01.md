Aktivasi project:
```julia
Pkg.activate(".")
```

atau dengan menggunakan argumen berikut ini ketika mengeksekusi Julia:
```
julia --project=. namascript.jl
```

Contoh menggunakan Flux
```julia
using Flux
model = Dense(3,1)
model.W
model.weight
model.b
model.bias
output = model(rand(3)) # evaluasi model
```

Secara default Float32 akan digunakan.
Untuk menggunakan Float64 kita perlu melakukan konversi terlebih
dahulu:
```julia
model = Dense(2,1) |> f64
```
atau:
```julia
module = f64(Dense(2,1))
```
