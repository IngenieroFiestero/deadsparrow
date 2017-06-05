function videoAndPattern2Wavelet( videoName,staticPattern, outputVideoName )
%VIDEOANDPATTERN2WAVELET Summary of this function goes here
%   Detailed explanation goes here
vr = VideoReader(videoName);
vw = VideoWriter(outputVideoName);
open(vw);
i=1;
while hasFrame(vr)
    video = readFrame(vr);
    %mediaLuminosidad(video)
    videoPattern = pattern2waveletImage(staticPattern,video,3);
    writeVideo(vw,videoPattern);
    i = i+1;
    if i==60
        break
    end
end
close(vw);
end

