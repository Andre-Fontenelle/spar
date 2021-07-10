# ================================= Imports ================================== #
# using Pkg; Pkg.add(url="https://github.com/Andre-Fontenelle/miscellaneous_functions")
import MiscFunctions: colMat

# ============================ Default Spar Calls ============================ #
function defaultCircularSpar(numberOfSections)
    if numberOfSections == 1
        return defaultOneSectionCircularSpar()
    elseif numberOfSections == 2
        return defaultTwoSectionCircularSpar()
    end
end

function defaultRectangularSpar(numberOfSections)
    if numberOfSections == 1
        return defaultOneSectionRectangularSpar()
    elseif numberOfSections == 2
        return defaultTwoSectionRectangularSpar()
    end
end

# ================================= Circular ================================= #
function defaultOneSectionCircularSpar()
    # Global spar parameters (size of arrays might change)
    numberOfNodes    :: Int64            = 5
    sectionNodes     :: Array{Float64,2} = convert.(Float64, [0 0 0;0 1 0])
    layerTransitions :: Array{Int64,1}   = [3]
    layerAngles      :: Array{Any,2}     = [60 nothing;-60 0]
    layerMaterial    :: Composite        = CarbonFiber()

    # Specific spar parameters
    diameter         :: Float64          = 25.4e-3

    # Test dictionary
    initDict = Dict("numberOfNodes"    => numberOfNodes,
                    "sectionNodes"     => sectionNodes,
                    "layerTransitions" => layerTransitions,
                    "layerAngles"      => layerAngles,
                    "layerMaterial"    => layerMaterial,
                    "diameter"         => diameter)

    # Expected method results
    expectedDict = Dict("numberOfElements" => 4,
                        "numberOfSections" => 1,
                        "sectionLength"    => ones(1,1),
                        "totalLength"      => 1,
                        "cumulativeLength" => ones(1,1))

    # Spar object
    spar = CircularConstructor(numberOfNodes, sectionNodes, layerTransitions, layerAngles, layerMaterial, diameter)

    return spar, initDict, expectedDict
end

function defaultTwoSectionCircularSpar()
    # Global spar parameters (size of arrays might change)
    numberOfNodes    :: Int64            = 6
    sectionNodes     :: Array{Float64,2} = convert.(Float64, [0 0 0;0.05 0.5 0;0 1 0.05])
    layerTransitions :: Array{Int64,1}   = [2, 3, 5]
    layerAngles      :: Array{Any,2}     = [60 nothing nothing nothing;-60 0 0 0;0 90 90 90]
    layerMaterial    :: Composite        = CarbonFiber()

    # Specific spar parameters
    diameter         :: Float64          = 25.4e-3

    # Test dictionary
    initDict = Dict("numberOfNodes"    => numberOfNodes,
                    "sectionNodes"     => sectionNodes,
                    "layerTransitions" => layerTransitions,
                    "layerAngles"      => layerAngles,
                    "layerMaterial"    => layerMaterial,
                    "diameter"         => diameter)

    # Expected method results
    expectedDict = Dict("numberOfElements" => 5,
                        "numberOfSections" => 2,
                        "sectionLength"    => [0.5024937810560445 0.5049752469181039]',
                        "totalLength"      => 1.0074690279741483)

    # Spar object
    spar = CircularConstructor(numberOfNodes, sectionNodes, layerTransitions, layerAngles, layerMaterial, diameter)

    return spar, initDict, expectedDict
end

# =============================== Rectangular ================================ #
function defaultOneSectionRectangularSpar()
    # Global spar parameters (size of arrays might change)
    numberOfNodes    :: Int64            = 4
    sectionNodes     :: Array{Float64,2} = convert.(Float64, [0 0 0;0.3 1 0])
    layerTransitions :: Array{Int64,1}   = [2]
    layerAngles      :: Array{Any,3}     = repeat([30 30;-30 -30], 1, 1, 4)
    layerMaterial    :: Composite        = CarbonFiber()

    # Specific spar parameters
    webHeight        :: Array{Float64,1} = [20, 15] .* 1e-3
    capLength        :: Array{Float64,1} = [15, 10] .* 1e-3

    # Test dictionary
    initDict = Dict("numberOfNodes"    => numberOfNodes,
                    "sectionNodes"     => sectionNodes,
                    "layerTransitions" => layerTransitions,
                    "layerAngles"      => layerAngles,
                    "layerMaterial"    => layerMaterial,
                    "webHeight"        => webHeight,
                    "capLength"        => capLength)

    # Expected method results
    expectedDict = Dict("numberOfElements" => 3,
                        "numberOfSections" => 1,
                        "sectionLength"    => 1.044030650891055*ones(1,1),
                        "totalLength"      => 1.044030650891055)

    # Spar object
    spar = RectangularConstructor(numberOfNodes, sectionNodes, layerTransitions, layerAngles, layerMaterial, webHeight, capLength)

    return spar, initDict, expectedDict
end

function defaultTwoSectionRectangularSpar()
    # Global spar parameters (size of arrays might change)
    numberOfNodes    :: Int64            = 3
    sectionNodes     :: Array{Float64,2} = convert.(Float64, [0 0 0;0.05 0.5 0;0 1 0.05])
    layerTransitions :: Array{Int64,1}   = Array{Int64}(undef, 0)
    layerAngles      :: Array{Any,3}     = repeat(zeros(2,1), 1, 1, 4)
    layerMaterial    :: Composite        = CarbonFiber()

    # Specific spar parameters
    webHeight        :: Array{Float64,1} = [20, 18, 15] .* 1e-3
    capLength        :: Array{Float64,1} = [15, 10, 10] .* 1e-3

    # Test dictionary
    initDict = Dict("numberOfNodes"    => numberOfNodes,
                    "sectionNodes"     => sectionNodes,
                    "layerTransitions" => layerTransitions,
                    "layerAngles"      => layerAngles,
                    "layerMaterial"    => layerMaterial,
                    "webHeight"        => webHeight,
                    "capLength"        => capLength)

    # Expected method results
    expectedDict = Dict("numberOfElements" => 2,
                        "numberOfSections" => 2,
                        "sectionLength"    => [0.5024937810560445 0.5049752469181039]',
                        "totalLength"      => 1.0074690279741483)

    # Spar object
    spar = RectangularConstructor(numberOfNodes, sectionNodes, layerTransitions, layerAngles, layerMaterial, webHeight, capLength)

    return spar, initDict, expectedDict
end
