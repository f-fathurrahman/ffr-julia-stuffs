import GR

# Set GKS_WSTYPE=pdf or 102 to output in pdf

x = zeros(29)
y = zeros(29)

for i in 1:29
    x[i] = -2 + (i-1) * 0.5
    y[i] = -7 + (i-1) * 0.5
end

z = zeros(29*29)

for i = 1:29
for j = 1:29
    r1 = sqrt( (x[j] - 5)^2 + y[i]^2 )
    r2 = sqrt( (x[j] + 5)^2 + y[i]^2 )
    z[(i-1)*29 + 1 + (j-1)] = (exp(cos(r1)) + exp(cos(r2)) - 0.9) * 25
end
end


GR.setcharheight(12.0/500)
GR.settextalign(GR.TEXT_HALIGN_CENTER, GR.TEXT_VALIGN_TOP)
GR.textext(0.5, 0.9, "Surface Example by efefer")
#(tbx, tby) = GR.inqtextext(0.5, 0.9, "Surface Example")
#GR.fillarea(tbx, tby)

GR.setwindow(-2, 12, -7, 7)
GR.setspace(-80, 200, 45, 45)  # changing the view

GR.setcharheight(10.0/500)
GR.axes3d(1, 0, 20, -2, -7, -80, 2, 0, 2, -0.01)
GR.axes3d(0, 1,  0, 12, -7, -80, 0, 2, 0,  0.01)
GR.titles3d("X-Axis", "Y-Axis", "Z-Axis")

GR.surface(x, y, z, 3)
GR.surface(x, y, z, 1)
#GR.surface(x,y,z, 2)  # black ?
#GR.surface(x, y, z, 4)

GR.updatews()

