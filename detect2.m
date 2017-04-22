vrorigin = VideoReader('motioncut.avi');
vrcode = VideoReader('motionsecure.avi');
i = 0;
while (hasFrame(vrorigin) && hasFrame(vrcode))
    videoorigin = readFrame(vrorigin);
    videocode = readFrame(vrcode);
    dif = videocode - videoorigin;
    difg(:,:,:,i+1) = dif(:,:,:);
    i = i+1;
    if i==60
        break
    end
end
imshow(difg(:,:,:,1)*200)