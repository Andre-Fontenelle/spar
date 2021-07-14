# ================================= Imports ================================== #
# using Pkg; Pkg.add(url="https://github.com/Andre-Fontenelle/miscellaneous_functions")

# ================================= Methods ================================== #
interpAtNodes(numberOfNodes, sectionTransitions, property) = interp1(sectionTransitions, property, 1:numberOfNodes )

function interpAtElements(numberOfNodes, sectionTransitions, property)
    # This ensures that spars with only 2 nodes work properly
    elementRange = numberOfNodes == 2 ? 1 : ((1:numberOfNodes-1)+(2:numberOfNodes))/2;
    if length(property) == length(sectionTransitions)
        return interp1(sectionTransitions, property, elementRange)
    else
        return interp0(sectionTransitions[1:end-1], property, elementRange)
    end
end

area(Spar::CircularSpar) = π * Spar.diameter.^2 / 4
area(Spar::RectangularSpar) = Spar.webHeight .* Spar.capLength

