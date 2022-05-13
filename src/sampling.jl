const SAMPLE_RATE = Ref(44100.0)

sample_rate() = SAMPLE_RATE[]
set_sample_rate(rate) = (SAMPLE_RATE[] = rate)

time_coordinates(duration, samplerate = sample_rate()) = (1:(samplerate * duration)) ./ samplerate

evaluate(f, duration, samplerate) = evaluate(f, time_coordinates(duration, samplerate))
evaluate(f, xs::AbstractVector) = evaluate.(Ref(f), xs)
evaluate(f, t) = f(t)

function play(f, duration)
  samplerate = sample_rate()
  PortAudioStream(0, 2; samplerate) do stream
    write(stream, evaluate(f, duration, samplerate))
  end
  nothing
end
