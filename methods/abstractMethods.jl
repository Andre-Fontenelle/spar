# ================================= Imports ================================== #
# using Pkg; Pkg.add(url="https://github.com/Andre-Fontenelle/miscellaneous_functions")
import MiscFunctions: absVector

# ================================= Methods ================================== #
function getNumberOfElements(Spar::AbstractSpar)
    return Spar.numberOfNodes - 1; end

function getNumberOfSections(Spar::AbstractSpar)
    return size(Spar.sectionNodes, 1) - 1; end

function getSectionLength(Spar::AbstractSpar)
    sectionVector = diff(Spar.sectionNodes, dims=1)
    return absVector(sectionVector, 2); end

function getTotalLength(Spar::AbstractSpar)
    return sum(getSectionLength(Spar), dims=1)[1]; end

function getCumulativeLength(Spar::AbstractSpar)
    return cumsum(getSectionLength(Spar), dims=1); end
