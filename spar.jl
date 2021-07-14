# ========================== Import Other Packages =========================== #
#using Pkg; Pkg.add(url="https://github.com/Andre-Fontenelle/composites")
# using Pkg; Pkg.add(url="https://github.com/Andre-Fontenelle/miscellaneous_functions")
# using Pkg; Pkg.add("Interpolations")
using Composites: Composite, CarbonFiber
using Test
include("aux_functions/baseFunctionsOverload.jl")
include("aux_functions/matlabFunctions.jl")
include("aux_functions/vectorOperations.jl")
include("elements.jl")

# =========================== Parent Abstract Types ========================== #
abstract type AbstractSpar end
abstract type CompositeSpar <: AbstractSpar end

# ========================== Circular Concrete Type ========================== #
struct CircularSpar <: CompositeSpar
    # AbstractSpar parameters
    numberOfNodes      :: Int64
    numberOfElements   :: Int64
    numberOfSections   :: Int64
    sectionNodes       :: Matrix{Float64}
    sectionTransitions :: Matrix{Int64}
    nodes              :: Matrix{Float64}

    # CompositeSpar parameters
    layerMaterial  :: Composite
    layerAngles    :: Array{T,3} where T

    # CircularSpar parameters
    diameter :: Vector{Float64}

    # ========================== Inner Constructor =========================== #
    function CircularSpar(numberOfNodes    :: Int64,
                          sectionNodes     :: Matrix{Float64},
                          layerTransitions :: Vector,
                          layerAngles      :: Array{T,2},
                          layerMaterial    :: Composite,
                          diameter         :: Vector{Float64}) where T

        # Constraints on input values
        abstractSparConstraints(numberOfNodes, sectionNodes)
        compositeSparConstraints(layerTransitions, layerAngles)
        circularSparConstraints(diameter, sectionNodes)

        # Extra parameters
        numberOfElements, numberOfSections, sectionTransitions, nodes = extraParameterAbstractSpar(numberOfNodes, sectionNodes)
        layerAngles = extraParameterCompositeSpar(layerAngles, layerTransitions, numberOfElements)
        diameter = extraParameterCircularSpar(numberOfNodes, sectionTransitions, diameter)

        # Grouping inputs
        abstractInputs  = (numberOfNodes, numberOfElements, numberOfSections, sectionNodes, sectionTransitions, nodes)
        compositeInputs = (layerMaterial, layerAngles)
        circularInputs  = tuple(diameter)

        new(abstractInputs..., compositeInputs..., circularInputs...)
    end
end

# ======================== Rectangular Concrete Type ========================= #
struct RectangularSpar <: CompositeSpar
    # AbstractSpar parameters
    numberOfNodes      :: Int64
    numberOfElements   :: Int64
    numberOfSections   :: Int64
    sectionNodes       :: Matrix{Float64}
    sectionTransitions :: Matrix{Int64}
    nodes              :: Matrix{Float64}

    # CompositeSpar parameters
    layerMaterial  :: Composite
    layerAngles    :: Array{T,3} where T

    # RectangularSpar parameters
    webHeight :: Vector{Float64}
    capLength :: Vector{Float64}

    # ========================== Inner Constructor =========================== #
    function RectangularSpar(numberOfNodes    :: Int64,
                             sectionNodes     :: Matrix{Float64},
                             layerTransitions :: Vector,
                             layerAngles      :: Array{T,3},
                             layerMaterial    :: Composite,
                             webHeight        :: Vector{Float64},
                             capLength        :: Vector{Float64}) where T

        # Constraints on input values
        abstractSparConstraints(numberOfNodes, sectionNodes)
        compositeSparConstraints(layerTransitions, layerAngles)
        rectangularSparConstraints(webHeight, capLength, sectionNodes)

        # Extra parameters
        numberOfElements, numberOfSections, sectionTransitions, nodes = extraParameterAbstractSpar(numberOfNodes, sectionNodes)
        layerAngles = extraParameterCompositeSpar(layerAngles, layerTransitions, numberOfElements)
        webHeight, capLength = extraParameterRectangularSpar(numberOfNodes, sectionTransitions, webHeight, capLength)

        # Grouping inputs
        abstractInputs    = (numberOfNodes, numberOfElements, numberOfSections, sectionNodes, sectionTransitions, nodes)
        compositeInputs   = (layerMaterial, layerAngles)
        rectangularInputs = (webHeight, capLength)

        new(abstractInputs..., compositeInputs..., rectangularInputs...)
    end
end

# =========================== Import "Sub-Modules" =========================== #
include("methods/constructorMethods/sparConstructorConstraints.jl")
include("methods/constructorMethods/abstractSparConstructorMethods.jl")
include("methods/constructorMethods/compositeSparConstructorMethods.jl")
include("methods/constructorMethods/circularSparConstructorMethods.jl")
include("methods/constructorMethods/rectangularSparConstructorMethods.jl")
include("tests/sparTestsDefaults.jl")
include("methods/abstractSparMethods.jl")
include("tests/abstractSparMethodsTests.jl")
