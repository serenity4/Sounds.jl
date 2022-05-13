struct SineWave
  frequency::Float64
  phase::Float64
  amplitude::Float64
end
frequency(x::Number) = x

SineWave(x; phase = 0, amplitude = 1) = SineWave(frequency(x), phase, amplitude)
(wave::SineWave)(t) = wave.amplitude * sin(2π * wave.frequency * t + wave.phase)

struct Mix{S}
  sources::S
  weights::Vector{Float64}
  sum::Float64
end

Mix(sources, weights) = Mix(sources, weights, sum(weights))
(mix::Mix)(t) = sum(s(t) * w for (s, w) in zip(mix.sources, mix.weights)) / mix.sum

struct FrequencySignal
  frequencies
  amplitude
  phase
end

function reconstruct(freq::FrequencySignal)
  (; frequencies, amplitude, phase) = freq
  weights = amplitude.(frequencies)
  waves = SineWave.(frequencies, phase.(frequencies), 1.)
  Mix(waves, weights)
end
