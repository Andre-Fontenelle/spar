# ================================== Tests =================================== #
@testset "Circular Spar Initialization" begin
    @testset "$numberOfSections Section(s)" for numberOfSections = 1:2
        # Get default test spar
        spar, initDict = defaultCircularSpar(numberOfSections)

        # Tests
        @test spar.numberOfNodes    == initDict["numberOfNodes"]
        @test spar.sectionNodes     == initDict["sectionNodes"]
        @test spar.layerTransitions == initDict["layerTransitions"]
        @test spar.layerAngles      == initDict["layerAngles"]
        @test spar.layerMaterial    == initDict["layerMaterial"]
        @test spar.diameter         == initDict["diameter"]
    end
end

@testset "Rectangular Spar Initialization" begin
    @testset "$numberOfSections Section(s)" for numberOfSections = 1:2
        # Get default test spar
        spar, initDict = defaultRectangularSpar(numberOfSections)

        # Tests
        @test spar.numberOfNodes    == initDict["numberOfNodes"]
        @test spar.sectionNodes     == initDict["sectionNodes"]
        @test spar.layerTransitions == initDict["layerTransitions"]
        @test spar.layerAngles      == initDict["layerAngles"]
        @test spar.layerMaterial    == initDict["layerMaterial"]
        @test spar.webHeight        == initDict["webHeight"]
        @test spar.capLength        == initDict["capLength"]
    end
end
