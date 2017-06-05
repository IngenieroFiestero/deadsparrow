clear all
clc
vr = VideoReader('motion.mp4');
vw = VideoWriter('motionsecure');
vwo = VideoWriter('motioncut');
open(vw);
open(vwo);
i=0;
bits = [1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0];
while hasFrame(vr)
    video = readFrame(vr);
    %mediaLuminosidad(video)
    bit = bits(floor(i/3)+1);
    [foto foto2] = addBitFotograma2(video,bit,8);
    writeVideo(vw,foto);
    writeVideo(vwo,foto2);
    i = i+1;
    if i==60
        break
    end
end
close(vw);
close(vwo);

%% Wavelet Video

%Pattern
tam = size(A);
redund = 12;
black = zeros(redund);
white = ones(redund);

videoName = 'motion.mp4';
outputVideoName = 'motionsecure';
vr = VideoReader(videoName);
vw = VideoWriter(outputVideoName);
open(vw);
i=1;
while hasFrame(vr)
    if mod(i,2)==1
        tile = [black white; white black];
        p = ceil(tam(1)/(redund*2));
        q = ceil(tam(2)/(redund*2));
        I = repmat(tile,p,q);
        I = I(1:tam(1),1:tam(2))*32;
        ad = zeros([size(I) 3]);
        ad(:,:,1)=I;
        ad(:,:,2)=I;
        ad(:,:,3)=I;
    else
        tile = [white black; black white];
        p = ceil(tam(1)/(redund*2));
        q = ceil(tam(2)/(redund*2));
        I = repmat(tile,p,q);
        I = I(1:tam(1),1:tam(2))*32;
        ad = zeros([size(I) 3]);
        ad(:,:,1)=I;
        ad(:,:,2)=I;
        ad(:,:,3)=I;
    end
    video = readFrame(vr);
    %mediaLuminosidad(video)
    videoPattern = pattern2waveletImage(ad,video,5);
    writeVideo(vw,videoPattern);
end
close(vw);


%videoAndPattern2Wavelet( 'motion.mp4',ad, 'motionsecure' );

