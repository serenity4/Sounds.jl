using Sounds

function ema(ys, n)
  res = similar(ys)
  for i in eachindex(ys)
      v = 0.
      range = i:-1:max(1, i-n)
      for j in range
      v += ys[j] * exp(j/i)
      end
      res[i] = v / sum(exp.(range ./ i))
  end
  res
end

p = Fractal(Perlin(2^1); base_frequency = 1., octaves = 24, persistence = 0.9)
p = Fractal(Perlin(2^12); base_frequency = 1760., octaves = 128, persistence = 0.8, lacunarity = 1.3)

play(sample(p, 2))
play(ema(sample(p, 2), 20))
play(sample(440, [1., 1., 1.], 2))
