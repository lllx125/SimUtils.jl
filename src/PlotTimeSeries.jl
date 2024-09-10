using FFTW
using Plots
include("PinkNoiseGenerator.jl")

function plotlogspectrum(time_series)
    spectrum = rfft(time_series)
    plot([abs.(spectrum)], xscale=:log10, yscale=:log10, title="Logarithmic Graph for Pinknoise Spectrum", label="pink noise spectrum")
    xlabel!("log(f)")
    ylabel!("log(amplitude)")

end

function plotspectrum(time_series)
    spectrum = rfft(time_series)
    plot([abs.(spectrum)], title="Pinknoise Spectrum", label="pink noise spectrum")
    xlabel!("f")
    ylabel!("amplitude")
end

function plottimeseries(time_series)
    plot(time_series, title="Pinknoise Time Series", label="pink noise")
    xlabel!("t")
    ylabel!("amplitude")
end

function test(beta::Float64=1.0,
    size::Int64=2^12;
    dt::Float64=1.0,
    f0::Float64=1.0)
    time_series = gen_pinknoise(beta, size, dt=dt, f0=f0)
    spectrum = rfft(time_series)
    f = rfftfreq(length(spectrum))
    plot([abs.(spectrum), (((f0 * dt) ./ f) .^ (beta))], xscale=:log10, yscale=:log10, label=["pink noise spectrum" "(" * string(f0) * "/f)^(" * string(beta) * ")"], size=(700, 700))
    title!("Logarithmic Graph for Pinknoise Spectrum and Best-fit Line")
    xlabel!("log(f)")
    ylabel!("log(amplitude)")
end



export plotspectrum, plotlogspectrum, plottimeseries, test
