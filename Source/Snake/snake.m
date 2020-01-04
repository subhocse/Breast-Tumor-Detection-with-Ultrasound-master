close all
clear all
clc

function snake(image)
% Get the image
[I,map] = imread(image);
Ioriginal = I;

% Apply Median Filter
I = medfilt2(I, [5, 5]);

% Perform Anisotropic Diffusion
I = anisotropic_diffusion(0.01,0.002);
disp(' Press any key to continue');
pause();

% Compute its edge map
[Ex,Ey] = gradient(I);
f = sqrt(Ex.*Ex+Ey.*Ey);

% Compute the GVF of the edge map f
disp(' Compute GVF ...');
[u,v] = GVF(f, 0.02, 100);
% [u,v] = GGVF(f,0.002,100);
disp(' Nomalizing the GVF external force ...');
mag = sqrt(u.*u+v.*v);
px = u./(mag+1e-10); py = v./(mag+1e-10); 
% px = u; 
% py = v;   

% display the results
figure(2); 
subplot(221); imdisp(I); title('test image');
subplot(222); imdisp(f); title('edge map');
[fx,fy] = gradient(f); 
subplot(223); quiver(fx,fy); 
axis off; axis equal; axis 'ij';     % fix the axis 
title('edge map gradient');
subplot(224); quiver(px,py);
axis off; axis equal; axis 'ij';     % fix the axis 
title('normalized GVF field');

% snake deformation
disp(' Press any key to start GVF snake deformation');
pause;
figure(2); subplot(221); cla;%cla= clear current axes
% colormap(gray(64)); image(((1-f)+1)*40); 
imshow(I);

axis('equal', 'off');
[x,y] = initialize(I,1);
display(x,y,'r') 

for i=1:25,
    [x,y] = deform(x,y,0.01,0,1,0.5,px,py,5);
    [x,y] = interpolate(x,y,2,0.5);
    display(x,y,'r') 
    title(['Deformation in progress,  iter = ' num2str(i*5)])
    pause(1);
end

disp(' Press any key to display the final result');
pause;
cla;
%colormap(gray(64)); image(((1-f)+1)*40);
imshow(Ioriginal);
axis('equal', 'off');
display(x,y,'r') 
title(['Final result,  iter = ' num2str(i*5)]);
