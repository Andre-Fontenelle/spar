# include("../auxiliary_functions/linspace.jl")



function defaultCircularSpar(numberOfSections)
    if numberOfSections == 1
        return defaultOneSectionCircularSpar()
    elseif numberOfSections == 2
        return defaultTwoSectionCircularSpar()
    end
end

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
    testDict = Dict("numberOfNodes"    => numberOfNodes,
                    "sectionNodes"     => sectionNodes,
                    "layerTransitions" => layerTransitions,
                    "layerAngles"      => layerAngles,
                    "layerMaterial"    => layerMaterial,
                    "diameter"         => diameter)

    # Spar object
    spar = CircularSpar(numberOfNodes, sectionNodes, layerTransitions, layerAngles, layerMaterial, diameter)

    return spar, testDict
end

function defaultTwoSectionCircularSpar()

end
