using FFTW
using Plots
include("PinkNoiseGenerator.jl")

function plotlogspectrum(time_series)
    spectrum = rfft(time_series)
    plot([abs.(spectrum)], xscale=:log10, yscale=:log10)

end

function plotspectrum(time_series)
    spectrum = rfft(time_series)
    plot([abs.(spectrum)])

end

function plottimeseries(time_series)
    plot(time_series)

end

function test(beta::Float64=1.0,
    size::Int64=2^12;
    dt::Float64=1.0,
    f0::Float64=1.0)
    time_series = gen_pinknoise(beta, size, dt=dt, f0=f0)
    spectrum = rfft(time_series)
    f = rfftfreq(length(spectrum))
    plot([abs.(spectrum), (((f0 * dt) ./ f) .^ (beta))], xscale=:log10, yscale=:log10)
end



export plotspectrum, plotlogspectrum, plottimeseries
