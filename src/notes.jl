struct MusicalNote
  frequency::Float64
end
frequency(note::MusicalNote) = note.frequency

Base.broadcastable(note::MusicalNote) = Ref(note)

Base.:(+)(a::MusicalNote, b::Real) = MusicalNote(a.frequency * 2^(b/12))
Base.:(-)(a::MusicalNote, b::Real) = MusicalNote(a.frequency / 2^(b/12))
Base.promote_type(::Type{MusicalNote}, ::Type{<:Real}) = MusicalNote
