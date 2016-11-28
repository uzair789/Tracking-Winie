function models = SDMtrain(mean_shape, annotations)

% CV Fall 2014 - Provided Code
% You need to implement the SDM training phase in this function, and
% produce tracking models for Winnie the Pooh
%
% Input:
%   mean_shape:    A provided 5x2 matrix indicating the x and y coordinates of 5 control points
%   annotations:   A ground truth annotation for training images. Each row has the format
%                  [frame_num nose_x nose_y left_eye_x left_eye_y right_eye_x right_eye_y right_ear_x right_ear_y left_ear_x left_ear_y]
% Output:
%   models:        The models that you will use in SDMtrack for tracking
tic;
models = [];
pertConfigs=[];
ann=annotations;  

 for u = 1:size(ann, 1)
       
      %Generating the perturbed Configurations 
       perturbedConfigurations = genPerturbedConfigurations(ann(u,:),mean_shape,300,[0.8,1,1.2]);
       pertConfigs = [pertConfigs perturbedConfigurations];
       
 end
 
 disp('perturbedConfigurations-->Done!');
 
 for i=1:5
 WW{i}=zeros(640,10);
 end
 
 for iteration = 1:5
     
       iteration
       
       displacementMatrix = genDisplacementMatrix(ann,pertConfigs);
       disp('displacementMatrix-->Done!'); 
       
       featureMatrix = genFeatureMatrix(ann,pertConfigs);
       disp('featureMatrix-->Done!'); 
       
       [updatedConfig,W] = learnMappingAndUpdateConfigurations(featureMatrix,displacementMatrix,pertConfigs);    
       
        phat1 = reshape(updatedConfig(1:2,:),30000,1);

        %reshaping phat to match the dimensionality of now_ann2(2:end) 
        phat2 = reshape(phat1,10,3000)';
        
        error(iteration) = sum(pdist2(ann(u,2:end),phat2))
     
        WW{iteration}=W;
        pertConfigs = updatedConfig;
        
 end
models=WW;
toc;
end










