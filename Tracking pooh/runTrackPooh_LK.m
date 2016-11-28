% CV Fall 2014 - Provided Code
% Demo car tracker with Lucas-Kanade
%
% Created by Wen-Sheng Chu (Oct-20-2011)
addpaths; 

% init
load('data/pooh/rects_frm992'); % load sequence
rect = [rect_lear;rect_leye;rect_nose;rect_rear;rect_reye];


%initializing the path cell
for i=1:2009
    path{i,1}=0;
end

%Create the sequence
k=992;
for iFrm = 1:2009
    if iFrm<=8
           path{iFrm,1} = ['/data/pooh/testing/image-0' num2str(k) '.jpg'];
    else
           path{iFrm,1} = ['/data/pooh/testing/image-' num2str(k) '.jpg'];
    end
    sequence(:,:,:,iFrm) = imread(path{iFrm,1});  
    k=k+1
end
disp('end of sequence')


vidname = 'pooh_lk.avi';
vidout  = VideoWriter(vidname);
vidout.FrameRate = 10;
open(vidout);

%start tracking
for iFrm=2:2009
         
   	It    = sequence(:,:,:,iFrm-1);   % get previous frame
    It1   = sequence(:,:,:,iFrm);     % get current frame
    for j = 1:5
       [u,v] = LucasKanade(It,It1,rect(j,:)); % compute the displacement using LK
       rect(j,:)  = rect(j,:) + [u,v,u,v]; 
    end% move the car rectangle
        
hf = figure(1); clf; hold on;
imshow(sequence(:,:,:,iFrm));
for j = 1:size(rect,1)
drawRect([rect(j,1:2),rect(j,3:4)-rect(j,1:2)],'r',3);
text(80,50,['frame ',num2str(iFrm)],'color','y','fontsize',30);
hold off;
title('Car tracker with Lucas-Kanade Tracker');
drawnow;
end
  frm = getframe;     
  writeVideo(vidout, imresize(frm.cdata, 0.5));
end

close(vidout);
close(1);
fprintf('Video saved to %s\n', vidname);
