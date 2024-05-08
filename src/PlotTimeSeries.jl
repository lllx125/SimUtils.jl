using FFTW
using Plots

function plotspectrum(time_series)
    spectrum = rfft(time_series)
    plot([abs.(spectrum)], xscale=:log10, yscale=:log10)

end

function plottimeseries(time_series)
    plot(abs.(time_series))

end

#plotspectrum(gen_pinknoise(2.0))
#plottimeseries(gen_pinknoise(1.0))

export plotspectrum, plottimeseries
