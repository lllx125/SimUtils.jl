using AccelUtils
using Documenter

DocMeta.setdocmeta!(AccelUtils, :DocTestSetup, :(using AccelUtils); recursive=true)

makedocs(;
    modules=[AccelUtils],
    authors="mattsignorelli <mgs255@cornell.edu> and contributors",
    sitename="AccelUtils.jl",
    format=Documenter.HTML(;
        canonical="https://bmad-sim.github.io/AccelUtils.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/bmad-sim/AccelUtils.jl",
    devbranch="main",
)
