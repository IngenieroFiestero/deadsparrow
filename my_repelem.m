function K = my_repelem(A, elems)
A=double(A);
tam = size(A);
tam(1)=tam(1)*elems;
tam(2) = tam(2)*elems;
K= double(zeros(tam));
B = ones(elems);
K(:,:,1) = kron(A(:,:,1),B);
K(:,:,2) = kron(A(:,:,2),B);
K(:,:,3) = kron(A(:,:,3),B);
K=uint8(K);
end