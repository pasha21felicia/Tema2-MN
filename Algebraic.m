function [R] = Algebraic(nume, d)
	input = fopen(nume, 'rt');
  n = fscanf(input, '%d', 1); %nr de noduri
  A = zeros(n,n);
  K = zeros(n,n);
  R = zeros(n,1);
  
  %algoritmul de creare a matricei de adiacenta
  for i = 1:n
    ord = fscanf(input, '%d', 1); 
    nr = fscanf(input, '%d', 1);
    aux = fscanf(input, "%d", nr);
    k = 1;
    while(k<=nr)
      if (ord~=aux(k)) 
        A(ord,aux(k)) = 1; 
      endif
      k++;
    endwhile
  endfor
  
  for i = 1:n
    count = 0;
    for j = 1:n
      if (A(i,j) == 1)
        count++;
      endif
    endfor
    K(i,i)= count;
  endfor
  
  M = (inv(K)*A)'; %matricea de adiacenta
  B = PR_Inv(eye(n)-d*M);
  O = ones(n, 1);
  R(1:n) = B*(1-d)/n*O;
  fclose(input);

endfunction 
