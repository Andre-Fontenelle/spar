# ================================= Imports ================================== #
#using Pkg; Pkg.add(url="https://github.com/Andre-Fontenelle/composites")
using Composites: Composite, CarbonFiber
using Test

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

# ================================== Tests =================================== #
@testset verbose = true "Circular Spar Initialization" begin
    @testset "$numberOfSections Section(s)" for numberOfSections = 1
        # Get default test spar
        spar, testDict = defaultCircularSpar(numberOfSections)

        # Extract values from dictionary
        numberOfNodes    = testDict["numberOfNodes"]
        sectionNodes     = testDict["sectionNodes"]
        layerTransitions = testDict["layerTransitions"]
        layerAngles      = testDict["layerAngles"]
        layerMaterial    = testDict["layerMaterial"]

        @test spar.numberOfNodes    == numberOfNodes
        @test spar.sectionNodes     == sectionNodes
        @test spar.layerTransitions == layerTransitions
        @test spar.layerAngles      == layerAngles
        @test spar.layerMaterial    == layerMaterial
    end
end
