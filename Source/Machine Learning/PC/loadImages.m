function [ images , groundTruths, D , nImages] = loadImages( imagePath, gtPath )

D = dir([imagePath filesep '*.png']);
nImages = numel(D);
images = cell( 1,nImages );
groundTruths = cell( 1,nImages );

for i = 1:nImages
    img = imread( [imagePath filesep D(i).name] );
    if(size(img,3)>2)
        img=rgb2gray(img);
        imagesc(img);
        colormap(gray);
        %pause(2);
    end
    images{i} = img
    groundTruths{i} = logical( imread( [gtPath filesep D(i).name] ) );
end