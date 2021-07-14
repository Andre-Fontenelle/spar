# ================================= Imports ================================== #

# =========================== Parent Abstract Type =========================== #
abstract type AbstractElement end

# ======================== Beam Element Concrete Type ======================== #
struct Beam <: AbstractElement
    # Global element parameter
    nodes             :: Matrix{Float64}
    K                 :: Matrix{Float64}
    localConnectivity :: Matrix{Float64}
    nodesDoF          :: Vector
end

# Constructors
# function Beam(Spar::AbstractSpar, elementIndex::Int)
function Beam()
    L = 1
    EA = 1
    EIy = 1
    EIz = 1
    GJ = 1
    L = 1

    K = beam_K(L, EA, EIy, EIz, GJ)
    localConnectivity = [1 2]
    nodesDoF = [1:6, 1:6]
    nodes = [0 0 0;0 1 0]

    Beam(nodes, K, localConnectivity, nodesDoF)

end

function beam_K(L, EA, EIy, EIz, GJ)
    (EA_L, EIy_L, EIy_L2, EIy_L3, EIz_L, EIz_L2, EIz_L3, GJ_L) = (EA/L, EIy/L, EIy/L^2, EIy/L^3, EIz/L, EIz/L^2, EIz/L^3, GJ/L)
    # x1    y1        z1         θx1   θy1       θz1       x2    y2         z2         θx2    θy2       θz2
    [ EA_L  0         0          0     0         0         -EA_L 0          0          0      0         0 ;         # x1
      0     12*EIz_L3 0          0     0         6*EIz_L2  0     -12*EIz_L3 0          0      0         6*EIz_L2;   # y1
      0     0         12*EIy_L3  0     -6*EIy_L2 0         0     0          -12*EIy_L3 0      -6*EIy_L2 0;          # z1
      0     0         0          GJ_L  0         0         0     0          0          -GJ_L  0         0;          # θx1
      0     0         -6*EIy_L2  0     4*EIy_L   0         0     0          6*EIy_L2   0      2*EIy_L   0;          # θy1
      0     6*EIz_L2  0          0     0         4*EIz_L   0     -6*EIz_L2  0          0      0         2*EIz_L;    # θz1
      -EA_L 0         0          0     0         0         EA_L  0          0          0      0         0;          # x2
      0    -12*EIz_L3 0          0     0         -6*EIz_L2 0     12*EIz_L3  0          0      0         -6*EIz_L2;  # y2
      0     0         -12*EIy_L3 0     6*EIy_L2  0         0     0          12*EIy_L3  0      6*EIy_L2  0;          # z2
      0     0         0          -GJ_L 0         0         0     0          0          GJ_L   0        0;           # θx2
      0     0         -6*EIy_L2  0     2*EIy_L   0         0     0          6*EIy_L2   0      4*EIy_L   0;          # θy2
      0     6*EIz_L2  0          0     0         2*EIz_L   0     -6*EIz_L2  0          0      0         4*EIz_L];   # θz2
  end

applyBoundaryConditions(K, removedDoF) = K[1:end .∉ [removedDoF], 1:end .∉ [removedDoF]]
