# ================================= Imports ================================== #

# =========================== Parent Abstract Type =========================== #
abstract type AbstractElement end

# ======================== Beam Element Concrete Type ======================== #
struct Beam <: AbstractElement
    # Global element parameter
    nodes             :: Array{Float64,2}
    K                 :: Array{Float64,2}
    localConnectivity :: Array{Float64,2}
    nodesDoF          :: Vector{Vector{Int64}}
end

# Constructors
function Beam(Spar::AbstractSpar, elementIndex::Int)
    E = 1
    L = 1

end
