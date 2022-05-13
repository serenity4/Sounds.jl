using Sounds
using Test

@testset "Sounds.jl" begin
    A = MusicalNote(440)
    @test sample(A, 2) isa Vector
    @test A + 1 - 1 == A
    @test A + 12 == MusicalNote(880)
    p = Fractal(Perlin(2^1); base_frequency = 1., octaves = 24, persistence = 0.9)
    @test sample(p, 2) isa Vector
end
