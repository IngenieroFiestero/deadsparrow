imgOrigin = imread('Lenna.png');

blur=[1,1,1;1,1,1;1,1,1];

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
%% Hasta aqui lo conjunto

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

%% Aqui ya tenemos el patron ss junto con la info

% Prueba de AntiTransfor del SS
tamSS = size(pattern_ss);
noSS = zeros(tamSS);
zeros_SS = pattern2waveletImage( double(pattern_ss),noSS,3 );
figure;
imshow(zeros_SS);
%% Esta es la inversa del patron junto con la imagen (reduciendo la amplitud de color en 5 bits)
imageAndPattern2 = imadd(imgOrigin,imfilter(zeros_SS,blur)/16);
figure;
imshow(imfilter(zeros_SS,blur));

%Asi deberia quedar el patron
%imshow(imageXOR(pattern_ss,-double(ss_sequence)))
imageAndPattern = imgOrigin;
for i=5:5
    imageAndPattern = pattern2waveletImage( double(bitshift(pattern_ss,-8+i)),imageAndPattern,i );
end
figure
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

%Esta ultima imagen debe ser adaptada para poder aplicarle el XOR con el
%Spread Spectrum


%% La imagen se ha guardado como jpg y ahora trabajamos con ella
imwrite(imageAndPattern,'lennaPattern.jpg','jpg')
imgPattern = imread('lennaPattern.jpg');
tamPatt = size(imgPattern);
%imgPattern= imresize(imgPattern,[tamImgOrigin(1),tamImgOrigin(2)]);
image_patt = imageXOR(-double(imgPattern),double(imgOrigin));
figure;
imshow(image_patt);
[cA_2,cH_2,cV_2,cD_2] = imageWaveletTransform( imgPattern );
[cA_2,cH_2,cV_2,cD_2] = imageWaveletTransform( cA_2 );
[cA_2,cH_2,cV_2,cD_2] = imageWaveletTransform( cA_2 );
show_wavelet(cA_2,cH_2,cV_2,cD_2,3);