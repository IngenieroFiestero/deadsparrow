A = imread('Lenna.png');

tam = size(A);
redund = 12;
black = zeros(redund);
white = ones(redund);
tile = [white black; black white];
p = ceil(tam(1)/(redund*2));
q = ceil(tam(2)/(redund*2));
I = repmat(tile,p,q);
I = I(1:tam(1),1:tam(2))*32;
ad = zeros([size(I) 3]);
ad(:,:,1)=I;
ad(:,:,2)=I;
ad(:,:,3)=I;

% Añadir el patron en el nivel 3
imageAndPattern = pattern2waveletImage( ad,A,3 );
imshow(imageAndPattern)

[cA_1,cH_1,cV_1,cD_1] = imageWaveletTransform( imageAndPattern );
% Imprimir por pantalla
show_wavelet(cA_1,cH_1,cV_1,cD_1);

[cA_1,cH_1,cV_1,cD_1] = imageWaveletTransform( cA_1 );
% Imprimir por pantalla
show_wavelet(cA_1,cH_1,cV_1,cD_1,2);

[cA_1,cH_1,cV_1,cD_1] = imageWaveletTransform( cA_1 );
% Imprimir por pantalla
show_wavelet(cA_1,cH_1,cV_1,cD_1,3);