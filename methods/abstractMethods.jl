# ================================= Imports ================================== #
# using Pkg; Pkg.add(url="https://github.com/Andre-Fontenelle/miscellaneous_functions")


# ================================= Methods ================================== #
function getNumberOfElements(Spar::AbstractSpar) :: Int64
    return Spar.numberOfNodes - 1; end

function getNumberOfSections(Spar::AbstractSpar) :: Int64
    return size(Spar.sectionNodes, 1) - 1; end

function getSectionLength(Spar::AbstractSpar) :: Matrix{Float64}
    sectionVector = diff(Spar.sectionNodes, dims=1)
    return absVector(sectionVector, 2); end

function getTotalLength(Spar::AbstractSpar) :: Float64
    return sum(getSectionLength(Spar), dims=1)[1]; end

function getCumulativeLength(Spar::AbstractSpar) :: Matrix{Float64}
    return cumsum(getSectionLength(Spar), dims=1); end

function getSectionTransitions(Spar::AbstractSpar) :: Matrix{Int64}
    SectionTransitions = [1; round.(Int64, Spar.numberOfNodes * getCumulativeLength(Spar) / getTotalLength(Spar))]
    @assert SectionTransitions == colMat(unique(SectionTransitions))
    return SectionTransitions; end

function getNumberOfNodesInSections(Spar::AbstractSpar) :: Matrix{Int64}
    return diff(getSectionTransitions(Spar), dims=1) .+ 1; end

function getSectionIndex(Spar::AbstractSpar) :: Array
    sectionTransitions = getSectionTransitions(Spar)
    return [sectionTransitions[i]:sectionTransitions[i+1] for i in 1:getNumberOfSections(Spar)]; end

function getNodes(Spar::AbstractSpar) :: Matrix{Float64}
    numberOfNodesInSections = getNumberOfNodesInSections(Spar)
    sectionIndex = getSectionIndex(Spar)
    nodes = Matrix{Float64}(undef,Spar.numberOfNodes,3)
    @inbounds @simd for i in 1:getNumberOfSections(Spar)
        nodes[sectionIndex[i],:] = linspace(Spar.sectionNodes[i,:],Spar.sectionNodes[i+1,:],numberOfNodesInSections[i])
    end
    return nodes; end
