function [ fotograma_final, foto ] = addBitFotograma2( fotograma,bit,redun )
%ADDBITFOTOGRAMA Summary of this function goes here
%   Detailed explanation goes here
    
    tam = size(fotograma);
    black = zeros(redun);
    white = ones(redun);
    tile = [];
    if (bit == 1)
        tile = [white black; black white];
    else
        tile = [black white; white black];
    end
    p = ceil(tam(1)/(redun*2));
    q = ceil(tam(2)/(redun*2));
    I = repmat(tile,p,q);
    I = I(1:tam(1),1:tam(2));
    add = (I*2 -1)*12;%First convert to -1/1 then -8/8
    fotograma_final(:,:,1) = fotograma(:,:,1) + uint8(add);
    fotograma_final(:,:,2) = fotograma(:,:,2) + uint8(add);
    fotograma_final(:,:,3) = fotograma(:,:,3) + uint8(add);
    foto(:,:,1) = fotograma(:,:,1);
    foto(:,:,2) = fotograma(:,:,2);
    foto(:,:,3) = fotograma(:,:,3);
end