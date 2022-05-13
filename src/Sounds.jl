module Sounds

using Reexport
using PortAudio: PortAudioStream
@reexport using ProceduralNoise: Fractal, Perlin, NoiseGenerator

include("sampling.jl")
include("procedural.jl")
include("notes.jl")
include("postprocessing.jl")

export sample, play, MusicalNote, frequency, set_sample_rate, Mix, SineWave, EMA

end
