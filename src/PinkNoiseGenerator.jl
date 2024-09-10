using Random
using FFTW

"""
function gen_pinknoise(
  beta::Float64=1.0,
  size::Int64=2^12,
  dt::Float64=1.0,
  f0::Float64=1.0
)

    description:
    > this function generates pink noise with frequency rolloff coefficient 'beta'. The spectrum has the shape (f0/f)^(beta)

    positional parameter:
    beta             -- type:Float64, frequency rolloff coefficient
    size             -- type:Int64, number of points
    keyword parameter:
    dt               -- type:Float64, the difference of between each data, total time = size * dt, unit: s
    f0               -- type:Float64, unit: Hz

    Note: 
    the algorithm is based on 
    "Timmer, J. and Koenig, M.: On generating power law noise. Astron. Astrophys. 300, 707-710 (1995)"

"""
gen_pinknoise

function gen_pinknoise(
  beta::Float64=1.0,
  size::Int64=2^12;
  dt::Float64=1.0,
  f0::Float64=1.0
)
  # Calculate Frequencies
  f = rfftfreq(size) .* 2
  # Build scaling factors for all frequencies
  s_scale = ((f0 * dt) ./ f) .^ (beta)
  s_scale[1] = s_scale[2]

  size = length(f)

  # Generate scaled random power + phase
  sr = randn(size) .* s_scale
  si = randn(size) .* s_scale

  # If the signal length is even, frequencies +/- 0.5 are equal
  # so the coefficient must be real.
  if size % 2 == 0
    si[end] = 0
    sr[end] *= sqrt(2)   # Fix magnitude
  end
  # Regardless of signal length, the DC component must be real
  si[1] = 0
  sr[1] *= sqrt(2)    # Fix magnitude

  # Combine power + corrected phase to Fourier components
  s = sr + im .* si

  # Transform to real time series 
  return irfft(s, size * 2 - 2)

end

export gen_pinknoise
