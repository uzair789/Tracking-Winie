function [updateConfigs,W] = learnMappingAndUpdateConfigurations(featureMatrix,displacementMatrix,pertConfigs)

    addpaths;
    
    W = learnLS(featureMatrix,displacementMatrix);
    
    updatedDisplacements = featureMatrix*W;
    
    singleRow = reshape(updatedDisplacements',1,30000);
    
    updates = reshape(singleRow,2,15000);
    
    updateConfigs = pertConfigs;
    
    updateConfigs(1:2,:) = pertConfigs(1:2,:) + updates;
    
end