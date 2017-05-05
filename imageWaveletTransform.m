function [ cA_1,cH_1,cV_1,cD_1 ] = imageWaveletTransform( A )
% [ cA_1,cH_1,cV_1,cD_1 ] = imageWaveletTransform( A )
% A : RGB Image. Ej: imread('Lenna.png');
% Devuelve:
% cA_1 : Principal wavelet coeficiente
% cH_1 : Horizontal
% cV_1 : Vertical
% cD_1 : Diagonal
sX = size(A);
cA_1 = zeros(sX);
cH_1 = zeros(sX);
cV_1 = zeros(sX);
cD_1 = zeros(sX);
tam2 = size(cA_1) ;
for i = 1:3
    [cA1,cH1,cV1,cD1] = dwt2(A(:,:,i),'db4');
    if (all([tam2(1) tam2(2)]== size(cA1)) == 0)
        cA_1 = zeros([size(cA1) 3]);
        cH_1 = zeros([size(cA1) 3]);
        cV_1 = zeros([size(cA1) 3]);
        cD_1 = zeros([size(cA1) 3]);
        tam2 = size(cA_1) ;
    end
    cA_1(:,:,i) = cA1;
    cH_1(:,:,i) = cH1;
    cV_1(:,:,i) = cV1;
    cD_1(:,:,i) = cD1;
end

end

