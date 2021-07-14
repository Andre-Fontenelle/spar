import Base: reshape, convert, promote_rule

function reshape(num::Number, dims::Union{Int,Colon}...)
    reshape([num], dims...); end

# convert(::Type{Array{T,3}}, x::Array{T,2}) where T = reshape(x, size(x)..., 1)
# promote_rule(::Type{Array{T,2}}, ::Type{Array{T,3}}) where T = Array{T,3}
