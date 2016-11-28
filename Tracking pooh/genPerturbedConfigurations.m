function perturbedConfigurations = genPerturbedConfigurations(singleFrameAnnotation,mean_shape,n,scalesToPerturb)
    perturbedConfigurations = [];
    % Reshape annotations so that it is 5-by-2, ann(u, 1) is frame number
	now_ann = reshape(singleFrameAnnotation(2:end), 2, 5)';
    % Compute scale difference between mean_shape and annotation
	scale = findscale(now_ann, mean_shape);
        
    %scale the mean
    mean_shape_scaled = mean_shape ./ scale;
    %find the center of the scaled mean and the annotations
    center_ann = sum(now_ann)./5;
    center_mean = sum(mean_shape_scaled)./5;
        
    %find the difference in x and y between center_ann and center_mean
    %to shift the mean 
    dist = center_ann - center_mean;
       
    %shift the mean by this distance to initialize it at the center
    mean_moved_1(:,1) = mean_shape_scaled(:,1) + dist(1);
    mean_moved_1(:,2) = mean_shape_scaled(:,2) + dist(2);
        
    r = randn(n,2)*10;
        
    for i = 1 : n
      if i <=100
          scale1 = scalesToPerturb(1);%0.8;
      elseif i<=200
          scale1 = scalesToPerturb(2);%1;
      else 
          scale1 = scalesToPerturb(3);%1.2;
      end
            
      mean_scale_2 = mean_moved_1/scale1;
      dist2 = center_ann-mean(mean_scale_2);
      mean_moved_2(:,1) = mean_scale_2(:,1)+dist2(1);
      mean_moved_2(:,2) = mean_scale_2(:,2)+dist2(2);
      mean_perturbed_x = mean_moved_2(:,1) + r(i,1) ;
      mean_perturbed_y = mean_moved_2(:,2) + r(i,2) ;
      fc = [mean_perturbed_x';mean_perturbed_y';[7 4 4 10 10]/(scale1*scale);[0 0 0 0 0]];
      perturbedConfigurations = [perturbedConfigurations fc];
             
      end
end