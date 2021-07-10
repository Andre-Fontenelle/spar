# ================================== Tests =================================== #
function abstractTests(Spar, expectedDict)
    @test getNumberOfElements(Spar) == expectedDict["numberOfElements"]
    @test getNumberOfSections(Spar) == expectedDict["numberOfSections"]
    @test getSectionLength(Spar)     ≈ expectedDict["sectionLength"]
    @test getTotalLength(Spar)       ≈ expectedDict["totalLength"]
    @test getCumulativeLength(Spar)  ≈ expectedDict["cumulativeLength"]
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
