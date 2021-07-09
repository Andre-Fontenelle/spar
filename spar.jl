# ================================= Imports ================================== #
#using Pkg; Pkg.add(url="https://github.com/Andre-Fontenelle/composites")
using Composites: Composite, CarbonFiber
using Test
include("tests/sparTestsDefaults.jl")
include("methods/abstractMethods.jl")

# =========================== Parent Abstract Type =========================== #
abstract type AbstractSpar end

# ================================= Circular ================================= #
struct CircularSpar <: AbstractSpar
    # Global spar parameters (size of arrays might change)
    numberOfNodes    :: T          where T <: Int64
    sectionNodes     :: Array{T,2} where T <: Float64
    layerTransitions :: Array{T,1} where T <: Int64
    layerAngles      :: Array{T,2} where T <: Any
    layerMaterial    :: Composite

    # Specific spar parameters
    diameter         :: Float64
end

# =============================== Rectangular ================================ #
struct RectangularSpar <: AbstractSpar
    # Global spar parameters (size of arrays might change)
    numberOfNodes    :: T          where T <: Int64
    sectionNodes     :: Array{T,2} where T <: Float64
    layerTransitions :: Array{T,1} where T <: Int64
    layerAngles      :: Array{T,3} where T <: Any
    layerMaterial    :: Composite

    # Specific spar parameters
    webHeight        :: Array{T,1} where T <: Float64
    capLength        :: Array{T,1} where T <: Float64
end

# =============================== Constructors =============================== #
function RectangularConstructor(structInputs...)
    Spar = RectangularSpar(structInputs...)
    assertAbstractSpar(Spar)
    assertConcreteSpar(Spar)
    return Spar
end

function CircularConstructor(structInputs...)
    Spar = CircularSpar(structInputs...)
    assertAbstractSpar(Spar)
    assertConcreteSpar(Spar)
    return Spar
end

function assertAbstractSpar(Spar :: AbstractSpar)
    @assert Spar.numberOfNodes > 1
    @assert size(Spar.sectionNodes, 1) > 1
    @assert length(Spar.layerTransitions) == size(Spar.layerAngles, 2) - 1
end

function assertConcreteSpar(Spar :: RectangularSpar)
    @assert length(Spar.webHeight) == size(Spar.sectionNodes, 1)
    @assert length(Spar.webHeight) == length(Spar.capLength)
end

function assertConcreteSpar(Spar :: CircularSpar); end

# ================================== Tests =================================== #
@testset "Circular Spar Initialization" begin
    @testset "$numberOfSections Section(s)" for numberOfSections = 1:2
        # Get default test spar
        spar, initDict = defaultCircularSpar(numberOfSections)

        # Tests
        @test spar.numberOfNodes    == initDict["numberOfNodes"]
        @test spar.sectionNodes     == initDict["sectionNodes"]
        @test spar.layerTransitions == initDict["layerTransitions"]
        @test spar.layerAngles      == initDict["layerAngles"]
        @test spar.layerMaterial    == initDict["layerMaterial"]
        @test spar.diameter         == initDict["diameter"]
    end
end

@testset "Rectangular Spar Initialization" begin
    @testset "$numberOfSections Section(s)" for numberOfSections = 1:2
        # Get default test spar
        spar, initDict = defaultRectangularSpar(numberOfSections)

        # Tests
        @test spar.numberOfNodes    == initDict["numberOfNodes"]
        @test spar.sectionNodes     == initDict["sectionNodes"]
        @test spar.layerTransitions == initDict["layerTransitions"]
        @test spar.layerAngles      == initDict["layerAngles"]
        @test spar.layerMaterial    == initDict["layerMaterial"]
        @test spar.webHeight        == initDict["webHeight"]
        @test spar.capLength        == initDict["capLength"]
    end
end
