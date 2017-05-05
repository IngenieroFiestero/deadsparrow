function show_wavelet( cA,cH,cV,cD,lvl )
% show_wavelet( cA,cH,cV,cD )
% Matlab no se lleva muy bien a la hora de representar imagenes usando
% wavelets y por esto se usa esta funcion
%
% cA : Principl wavelet coefficient
% cH : Horizontal
% cV : Vertical
% cD : Diagonal
% lvl: Nivel del wavelet
if ~exist('lvl','var')
   lvl ='1';
elseif ~isa(lvl,'string')
    lvl = num2str(lvl);
end
figure;
subplot(2,2,1);
imagesc(uint8(wcodemat(cA,255,'mat',1)));
title(['Approximation Coef. of Level ' lvl]);

subplot(2,2,2);
imagesc(uint8(wcodemat(cH,255,'mat',1)));
title(['Horizontal detail Coef. of Level ' lvl]);

subplot(2,2,3);
imagesc(uint8(wcodemat(cV,255,'mat',1)));
title(['Vertical detail Coef. of Level ' lvl]);

subplot(2,2,4);
imagesc(uint8(wcodemat(cD,255,'mat',1)));
title(['Diagonal detail Coef. of Level ' lvl]);

end

