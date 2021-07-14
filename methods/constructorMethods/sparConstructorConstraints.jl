# =================== Constraints on Abstract Spar Inputs ==================== #
function abstractSparConstraints(numberOfNodes, sectionNodes)
    size(sectionNodes, 1) > 1 || throw(error("Spar must have at least 2 sectionNodes"))
    numberOfNodes >= size(sectionNodes, 1) || throw(error("Too few numberOfNodes ($numberOfNodes)"))
end

function compositeSparConstraints(layerTransitions, layerAngles)
    length(layerTransitions) == size(layerAngles, 2) - 1 || throw(error("Number of layers transitions doesn't match number of layer angles"))
end

function circularSparConstraints(diameter, sectionNodes)
    any(length(diameter) .== [size(sectionNodes,1), size(sectionNodes,1)-1]) || throw(error("Diameter must have length equal to numberOfSections or numberOfSections+1"))
end

function rectangularSparConstraints(webHeight, capLength, sectionNodes)
    length(webHeight) == size(sectionNodes, 1) || throw(error("Length of webHeight doesn't match numberOfSections+1"))
    length(webHeight) == length(capLength) || throw(error("Length of capLength doesn't match length of webHeight"))
end
