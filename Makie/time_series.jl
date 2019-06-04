using Makie

 function run_example()
     f0 = 1/2; fs = 100;
     winsec = 4; hopsec = 1/60
     nwin = round(Integer, winsec*fs)
     nhop = round(Integer, hopsec*fs)
     # do the loop
     frame_start = -winsec
     frame_time = collect((0:(nwin-1)) * (1/fs))
     aframe = sin.(2*pi*f0.*(frame_start .+ frame_time))
     scene = lines(frame_start .+ frame_time, aframe)
     lineplot = scene[end]
     N = 50
     record(scene, "./time_series.mp4", 1:N) do i
         aframe .= sin.(2*pi*f0.*(frame_start .+ frame_time))
         # append!(aframe, randn(nhop)); deleteat!(aframe, 1:nhop)
         lineplot[1] = frame_start .+ frame_time
         lineplot[2] = aframe
         AbstractPlotting.update_limits!(scene)
         AbstractPlotting.update!(scene)
         sleep(hopsec)
         frame_start += hopsec
     end
 end
 run_example()

