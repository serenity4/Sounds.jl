using Sounds
using Documenter

DocMeta.setdocmeta!(Sounds, :DocTestSetup, :(using Sounds); recursive=true)

makedocs(;
    modules=[Sounds],
    authors="Cédric BELMANT",
    repo="https://github.com/serenity4/Sounds.jl/blob/{commit}{path}#{line}",
    sitename="Sounds.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://serenity4.github.io/Sounds.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/serenity4/Sounds.jl",
    devbranch="main",
)
