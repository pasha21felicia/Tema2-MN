function [R1 R2] = PageRank(nume, d, eps)
  
  input = fopen(nume, "rt");
  myoutput = strcat(nume, ".out");
  out_file = fopen(myoutput, "w");
  
  N = fscanf(input, "%d", 1);
  
  %citesc toate liniile inainte de val1 si val2
  i = 1; 
  while (i <= N+1)
    PR1 = fgets(input);
    i++;
  endwhile

  val1 = fscanf(input, "%f", 1);
  val2 = fscanf(input, "%f", 1);
  
  R1 = Iterative(nume, d, eps);
  R2 = Algebraic(nume, d, eps);
  fprintf(out_file, "%d\n", N);
  fprintf(out_file, "%f\n", R1(1:N));
  fprintf(out_file, "\n");
  fprintf(out_file, "%f\n", R2(1:N));

  PR1 = R2;
  poz = zeros(1, N);
  poz = 1:N;
  %sortarea vectorului PR1 si a pozitiilor
  for i = 1:N
    for j = 1:N
      if (PR1(i) > PR1(j))
        temp = PR1(i);
        PR1(i) = PR1(j);
        PR1(j) = temp;
        temp2 = poz(i);
        poz(i) = poz(j);
        poz(j) = temp2;
      endif
    endfor
  endfor

 
  fprintf(out_file, "\n");
  %afisarea rezultatelor dupa sortare
  i = 1;
  while (i <= N)
    fprintf(out_file, "%d ", i);
    fprintf(out_file, "%d ", poz(i));
    fprintf(out_file, "%f\n", Apartenenta(PR1(i), val1, val2));
    i++;
  endwhile
  fclose(input);
  fclose(out_file);
  
endfunction  
  