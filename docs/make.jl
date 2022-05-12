using VoiceAdaptation
using Documenter

DocMeta.setdocmeta!(VoiceAdaptation, :DocTestSetup, :(using VoiceAdaptation); recursive=true)

makedocs(;
    modules=[VoiceAdaptation],
    authors="Cédric BELMANT",
    repo="https://github.com/serenity4/VoiceAdaptation.jl/blob/{commit}{path}#{line}",
    sitename="VoiceAdaptation.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://serenity4.github.io/VoiceAdaptation.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/serenity4/VoiceAdaptation.jl",
    devbranch="main",
)
