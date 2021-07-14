# =============== Additional parameters for inner constructor ================ #
function extraParameterRectangularSpar(numberOfNodes, sectionTransitions, webHeight, capLength)
    webHeight = interpAtElements(numberOfNodes, sectionTransitions, webHeight)
    capLength = interpAtElements(numberOfNodes, sectionTransitions, capLength)
    return (webHeight, capLength)
end
