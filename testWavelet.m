imgOrigin = imread('Lenna.png');
tamImgOrigin = size(imgOrigin);
pattern = zeros(tamImgOrigin);
pattern(floor(tamImgOrigin(1)/3):1:floor(2*tamImgOrigin(1)/3), (tamImgOrigin(2)/3):1:floor(2*tamImgOrigin(2)/3),: ) = 64;
imshow(pattern);
ss_sequence = uint8(255*(rand(tamImgOrigin)));
% XOR patron y Spread Spectrum
pattern_ss = imageXOR(pattern,ss_sequence);

%Asi es el patron con el SS
imshow(pattern_ss);
%Asi deberia quedar el patron
imshow(imageXOR(pattern_ss,-double(ss_sequence)))
imageAndPattern = pattern2waveletImage( double(bitshift(pattern_ss,-5)),imgOrigin,3 );
imshow(imageAndPattern);

image_patt = imageXOR(imageAndPattern,-double(imgOrigin));
imshow(image_patt);
[cA_1,cH_1,cV_1,cD_1] = imageWaveletTransform( image_patt );
[cA_1,cH_1,cV_1,cD_1] = imageWaveletTransform( cA_1 );
[cA_1,cH_1,cV_1,cD_1] = imageWaveletTransform( cA_1 );
show_wavelet(cA_1,cH_1,cV_1,cD_1,3);

imshow(imageXOR(uint8(wcodemat(cA_1,255,'mat',1)),-double(pattern_ss)));

% La operacion XOR con el patron_ss final es mas complicado al haber a~nadir
% las wavelets. Hay que hacerlo por bloques mas gordos ademas al a~nadir el
% patron lo recorta y no queremos ese efecto. Hay que dar la imagen ya
% recortada.