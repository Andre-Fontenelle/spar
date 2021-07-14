# =============== Additional parameters for inner constructor ================ #
function extraParameterAbstractSpar(numberOfNodes, sectionNodes)
    numberOfElements = numberOfNodes - 1
    numberOfSections = size(sectionNodes, 1) - 1
    sectionTransitions = getSectionTransitions(sectionNodes, numberOfNodes)
    nodes = getNodes(sectionNodes, numberOfNodes, numberOfSections)
    (numberOfElements, numberOfSections, sectionTransitions, nodes); end

# ================================= Methods ================================== #
function getNodes(sectionNodes, numberOfNodes, numberOfSections) :: Matrix{Float64}
    # Get the nodes indexes for each individual section
    sectionTransitions = getSectionTransitions(sectionNodes, numberOfNodes)
    sectionIndex = [sectionTransitions[i]:sectionTransitions[i+1] for i in 1:numberOfSections]

    nodes = Matrix{Float64}(undef,numberOfNodes,3)
    @inbounds @simd for i in 1:numberOfSections
        nodes[sectionIndex[i],:] = linspace(sectionNodes[i,:],sectionNodes[i+1,:],length(sectionIndex[i]))
    end
    return nodes; end

function getSectionTransitions(sectionNodes, numberOfNodes) :: Matrix{Int64}
    normalizedSectionLength = getNormalizedSectionLength(sectionNodes)

    # Get the node indexes where a section transition occurs
    sectionTransitions = [1; round.(Int64, numberOfNodes * normalizedSectionLength)]
    isunique(sectionTransitions) || throw(error("Section transitions are not unique. Consider increasing numberOfNodes"))
    return sectionTransitions; end

function getNormalizedSectionLength(sectionNodes)
    sectionLengthSquared = diff(sectionNodes, dims=1) |> x -> sum(x.^2,dims=2)
    return cumsum(sectionLengthSquared, dims=1) |> x -> x/x[end]; end
