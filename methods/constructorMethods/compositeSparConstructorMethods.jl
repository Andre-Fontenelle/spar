# =============== Additional parameters for inner constructor ================ #
function extraParameterCompositeSpar(layerAngles, layerTransitions, numberOfElements)
    return getLayerAngles(layerAngles, layerTransitions, numberOfElements)
end

# ================================= Methods ================================== #
function getLayerAngles(layerAngles, layerTransitions, numberOfElements)

    newLayerAngles = Array{Any}(undef, size(layerAngles,1), numberOfElements, size(layerAngles,3))

    layerTransitions = [1, layerTransitions...]

    for i in 1:numberOfElements
        idx = findmax(layerTransitions[layerTransitions .<= i]) |> minimum
        newLayerAngles[:,i,:] .= layerAngles[:,idx,:]
    end
    return newLayerAngles
end
