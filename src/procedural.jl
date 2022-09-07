"Parametrized sine wave with frequency, phase and amplitude values."
struct SineWave
  frequency::Float64
  phase::Float64
  amplitude::Float64
end
frequency(x::Number) = x

SineWave(x; phase = 0, amplitude = 1) = SineWave(frequency(x), phase, amplitude)
(wave::SineWave)(t) = wave.amplitude * sin(2π * wave.frequency * t + wave.phase)

"""
Weighted mixture of signals.
"""
struct Mix{S}
  sources::S
  weights::Vector{Float64}
  sum::Float64
end

Mix(sources, weights) = Mix(sources, weights, sum(weights))
(mix::Mix)(t) = sum(s(t) * w for (s, w) in zip(mix.sources, mix.weights)) / mix.sum

"""
Frequency representation of a signal with frequency, amplitude and phase functions.

It can be reconstructed as a combination of sine waves with [`reconstruct`](@ref).
Final reconstruction as a time series can then be evaluated by calling the resulting [`Mix`](@ref)
signal on a vector of time values.
"""
struct FrequencySignal
  frequencies
  amplitude
  phase
end

"Convert a [`FrequencySignal`](@ref) into a [`Mix`](@ref) of [`SineWave`](@ref)."
function reconstruct(freq::FrequencySignal)
  (; frequencies, amplitude, phase) = freq
  weights = amplitude.(frequencies)
  waves = SineWave.(frequencies, phase.(frequencies), 1.)
  Mix(waves, weights)
end
