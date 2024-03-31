using SimUtils
using Documenter

DocMeta.setdocmeta!(SimUtils, :DocTestSetup, :(using SimUtils); recursive=true)

makedocs(;
    modules=[SimUtils],
    authors="mattsignorelli <mgs255@cornell.edu> and contributors",
    sitename="SimUtils.jl",
    format=Documenter.HTML(;
        canonical="https://bmad-sim.github.io/SimUtils.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/bmad-sim/SimUtils.jl",
    devbranch="main",
)
