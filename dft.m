clear all;
function result = magical_dft (signal)
  N=length(signal);
  result = []; 
  kernel = j*-2*pi/N;
  X = zeros(1,N);
  
  for n = 0:(N-1)
    for k = 0:(N-1)
        #compute X[k]
        X(n+1) = X(n+1) + signal(k+1) * exp(kernel*n*k);
    endfor;
  endfor;
  
  result=X;
  return;
endfunction

#function r = magical_fft (signal)
#  X=signal
#  N=length(signal)
#  W = exp(-2*pi*j/N);
#  if (N>1)
#    X = magical_fft(signal(1:2:end)) + magical_fft(signal(2:2:end));
#    printf("recursion!\n");
#    for k = 1:(N/2);
#      xk= X(k)
#      X(k) = xk + W ** k * X(k+N/2);
#      X(k+N/2) = xk - W**k*X(k+N/2);
#      printf("endfor!\n");
#    endfor  
#  endif
#  r=X;
#  return;
#endfunction    

  
pkg load signal;

#comparacao calculo
xn = [1 2 3 4]; 
N = length(xn);
fs = 30;
#OCT_FFT = fft(xn);
XX = magical_dft(xn)
X =fft(xn);



