using Sounds


p = Fractal(Perlin(2^1); base_frequency = 1., octaves = 24, persistence = 0.9)
p = Fractal(Perlin(2^12); base_frequency = 1760., octaves = 128, persistence = 0.8, lacunarity = 1.3)

play(p, 2)
play(EMA(p, 10), 2)
play(sample(440, [1., 1., 1.], 2))
