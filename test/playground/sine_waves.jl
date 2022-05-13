using VoiceAdaptation

A = MusicalNote(440)

for i in 1:13
    note = A + i - 1
    println(frequency(note), " Hz")
    play(sample(note, 0.1))
end

for i in 1:6
    freq = 440 * 2^(i-1)
    println(freq, " Hz")
    play(sample(freq, 0.1))
end
