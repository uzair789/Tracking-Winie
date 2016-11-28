
function fp = genFeatureMatrix(ann,pertConfigs)  
  
    fp = [];
    e=[];
    
    addpaths;
       
    poohpath = 'data/pooh';
    
       cols = repmat(1500,[1 10]);
       
    block2 = mat2cell(pertConfigs,4,cols);
    
    for u = 1:size(ann,1)
        
        I = imread(fullfile(poohpath,'training',sprintf('image-%04d.jpg', ann(u,1))));
        d = siftwrapper(I, block2{u});
        e=[e d];
        featureMatrix=reshape(d,640,300);
        fp = [fp ;featureMatrix'];
        
    end
      
 end