module Sounds

using Reexport
using PortAudio: PortAudioStream
@reexport using ProceduralNoise: Fractal, Perlin
using ProceduralNoise: NoiseGenerator
const SAMPLE_RATE = Ref(44100.0)

struct MusicalNote
  frequency::Float64
end
frequency(note::MusicalNote) = note.frequency

Base.broadcastable(note::MusicalNote) = Ref(note)

Base.:(+)(a::MusicalNote, b::Real) = MusicalNote(a.frequency * 2^(b/12))
Base.:(-)(a::MusicalNote, b::Real) = MusicalNote(a.frequency / 2^(b/12))
Base.promote_type(::Type{MusicalNote}, ::Type{<:Real}) = MusicalNote

sample_rate() = SAMPLE_RATE[]

sample(frequency, duration = 1) = 0.7 * sin.(2π * frequency / sample_rate() .* (1:(duration * sample_rate())))
sample(frequency, weights::AbstractVector{<:Real}, duration = 1) = sum(weights .* sample.(frequency .* 2 .^ (0:(length(weights) - 1)), duration)) / sum(weights)
sample(note::MusicalNote, duration = 1) = sample(frequency(note), duration)
sample(p::NoiseGenerator, duration = 1) = 3.5 * p.(0:(1/(duration * sample_rate())):1)

function play(x)
  PortAudioStream(0, 2; samplerate = sample_rate()) do stream
    write(stream, x)
  end
  nothing
end

export sample, play, MusicalNote, frequency

end
