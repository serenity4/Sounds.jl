using Sounds
using FFTW
using DSP
using Plots

sample_rate = Sounds.sample_rate()

function plot_spectrogram(wave, duration = 10; segment_width = 100 #= samples =#)
  plot_spectrogram(Sounds.evaluate(wave, duration, sample_rate); segment_width)
end

function plot_spectrogram(s::AbstractVector; segment_width = 100)
  sp = spectrogram(s, segment_width; fs = sample_rate)
  heatmap(sp.time, sp.freq, sp.power)
end

function plot_periodogram(wave, duration = 10)
  s = Sounds.evaluate(wave, duration, sample_rate)
  plot_periodogram(s)
end

function plot_periodogram(s::AbstractVector)
  p = periodogram(s; fs = sample_rate)
  plot(p.freq, p.power)
end

wave1 = SineWave(sample_rate / 4)
wave2 = Fractal(Perlin(2^12); base_frequency = 1760., octaves = 128, persistence = 0.8, lacunarity = 1.3)
wave3 = Mix([wave1, wave2], [1.0, 1.0])

plot_spectrogram(wave1)
plot_spectrogram(wave2)
plot_spectrogram(wave3)

plot_periodogram(wave1)
plot_periodogram(wave2)
plot_periodogram(wave3)
