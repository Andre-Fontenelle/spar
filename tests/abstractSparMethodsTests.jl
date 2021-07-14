# ================================== Tests =================================== #
function abstractTests(Spar, expectedDict)
    @test Spar.sectionTransitions == expectedDict["sectionTransitions"]
    @test Spar.nodes               ≈ expectedDict["nodes"]
end

function circularTests(Spar, expectedDict)
end

function rectangularTests(Spar, expectedDict)
end

@testset "Circular Spar Methods" begin
    @testset "$numberOfSections Section(s)" for numberOfSections = 1:2
        # Get default test spar
        Spar, expectedDict = defaultCircularSpar(numberOfSections)

        # Tests
        abstractTests(Spar, expectedDict)
        circularTests(Spar, expectedDict)
    end
end

@testset "Rectangular Spar Methods" begin
    @testset "$numberOfSections Section(s)" for numberOfSections = 1:2
        # Get default test spar
        Spar, expectedDict = defaultRectangularSpar(numberOfSections)

        # Tests
        abstractTests(Spar, expectedDict)
        rectangularTests(Spar, expectedDict)
    end
end
