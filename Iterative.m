function PR = Iterative (nume, d, eps)

  input = fopen(nume, "rt");
  N = fscanf(input, "%d", 1); %nr de noduri
  A = zeros(N,N);
  K = zeros(N,N);
  V = ones(N,1);
  R = zeros(N,1); %un R precedent lui R_t0
  R_t0(1:N,1) = 1/N; %initializam R_t0

  i = 1;
  while(i <= N)
    ord = fscanf(input, "%d", 1); 
    nr = fscanf(input, "%d", 1);
    aux = fscanf(input, "%d", nr);
    k = 1;
    while(k <= nr)
      if (ord ~= aux(k)) 
        A(ord, aux(k)) = 1; 
      endif
      k++;
    endwhile
    i++;
  endwhile

  %formam matricea K care va contine numarul de noduri cu care se invecineaza nodul i
  for i = 1:N 
    count = 0;
    for j = 1:N
      if (A(i,j) == 1)
        count++;
      endif
    endfor
    K(i,i)= count;
  endfor
  
  M = (inv(K)*A)'; %obtinem matricea de adiacenta

  %se calculeaza R folosind forma matriceala intr-o bucla while   
  while (norm(R_t0-R) >= eps)
    R = R_t0;      %actualizam R precedent
    R_t0 = d*M*R_t0 + (1-d)/N*V;  %se aplica formula
  endwhile
  PR = R_t0;
  
  fclose(input);
endfunction    
  
