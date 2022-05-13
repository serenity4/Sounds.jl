using Sounds

A = MusicalNote(440)

p = Fractal(Perlin(2^1); base_frequency = 1., octaves = 24, persistence = 0.9)
p = Fractal(Perlin(2^12); base_frequency = 1760., octaves = 128, persistence = 0.8, lacunarity = 1.3)

play(p, 2)
play(EMA(p, 10), 2)
play(Mix(SineWave.([A, A + 3, A + 10, A + 12]), [1., 0.5, 1.2, 0.5]), 2)
