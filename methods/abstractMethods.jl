# ================================= Imports ================================== #


# ================================= Methods ================================== #
function getNumberOfElements(Spar::AbstractSpar)
    return Spar.numberOfNodes - 1; end

function getNumberOfSections(Spar::AbstractSpar)
    return size(Spar.sectionNodes, 1) - 1; end

function getSectionLength(Spar::AbstractSpar)
    sectionVector = diff(sparObj.sectionPoints, dims=1)
    return sqrt.(sum(sectionVector.^2, dims=2)); end

# ================================== Tests =================================== #
function abstractTests(Spar, expectedDict)
    @test getNumberOfElements(Spar) == expectedDict["numberOfElements"]
    @test getNumberOfSections(Spar) == expectedDict["numberOfSections"]
end

@testset "Circular Spar Abstract Methods" begin
    @testset "$numberOfSections Section(s)" for numberOfSections = 1:2
        # Get default test spar
        Spar, _, expectedDict = defaultCircularSpar(numberOfSections)

        # Tests
        abstractTests(Spar, expectedDict)
    end
end

@testset "Rectangular Spar Abstract Methods" begin
    @testset "$numberOfSections Section(s)" for numberOfSections = 1:2
        # Get default test spar
        Spar, _, expectedDict = defaultRectangularSpar(numberOfSections)

        # Tests
        abstractTests(Spar, expectedDict)
    end
end
