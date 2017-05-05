function [ imageAndPattern ] = pattern2waveletImage( pattern,image,lvl )
%[ imageAndPattern ] = pattern2waveletImage( pattern,image,lvl )
% pattern : Patron a insertar en el ciclo definodo por 'lvl' de la
% transformada wavelet de la imagen
% image : Imagen original.
% lvl : Ciclo de la transformacion wavelet donde insertar el patron.
% imageAndPattern : Imagen con un patron insertado en bajas frecuencias
patternSize = size(pattern);
levels = cell(lvl,4);
sizes = zeros(lvl+1,2);
tam = size(image);
sizes(1,:) = tam(1:2);
% Guardamos todos los datos de cada uno de los pasos en una celda.
% Realmente los coeficientes principales no harian falta
lastCA = image;
for i = 1:lvl
    [ cA_i,cH_i,cV_i,cD_i ] = imageWaveletTransform( lastCA );
    levels{i,1} = cA_i;
    levels{i,2} = cH_i;
    levels{i,3} = cV_i;
    levels{i,4} = cD_i;
    lastCA = cA_i;
    tamAux = size(cA_i);
    sizes(i+1,:) = tamAux(1:2);
end
%Recortamos el pattern si hace falta para ajustarlo al tamaño de la imagen
%en el ultimo nivel dejandolo centrado
if(patternSize(1) ~= tamAux(1) || patternSize(2) ~= tamAux(2))
    x=1:tamAux(1);
    y=1:tamAux(2);
    difX = patternSize(1) - tamAux(1);
    difY = patternSize(2) - tamAux(2);
    x=x + floor(difX/2);
    y=y + floor(difY/2);
    pattern2 = pattern(x,y,:);
end

% Añadimos el patron como si fuera una imagen5
%levels{lvl,4} = imadd(uint8(wcodemat(levels{i,4},255,'mat',1)), uint8(wcodemat(pattern2,255,'mat',1)));
levels{lvl,3} = levels{lvl,3} + pattern2;
levels{lvl,2} = levels{lvl,2} + pattern2;
levels{lvl,4} = levels{lvl,4} + pattern2;
lastCA = levels{lvl,1} + pattern2;

%levels{lvl,2} = imadd(uint8(wcodemat(levels{i,2},255,'mat',1)),uint8(pattern));
%levels{lvl,3} = imadd(uint8(wcodemat(levels{i,3},255,'mat',1)),uint8(pattern));
%lastCA = imadd(uint8(wcodemat(lastCA,255,'mat',1)),uint8(pattern));
% Transformada inversa
for i = lvl:-1:1
    lastCA = imageWaveletAntiTransform( lastCA,levels{i,2},levels{i,3},levels{i,4},sizes(i,1),sizes(i,2) );
end
imageAndPattern = uint8(wcodemat(lastCA,255,'mat',1));
end

