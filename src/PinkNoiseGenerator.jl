using Random
using FFTW

"""
  function gen_pinknoise(
   beta::Float64,
    size::Int64 = 2^9
  )

    description:
    > this function generates pink noise with frequency rolloff coefficient 'beta'

    parameter:
    beta             -- type:Float64, frequency rolloff coefficient
    size             -- type:Int64, default to 10^24, number of points

    Note: 
    the algorithm is based on 
    "Timmer, J. and Koenig, M.: On generating power law noise. Astron. Astrophys. 300, 707-710 (1995)"

"""
gen_pinknoise

function gen_pinknoise(
  beta::Float64,
  size::Int64=2^9
)
  # Calculate Frequencies
  f = rfftfreq(size)
  # Build scaling factors for all frequencies
  s_scale = f .^ (-beta / 2.0)
  s_scale[1] = s_scale[2]

  # Calculate theoretical output standard deviation from scaling
  w = copy(s_scale[2:end])
  w[end] *= (1 + (size % 2)) / 2.0 # correct f = +-0.5
  sigma = 2 * sqrt(sum(w .^ 2)) / size
  #print(sigma)

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

  # Transform to real time series & scale to unit variance
  return irfft(s, size * 2 - 2) ./ sigma

end

export gen_pinknoise
