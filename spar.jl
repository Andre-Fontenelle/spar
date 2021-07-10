# ========================== Import Other Packages =========================== #
#using Pkg; Pkg.add(url="https://github.com/Andre-Fontenelle/composites")
# using Pkg; Pkg.add(url="https://github.com/Andre-Fontenelle/miscellaneous_functions")
using Composites: Composite, CarbonFiber
using Test
include("aux_functions/baseFunctionsOverload.jl")
include("aux_functions/matlabFunctions.jl")
include("aux_functions/vectorOperations.jl")

# =========================== Parent Abstract Types ========================== #
abstract type AbstractSpar end
abstract type CompositeSpar <: AbstractSpar end

# ========================== Circular Concrete Type ========================== #
struct CircularSpar <: CompositeSpar
    # CompositeSpar parameters (size of arrays might change)
    numberOfNodes    :: Int64
    sectionNodes     :: Array{Float64,2}
    layerTransitions :: Array{Int64,1}
    layerAngles      :: Array{Any,2}
    layerMaterial    :: Composite

    # Specific spar parameters
    diameter         :: Float64

    # Impose constraints through inner constructor
    function CircularSpar(numberOfNodes, sectionNodes, layerTransitions, layerAngles, layerMaterial, diameter)
        compositeSparConstraints(numberOfNodes, sectionNodes, layerTransitions, layerAngles)
        new(numberOfNodes, sectionNodes, layerTransitions, layerAngles, layerMaterial, diameter)
    end
end

# ======================== Rectangular Concrete Type ========================= #
struct RectangularSpar <: CompositeSpar
    # CompositeSpar parameters (size of arrays might change)
    numberOfNodes    :: Int64
    sectionNodes     :: Array{Float64,2}
    layerTransitions :: Array{Int64,1}
    layerAngles      :: Array{Any,3}
    layerMaterial    :: Composite

    # Specific spar parameters
    webHeight        :: Array{Float64,1}
    capLength        :: Array{Float64,1}

    # Impose constraints through inner constructor
    function RectangularSpar(numberOfNodes, sectionNodes, layerTransitions, layerAngles, layerMaterial, webHeight, capLength)
        compositeSparConstraints(numberOfNodes, sectionNodes, layerTransitions, layerAngles)
        @assert length(webHeight) == size(sectionNodes, 1)
        @assert length(webHeight) == length(capLength)
        new(numberOfNodes, sectionNodes, layerTransitions, layerAngles, layerMaterial, webHeight, capLength)
    end
end

# =================== Constraints on Abstract Spar Inputs ==================== #
function compositeSparConstraints(numberOfNodes, sectionNodes, layerTransitions, layerAngles)
    @assert size(sectionNodes, 1) > 1
    @assert numberOfNodes >= size(sectionNodes, 1)
    @assert length(layerTransitions) == size(layerAngles, 2) - 1
end

# =========================== Import "Sub-Modules" =========================== #
include("tests/sparTestsDefaults.jl")
include("tests/initializationTests.jl")
include("methods/abstractMethods.jl")
include("tests/abstractSparMethodsTests.jl")
