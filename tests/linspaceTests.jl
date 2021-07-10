using Test

# ================================== Tests =================================== #
@testset "Linspace Tests" begin
    @testset "Integer Inputs" begin
        @test linspace(0,1,3) == [0, 0.5, 1]
        @test linspace([0 0 0],[0 1 4],3) == [0 0 0;0 0.5 2;0 1 4]
        @test linspace([0,0,0],[0 1 4],3) == [0 0 0;0 0.5 2;0 1 4]
        @test linspace([0 0 0],[0,1,4],3) == [0 0 0;0 0.5 2;0 1 4]
    end
    @testset "Float Inputs" begin
        @test linspace(0.0,1.0,3) == [0, 0.5, 1]
        @test linspace([0.0 0.0 0.0],[0.0 1.0 4.0],3) == [0 0 0;0 0.5 2;0 1 4]
        @test linspace([0.0,0.0,0.0],[0.0 1.0 4.0],3) == [0 0 0;0 0.5 2;0 1 4]
        @test linspace([0.0 0.0 0.0],[0.0,1.0,4.0],3) == [0 0 0;0 0.5 2;0 1 4]
    end
    @testset "Mixed Integer and Float Inputs" begin
        @test linspace(0.0,1,3) == [0, 0.5, 1]
        @test linspace([0.0 0 0.0],[0 1.0 4.0],3) == [0 0 0;0 0.5 2;0 1 4]
        @test linspace([0.0,0.0,0],[0.0 1.0 4],3) == [0 0 0;0 0.5 2;0 1 4]
        @test linspace([0 0.0 0.0],[0.0,1,4.0],3) == [0 0 0;0 0.5 2;0 1 4]
    end
    @testset "Complex Inputs" begin
        @test linspace(0+0im,1+2im,3) == [0+0im, 0.5+1im, 1+2im]
        @test linspace(0+1im,1,3) == [0+1im, 0.5+0.5im, 1+0im]
        @test linspace([0 0+1im],[1+1im 1+2im],3) == [0 0+1im;0.5+0.5im 0.5+1.5im ;1+1im 1+2im]
    end
    @testset "Exceptions" begin
        @test_throws DimensionMismatch linspace([0 0],[2 2 2],4)
        @test_throws DimensionMismatch linspace([0 9.0 7 3.4],[1.2 2.2 9],4)
        @test_throws FewPoints linspace([0 0],[1 1],1)
        @test_throws FewPoints linspace([0 0],[1 1],-4)
    end
end
