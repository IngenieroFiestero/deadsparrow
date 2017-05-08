function [ matrix ] = pn_generator(dim,bits)
%[ matrix ] = pn_generator(dim,bits)
% dim - Dimension array. Ejemplo: [32,32,3]. Image 32x32x3
% bits - Numero de bits "por pixel" -> [32x32x3]x8

%Nota: Empezar desde el centro la secuencia aleatoria nod esde las esquinas
%plot(xcorr(A(:)))
%https://es.mathworks.com/help/comm/ref/pnsequencegenerator.html
%https://es.mathworks.com/help/comm/ref/comm.pnsequence-class.html
    matrix = zeros(dim);
    pol = [46 21 10 1 0];
    ini = zeros(max(pol),1);
    ini(1)=1;
    pnSequence = comm.PNSequence('Polynomial',	pol,'SamplesPerFrame',dim(1)*dim(2),'InitialConditions',ini);
    pnSequence.step;
    for i=1:dim(3)
        matrix(:,:,i) = (reshape(pnSequence.step,[dim(1) dim(2)])*2 - 1)*(2^(bits-1) -1);
    end
end