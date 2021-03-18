function [A] = PR_Inv(A)
	[M N] = size(A);  
	Q = zeros(M,N);
	R = zeros(N);
	x = zeros(N,1);
	I = eye(N);
  
	for i = 1:N
		R(i,i) = norm(A(:,i));			
		Q(:,i) = A(:,i) / R(i,i);
    k = i+1;
    while (k <= N)
			R(i,k) = Q(:,i)' * A(:,k);
			A(:,k) = A(:,k)-Q(:,i) * R(i,k);
      k++;
		endwhile
	endfor
  
	for k = 1:N
		b = I(:,k);
		x(N) = b(N)/R(N,N);
    i = N-1;
    while (i >= 1)
			x(i)=(b(i) - R(i,i+1:N) * x(i+1:N)) / R(i,i);
      i--;  
		endwhile
		R_inv(:,k) = x;  %aflam inversa lui R
	end
	A = R_inv * Q';  %inversa lui A = inversa lui R * Q transpus
endfunction