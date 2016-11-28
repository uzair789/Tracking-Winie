function dp = genDisplacementMatrix(ann,pertConfigs)

dp=[];

displacementMatrix=zeros(300,10);

phat = reshape(pertConfigs(1:2,:),30000,1);

%reshaping phat to match the dimensionality of now_ann2(2:end) 
pphat = reshape(phat,10,3000)';

j=0;

for u = 1:size(ann,1)

    now_ann2 = ann(u,2:end);

    block1 = pphat(1+j:300+j,:);
    
        for i = 1 : size(block1,1)
        
            displacementMatrix(i,:) = now_ann2 - block1(i,:);
        
        end
        
    dp = [dp;displacementMatrix];

    j=j+300;

end

end