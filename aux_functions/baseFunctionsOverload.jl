function Base.reshape(num::Number, dims::Union{Int,Colon}...)
    reshape([num], dims...); end
