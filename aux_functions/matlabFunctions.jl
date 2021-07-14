import Interpolations: LinearInterpolation
# ================================ linspace ================================= #
linspace(start::Array{T}, finish::Array{S}, numberOfPoints::Int) where {T <: Number, S <: Number} = linspace(promote(start, finish)..., numberOfPoints)
linspace(start::Array{Int64}, finish::Array{Int64}, numberOfPoints::Int) = linspace(Float64.(start), Float64.(finish), numberOfPoints)
linspace(start::Array{Complex{Int64}}, finish::Array{Complex{Int64}}, numberOfPoints::Int) = linspace(Complex{Float64}.(start), Complex{Float64}.(finish), numberOfPoints)

function linspace(start::Array{T}, finish::Array{T}, numberOfPoints::Int) where T <: Number
    assertArray(start, finish, numberOfPoints)
    arrayLength = length(start)
    result = Matrix{T}(undef,numberOfPoints,arrayLength)
    @inbounds @simd for i in 1:arrayLength
        result[:,i] = linspace(start[i], finish[i], numberOfPoints)
    end
    return result; end

function linspace(start::Real, finish::Real, numberOfPoints::Int) :: Array{Float64}
    assertEnoughPoints(numberOfPoints)
    return range(start, stop=finish, length=numberOfPoints) |> collect; end

function linspace(start::Number, finish::Number, numberOfPoints::Int)
    assertEnoughPoints(numberOfPoints)
    realPart = linspace(real(start), real(finish), numberOfPoints)
    imagPart = linspace(imag(start), imag(finish), numberOfPoints)
    return realPart + 1im * imagPart; end

# ================================ Exceptions ================================ #
struct FewPoints <: Exception
    msg::String; end

@inline function assertArray(start, finish, numberOfPoints)
    assertEnoughPoints(numberOfPoints)
    (length(start) == length(finish) ||
    throw(DimensionMismatch("argument dimensions must match: length of start is $(length(start)), length of finish is $(length(finish))")))
end

@inline function assertEnoughPoints(numberOfPoints)
    (numberOfPoints > 1 ||
    throw(FewPoints("numberOfPoints is $numberOfPoints < 2")))
end

# ================================== Tests =================================== #
include("../tests/linspaceTests.jl")

# ================================= interp1 ================================== #
interp1(x::Vector, y::Vector, xq) = LinearInterpolation(x,y)(xq)
interp1(x,y,xq) = interp1( ((x,y,xq) .|> vec)...)

# ================================= interp0 ================================== #
# Defaults to 0 or max(y) if xq outside of x
function interp0(x::Vector, y::Vector, xq)
    numberOfQueryPoints = length(xq)
    yq = Array{Float64}(undef,numberOfQueryPoints)
    @inbounds @simd for i = 1:numberOfQueryPoints
        idx = x .<= xq[i] |> idx -> idx[idx != false]
        yq[i] = y[idx][end]
    end
    return yq
end
interp0(x,y,xq) = interp0( ((x,y,xq) .|> vec)...)

# ================================= isunique ================================= #
isunique(x::Vector) = unique(x) == x
isunique(x::Matrix) = all([isunique(x[i,:]) for i in 1:size(x,1)]) && all([isunique(x[:,i]) for i in 1:size(x,2)])
isunique(::Number) = true
