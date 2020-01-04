function [featuresCell groupCell] = computeFeaturesGlobal( images, sPlabels, siftCentroidsCell, avgClusterHist, nImages, groundTruths )
%Compute features, and ground truth if available, of superpixels for all images

featuresCell = cell( 1,nImages );
computeGT = nargin>5;              %represents if the ground truths are available to be distributed onto all superpixels
if computeGT                       %seperate for loops needed because of parfor with nargin...
    groupCell=cell( 1,nImages );
    parfor i = 1:nImages
        sPlabel = sPlabels{i};
        %hailee
        if(size(sPlabel,3)>2)
            sPlabel=rgb2gray(sPlabel);
            imagesc(sPlabel);
            colormap(gray);
            %pause(2);
        end
        I = images{i};
        if(size(I,3)>2)
            I=rgb2gray(I);
            imagesc(I);
            colormap(gray);
            %pause(2);
        end
        Igt = logical(groundTruths{i});
        Igt = (Igt);
        %calculate features and ground truth of superpixels in image
        [featuresCell{i} groupCell{i}] = computeFeatures( I, sPlabel, siftCentroidsCell{i}, avgClusterHist, Igt ); 
    end
else
    parfor i = 1:nImages
        I = images{i};
        sPlabel = sPlabels{i};   
        if(size(I,3)>2)
            I=rgb2gray(I);
            imagesc(I);
            colormap(gray);
            %pause(2);
        end
        if(size(sPlabel,3)>2)
            sPlabel=rgb2gray(sPlabel);
            imagesc(sPlabel);
            colormap(gray);
            %pause(2);
        end
        %calculate features of superpixels in image
        featuresCell{i} = computeFeatures( I, sPlabel, siftCentroidsCell{i}, avgClusterHist );

    end
end

