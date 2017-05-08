function [ imgBlock ] = img2LuminanceBlock( img, blockSize,luminanceType )
%[ imgBlock ] = img2LuminanceBlock( img, blockSize,luminanceType )
% Divide la imagen en bloques de tamaño [blockSize x blockSize]. Cada
% bloque contiene la media de luminancia de dicho bloque.
% img : Imagen original
% blockSize : Tamaño bloque
% luminanceType : 
%       * 'ITU-BT-709' : Y = 0.2126 R + 0.7152 G + 0.0722 B
%       * 'ITU-BT-601' : Y = 0.299 R + 0.587 G + 0.114 B
%       * 'performance' : Y = (R+R+R+B+G+G+G+G)>>3
    if(nargin == 2 )
        luminanceType = 'performance';
    end
    tam = size(img);
    %Ajustar el tamaño de la imagen al tamaño del bloque
    resto = mod(tam(1),blockSize);
    if(resto ~= 0)
        img = [img; zeros(blockSize - resto,tam(2))];
        tam = size(img);
    end
    resto = mod(tam(2),blockSize);
    if(resto ~= 0)
        img = [img zeros(tam(1),blockSize - resto)];
        tam = size(img);
    end
    %Dividir en bloques de blockSize x BlockSize
    imgBlock = zeros(floor(tam(1)/blockSize),floor(tam(1)/blockSize),3);
    imgCell = mat2cell(img,blockSize * ones(1,floor(tam(1)/blockSize)), blockSize * ones(1,floor(tam(2)/blockSize)),[1 1 1]);
    tamCell = size(imgCell);
    % Paralelizar esto PLS
    for i = 1:tamCell(1)
        for j = 1:tamCell(2)
            imgBlock(i,j) = luminanceBlock(reshape([imgCell{i,j,:}],blockSize,blockSize,3),luminanceType);
        end
    end
end

function lum = luminanceBlock(block, luminanceType)
    if(strcmp('ITU-BT-709',luminanceType))
        % Y = 0.2126 R + 0.7152 G + 0.0722 B
        block = double(block);
        lum = uint8(sum(sum( (0.2126 * block(:,:,1) ) + (0.7152 * block(:,:,2) ) + (0.0722 * block(:,:,3) ) )));
    elseif(strcmp('ITU-BT-601',luminanceType) )
        % Y = 0.299 R + 0.587 G + 0.114 B
        block = double(block);
        lum = uint8(sum(sum( (0.299 * block(:,:,1) ) + (0.587 * block(:,:,2) ) + (0.114 * block(:,:,3) ) )));
    elseif(strcmp('performance',luminanceType))
        % Y = (R+R+R+B+G+G+G+G)>>3
        lum = bitshift(sum(sum((3 * block(:,:,1) + block(:,:,3) + 4 * block(:,:,2)))),-3);
    end
    lum = bitshift(lum, -length(block));%Divir por el numero de elementos
end
