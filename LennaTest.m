imgOrigin = imread('Lenna.png');

ss_space = 16;%256/8=64 8 niveles distintos
ss_colors = zeros(1,16,3);
ss_colors(1,1,:)=[0,255,255];%cyan
ss_colors(1,2,:)=[128,128,128];%gray
ss_colors(1,3,:)=[0,0,128];%navy
ss_colors(1,4,:)=[192,192,192];%silver
ss_colors(1,5,:)=[0,0,0];%black
ss_colors(1,6,:)=[0,128,0];%green
ss_colors(1,7,:)=[128,128,0];%olive
ss_colors(1,8,:)=[0,128,128];%teal
ss_colors(1,9,:)=[0,0,255];%blue
ss_colors(1,10,:)=[0,255,0];%lime
ss_colors(1,11,:)=[128,0,128];%purple
ss_colors(1,12,:)=[255,255,255];%white
ss_colors(1,13,:)=[255,0,255];%fucsia
ss_colors(1,14,:)=[128,0,0];%marron
ss_colors(1,15,:)=[255,0,0];%red
ss_colors(1,16,:)=[255,255,0];%yellow
ss_colors = uint8(ss_colors);

figure;
imshow(imgOrigin);
redund = 64;
tamImgOrigin = size(imgOrigin);

rand_sequence = randi([1,ss_space],floor([tamImgOrigin(1)/redund tamImgOrigin(2)/redund]));
rand_img = zeros([size(rand_sequence) 3]);
x = size(rand_sequence);
for i=1:x(1)
    for j=1:x(2)
        rand_img(i,j,:) = ss_colors(1,rand_sequence(i,j),:);
    end
end
rand_img = my_repelem(rand_img,redund);
figure;
imshow(rand_img);


pattern = zeros(size(rand_sequence));
pattern(4,4) = 8;
pattern(5,5) = 8;
pattern(4,5) = 8;
pattern(5,4) = 8;


ss_pre = zeros([size(rand_sequence) 3]);
ss_code = mod(double(pattern) + double(rand_sequence),ss_space);
ss_code(ss_code == 0) =  ss_space;
x = size(ss_pre);
for i=1:x(1)
    for j=1:x(2)
        ss_pre(i,j,:) = ss_colors(1,ss_code(i,j),:);
    end
end


pattern_ss = my_repelem(ss_pre,redund);
%Asi es el patron con el SS
figure;
imshow(pattern_ss);

% Prueba de AntiTransfor del SS
tamSS = size(pattern_ss);
noSS = zeros(tamSS);
zeros_SS = pattern2waveletImage( double(pattern_ss),noSS,3 );
figure;
imshow(zeros_SS);


%Asi deberia quedar el patron
%imshow(imageXOR(pattern_ss,-double(ss_sequence)))
imageAndPattern = imgOrigin;
for i=3:3
    imageAndPattern = pattern2waveletImage( double(bitshift(pattern_ss,-8+i)),imageAndPattern,i );
end
figure;
imshow(imageAndPattern);

blur = [1 1 1;1 1 1; 1 1 1];

%%XOR con la original, este paso debe ser muy bien dado
image_patt = imageXOR(-double(imageAndPattern),double(imgOrigin));
figure;
imshow(imfilter(image_patt,blur));
image_patt = imfilter(image_patt,blur);
% Obtener la transformada de esto ultimo
[cA_2,cH_2,cV_2,cD_2] = imageWaveletTransform( image_patt );
[cA_2,cH_2,cV_2,cD_2] = imageWaveletTransform( cA_2 );
[cA_2,cH_2,cV_2,cD_2] = imageWaveletTransform( cA_2 );
figure;
show_wavelet(cA_2,cH_2,cV_2,cD_2,3);
figure;
%Esta ultima imagen debe ser adaptada para poder aplicarle el XOR con el
%Spread Spectrum


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
[ ad,cH_i,cV_i,cD_i ] = imageWaveletTransform( ad );
imshow(uint8(wcodemat(ad,255,'mat',1)));


[x, y] = rose_simple(1/270, 1, 5, 1, 0, false, 0, 1, false);
I = tobitmap(x, y, floor(tam(1)/(7)) + 1,floor(tam(2)/(7)) + 1) * 80;
ad = zeros([size(I) 3]);
%ad(:,:,1)=I;
%ad(:,:,2)=I;
ad(:,:,3)=I;
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
