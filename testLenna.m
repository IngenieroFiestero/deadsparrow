A = imread('Lenna.png');
tam = size(A);
%% Tile generator

%% Wavelets https://es.mathworks.com/help/wavelet/ref/wavedec2.html

% [cA_1,cH_1,cV_1,cD_1] = imageWaveletTransform( A );
% % Imprimir por pantalla
% show_wavelet(cA_1,cH_1,cV_1,cD_1);
% 
% [cA_1,cH_1,cV_1,cD_1] = imageWaveletTransform( cA_1 );
% % Imprimir por pantalla
% show_wavelet(cA_1,cH_1,cV_1,cD_1,2);
% [cA_1,cH_1,cV_1,cD_1] = imageWaveletTransform( cA_1 );
% % Imprimir por pantalla
% show_wavelet(cA_1,cH_1,cV_1,cD_1,3);


redund = 32;
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
%ad = pn_generator(tam,8);



[x, y] = rose_simple(1/270, 1, 5, 1, 0, false, 0, 1, false);
I = tobitmap(x, y, floor(tam(1) + 1) + 1,floor(tam(2) + 1) + 1) * 80;
ad = zeros([size(I) 3]);
%ad(:,:,1)=I;
%ad(:,:,2)=I;
ad(:,:,3)=I;
[ c_ad,cH_i,cV_i,cD_i ] = imageWaveletTransform( ad );
imshow(uint8(wcodemat(c_ad,255,'mat',1)));


%% Sequencia SS
[cA_1,cH_1,cV_1,cD_1] = imageWaveletTransform( A );
[cA_2,cH_2,cV_2,cD_2] = imageWaveletTransform( cA_1 );
tam2 = size(cA_2);
ss_sequence = (rand(tam2)*20+80)/100;
imshow(uint8(wcodemat(ss_sequence,255,'mat',1)))
image_ss = zeros(tam2);
image_ss(:,:,1) = double(cA_2(:,:,1)) .*ss_sequence(1:tam2(1),1:tam2(2),1);
image_ss(:,:,2) = double(cA_2(:,:,2)) .*ss_sequence(1:tam2(1),1:tam2(2),2);
image_ss(:,:,3) = double(cA_2(:,:,3)) .*ss_sequence(1:tam2(1),1:tam2(2),3);

tam3 = size(cA_1);
figure;
imshow(uint8(wcodemat(image_ss,255,'mat',1)))
[ A0 ] = imageWaveletAntiTransform( image_ss,cH_2,cV_2,cD_2,tam3(1),tam3(2));
[ A1 ] = imageWaveletAntiTransform( A0,cH_1,cV_1,cD_1,tam(1),tam(2) );
imshow(uint8(wcodemat(A1,255,'mat',1)))
%Enviamos A1 en teoria
% Volver a hacer la inversa....uufff
[cA_1,cH_1,cV_1,cD_1] = imageWaveletTransform( A1 );
[cA_2,cH_2,cV_2,cD_2] = imageWaveletTransform( cA_1 );
tam2 = size(cA_2);
image_ss = zeros(tam2);
image_ss(:,:,1) = double(cA_2(:,:,1)) ./ss_sequence(1:tam2(1),1:tam2(2),1);
image_ss(:,:,2) = double(cA_2(:,:,2)) ./ss_sequence(1:tam2(1),1:tam2(2),2);
image_ss(:,:,3) = double(cA_2(:,:,3)) ./ss_sequence(1:tam2(1),1:tam2(2),3);
tam3 = size(cA_1);
figure;
imshow(uint8(wcodemat(image_ss,255,'mat',1)))
[ A0 ] = imageWaveletAntiTransform( image_ss,cH_2,cV_2,cD_2,tam3(1),tam3(2));
[ A1 ] = imageWaveletAntiTransform( A0,cH_1,cV_1,cD_1,tam(1),tam(2) );
imshow(uint8(wcodemat(A1,255,'mat',1)))




%%
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


% --------------------------- LVL 2 -----------------------
[c2,s2]=wavedec2(A1img,2,'haar');
[H2,V2,D2] = detcoef2('all',c,s,1);
A2 = appcoef2(c,s,'haar',1);
V2img = wcodemat(V2,255,'mat',1);%Reescala la imagen hasta los 255
H2img = wcodemat(H2,255,'mat',1);
D2img = wcodemat(D2,255,'mat',1);
A2img = wcodemat(A2,255,'mat',1);

figure;
subplot(2,2,1);
imagesc(A2img);
colormap pink(255);
title('Approximation Coef. of Level 2');

subplot(2,2,2)
imagesc(H2img);
title('Horizontal detail Coef. of Level 2');

subplot(2,2,3)
imagesc(V2img);
title('Vertical detail Coef. of Level 2');

subplot(2,2,4)
imagesc(D2img);
title('Diagonal detail Coef. of Level 2');

%% Kernels ETC
tam = size(A);

% Kernel -------------------
kernel =  zeros(5,5);
%mat = [-2,-1,0;-1,1,1;0,1,2];%Repujado
%mat = [0,-1,0;-1,5,-1;0,-1,0];%Enfocar
mat = [0,1,0;1,-4,1;0,1,0];%Detectar Borde
%mat = ones(3,3);% Desenfoque
%mat = [2,0,1;1,1,-4;3,7,-3];% Eliminar casi todo menos movimiento

kernel(2:4,2:4) = mat;
inv_kernel = zeros(5,5);
inv_kernel(2:4,2:4) = inv(mat);

tam = size(A);
redund = 12;
black = zeros(redund);
white = ones(redund);
tile = [white black; black white];
p = ceil(tam(1)/(redund*2));
q = ceil(tam(2)/(redund*2));
I = repmat(tile,p,q);
I = I(1:tam(1),1:tam(2));
rnd = randi(10,tam(1),tam(2));
add = imadd(I*10,rnd);%First convert to -1/1 then -8/8
W = [];
W(:,:,1) = add;
W(:,:,2) = add;
W(:,:,3) = add;
W=uint8(W);
imshow(W)
E=imadd(A,W);
imshow(E)
rnd2 = [];
rnd2(:,:,1) = rnd;
rnd2(:,:,2) = rnd;
rnd2(:,:,3) = rnd;
rnd2 = uint8(rnd2);
F = imsubtract(E,rnd2);
imshow(F)
%Solo si el kernel tiene inversa
D=imfilter(E,inv_kernel);

imshow(D)
