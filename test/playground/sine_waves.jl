using Sounds

A = MusicalNote(440)

for i in 1:13
    note = A + i - 1
    println(note)
    play(SineWave(note), 0.2)
end

for i in 1:6
    freq = 440 * 2^(i-1)
    note = MusicalNote(freq)
    println(note)
    play(SineWave(note), 0.2)
end
