function [ imgpatt ] = imageXOR( image, pattern )
% [ imgpatt ] = imageXOR( image, pattern )
% Añade un patron a una imagen. Utiliza un XOR en base 255.
% Ej: Patron = [12, 27, 23,222]; img = [245, 217, 82, 31];
% ImgPatt = [2, 14, 105, 253];
% Reconstruccion = ImgPatt+patron = [245, 217, 82, 31];
    tamImg = size(image);
    tamPatt = size(pattern);
    % Ajustar imagen y patron
    if(tamImg(1) ~= tamPatt(1) || tamImg(2) ~= tamPatt(2))
        pattern = zeros(tamImg(1), tamImg(2),3);
        pattern(:,:,1) = resizem(pattern(:,:,1),[tamImg(1) tamImg(2)]);
        pattern(:,:,2) = resizem(pattern(:,:,2),[tamImg(1) tamImg(2)]);
        pattern(:,:,3) = resizem(pattern(:,:,3),[tamImg(1) tamImg(2)]);
    end
    imgpatt = uint8(mod(double(image) + double(pattern),255));
end

