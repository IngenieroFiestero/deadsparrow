imgOrigin = imread('Lenna.png');

redund = 64;
tamImgOrigin = size(imgOrigin);
ss_space = 2;
rand_sequence = rand(floor([70 70]))/50;
rand_sequence2 = rand(floor([70 70]))/50;

[ imageAndPattern ] = pattern2wavelet2( rand_sequence,imgOrigin,3 );
imshow(imageAndPattern)

imshow(-double(imageAndPattern)+double(imgOrigin))
[ cA_1,cH_1,cV_1,cD_1 ] = imageWaveletTransform(imageAndPattern);
[ cA_1,cH_1,cV_1,cD_1 ] = imageWaveletTransform(cA_1);
[ cA_1,cH_1,cV_1,cD_1 ] = imageWaveletTransform(cA_1);
show_wavelet(cA_1,cH_1,cV_1,cD_1,3);

[ cA_2,cH_2,cV_2,cD_2 ] = imageWaveletTransform(imgOrigin);
[ cA_2,cH_2,cV_2,cD_2 ] = imageWaveletTransform(cA_2);
[ cA_2,cH_2,cV_2,cD_2 ] = imageWaveletTransform(cA_2);

cA=-cA_1+cA_2;
show_wavelet(cA,cH_2,cV_2,cD_2,3);
val = sum(sum(sum(cA(:,:,1).*(rand_sequence) + cA(:,:,2).*(rand_sequence) + cA(:,:,3).*(rand_sequence))))
val = sum(sum(sum(cA(:,:,1).*(rand_sequence2) + cA(:,:,2).*(rand_sequence2) + cA(:,:,3).*(rand_sequence2))))
