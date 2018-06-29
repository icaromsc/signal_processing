clear all;

function Y = magical_fft (signal)
 size=length(signal);
 l=log2(size);
 p=ceil(l); 
 Y=signal;
 pad_length=0;
 #butterfly normalization of N 
 N = 2^p;
 if(N-size != 0)
  #padding of signal with zeros
  printf("padding!");
  pad_length=(N-size);
  Y=[ zeros(1,pad_length) Y ];  
 endif;
 N2=N/2; 
 #get half indexes 
 indexes = 0 : N2-1;
 #kernel 
 W=exp(-pi*sqrt(-1)/N2).^indexes;  
 for L = 1 : p-1
    #butterfly core
    u=Y(:,1:N2);
    v=Y(:,N2+1:N);
    t=u+v;
    #DFT Simetry
    S=W.*(u-v);
    Y=[t ; S];
    U=W(:,1:2:N2);
    W=[U ;U];
    #get half
    N=N2;
    N2=N2/2;
 endfor;
 #reflection
 u=Y(:,1);
 v=Y(:,2);
 Y=[u+v ; u-v];
 #rotate lines 
 Y=rot90(Y);
 #Y=Y(1, end)
 return;
endfunction

 
clc;
pkg load signal;

#---load signal file
load ecg.txt ecg;
#amostras = dlmread('/home/icaro/Documentos/ufcspa/disciplinas/processamento de sinais/amostras.txt', ' ', 0 , 0);

#rotate signal to vector
signal=rot90(ecg);
#signal = signal(1:670*5);       # 1 complex
#signal = amostras(1:935*10);      # 10 complex
#signal = amostras(1:935*100);     # 100 complex
#signal = amostras;              # all signal

fs = 40000; 
X = magical_fft(signal);
#plotagem espectro de frequencia
m = 0:length(X) - 1;
subplot(3, 1, 1); plot(signal); xlabel('n');ylabel('x(n)');title('sinal ECG');
subplot(3, 1, 2); plot(m*fs/length(X), abs(X), 'b'); ylabel('magnitude');
#xlim([1 400]);
xlabel('frequencia (Hz)'); title('FFT Magnitude da Resposta em Frequencia');
subplot(3,1,3); plot(m*fs/length(X), angle(X), 'b'); ylabel('Angulo');
xlabel('frequencia (Hz)'); title('FFT Fase');
#xlim([1 400]);
# calculo de energia e teste do Teorema de Parseval
E_tempo= sum(abs(signal).^2)
E_freq = sum(abs(X).^2)/length(X)


