function [ A0 ] = imageWaveletAntiTransform( cA_1,cH_1,cV_1,cD_1,sizeX,sizeY )
% [ A0 ] = imageWaveletAntiTransform( cA_1,cH_1,cV_1,cD_1 )
% cA_1 : Principal wavelet coeficiente
% cH_1 : Horizontal
% cV_1 : Vertical
% cD_1 : Diagonal
% sizeX : Pixels en eje X
% sizeY : Pixels en eje Y
% Devuelve:
% A0 : RGB Image.
A0_1 = idwt2(cA_1(:,:,1),cH_1(:,:,1),cV_1(:,:,1),cD_1(:,:,1),'db4',[sizeX sizeY]);
A0_2 = idwt2(cA_1(:,:,2),cH_1(:,:,2),cV_1(:,:,2),cD_1(:,:,2),'db4',[sizeX sizeY]);
A0_3 = idwt2(cA_1(:,:,3),cH_1(:,:,3),cV_1(:,:,3),cD_1(:,:,3),'db4',[sizeX sizeY]);
A0 = zeros([size(A0_1) 3]);
A0(:,:,1) = A0_1;
A0(:,:,2) = A0_2;
A0(:,:,3) = A0_3;

end

