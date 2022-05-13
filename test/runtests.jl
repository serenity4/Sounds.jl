using Sounds
using Test

@testset "Sounds.jl" begin
    A = MusicalNote(440)
    @test isapprox(SineWave(A)(2), 0; atol = 1e-12)
    @test A + 1 - 1 == A
    @test A + 12 == MusicalNote(880)
    m = Mix([SineWave(A), SineWave(A + 12)], [1., 2.])
    @test isapprox(m(2), 0; atol = 1e-12)
    @test m(2.32) < 0.7

    ema = EMA(SineWave(A), 10)
    @test Sounds.evaluate(ema, 2, 44000) isa Vector
end
