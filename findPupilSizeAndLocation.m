function [ row, column, radius ] = findPupilSizeAndLocation( img )
%FINDPUPILCENTER Summary of this function goes here
%[ row, column, radius ] = findPupilSizeAndLocation( img )
%   Detailed explanation goes here
PUPIL_THREASHOLD = .25;

img_hsv = rgb2hsv(img);
%imtool(img_hsv);
value = img_hsv(:,:,3);


mask = zeros(size(img,1),size(img,2));

mask(find(value<PUPIL_THREASHOLD)) = 1;


mask = imopen(mask,strel('square',7));
mask = clean_Pupil(mask);
%imtool(mask);
[r c] = find(mask==1);

centroidInRowDirection = ones(1,length(r))*r / length(r);
centroidInColDirection = ones(1,length(c))*c / length(c);

row = centroidInRowDirection;
column = centroidInColDirection;
max_r = max(r);
min_r = min(r);
max_c = max(c);
min_c = min(c);

radius_r = (max_r-min_r)/2;
radius_c =(max_c - min_c) / 2;

radius =( radius_r + radius_c )/ 2;



end
