using Sounds
using Sounds: Transform
using GeometryExperiments
using GeometryExperiments: Point
using ProceduralNoise: remap
using CairoMakie

lowpass(f, threshold) = x -> f(x) * exp(-x/threshold)

function plot_signal(p, xs; xscale = identity, yscale = identity, kwargs...)
  f = Figure(resolution = (1200, 800))
  Axis(f[1, 1]; xscale, yscale)
  lines!(xs, evaluate(p, xs); kwargs...)
  f
end

plot_signal(p, duration::Real; kwargs...) = plot_signal(p, time_coordinates(duration); kwargs...)

patch = Patch(BezierCurve(), 3)

frequencies = exp.(0.1:0.01:9.1)

control_points = Point{2,Float64}[
  (log(40), 0.),
  (log(100), 0.1),
  (log(1000), 0.5),
  (log(3000), 0.6),
  (log(5000), 0.1),
  (log(8000), 0.),
  (log(10000), 0.),
]

amplitude = x -> last(patch(remap(x, extrema(frequencies), (0, 1)), control_points))

plot_signal(amplitude, frequencies)

p = Transform(Base.Fix1(+, 0.5) ∘ Perlin(2^1), 1/10000, 0.2)
plot_signal(p, frequencies; xscale = log, yscale = log)

# amplitude = lowpass(p, 2000)
phase = Perlin(2^1) ∘ Base.Fix2(*, 1/10000)

freq = FrequencySignal(frequencies, amplitude, phase)
signal = reconstruct(freq)

plot_signal(signal, 0.5)
play(signal, 2)

function amplitude_bezier(frequencies, control_points, patch)
  from = extrema(frequencies)
  function _amplitude(t)
    last(patch(remap(t, from, (0, 1)), control_points))
  end
end

function make_signal(control_points)
  frequencies = exp.(0.1:0.01:9.1)
  amplitude = amplitude_bezier(frequencies, control_points, Patch(BezierCurve(), 3))
  phase = scaled(Perlin(2^1), 1/10000)
  freq = FrequencySignal(frequencies, amplitude, phase)
  reconstruct(freq)
end

signal = make_signal(Point{2,Float64}[
  (log(40), 0.),
  (log(60), 0.),
  (log(120), 0.),
  (log(800), 2.7),
  (log(1000), 2.),
  (log(1500), 1.),
  (log(5000), 0.1),
  (log(8000), 0.2),
  (log(10000), 0.),
])
play(signal, 2)
plot_signal(signal, 2)
