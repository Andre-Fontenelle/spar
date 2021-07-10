function absVector(matrixInput, dims=2)
    return sqrt.(sum(matrixInput.^2, dims=dims))
end
