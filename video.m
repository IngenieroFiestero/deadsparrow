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

