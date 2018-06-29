clear all;
function Y = magical_fft (signal)
 size=length(signal);
 l=log2(size);
 p=ceil(l); 
 Y=signal;
 pad_length=0;
 #normalizacao of N para log2
 N = 2^p;
 if(N-size != 0)
  #padding do signal com zeros
  printf("padding!");
  pad_length=(N-size);
  Y=[ zeros(1,pad_length) Y ];  
 endif;
 N2=N/2; 
 #get half indexes 
 indexes = 0 : N2-1;
 #ja calculamos o kernel 
 W=exp(-pi*sqrt(-1)/N2).^indexes;  
 #transformacao da recursao para iteracao
 for L = 1 : p-1
    #par e impar 
    u=Y(:,1:N2);
    v=Y(:,N2+1:N);
    t=u+v;
    #DFT Simetria
    S=(u-v).*W;
    Y=[t ; S];
    U=W(:,1:2:N2);
    W=[U ;U];
    #divide and conquer
    N=N2;
    N2=N2/2;
 endfor;
 #signal reflection
 u=Y(:,1);
 v=Y(:,2);
 Y=[u+v ; u-v];
 #rotate lines 
 Y=rot90(Y);
 return;
 endfunction  




clc;
pkg load signal;
#---load signal file
load ecg.txt ecg;
Fs = 40000;
#rotate signal to vector
signal=rot90(ecg);
#signal=signal(1:670)

X = magical_fft(signal);
X2 = magical_fft(signal(1:length(signal)/2));

########## PSD FFT  ###############
N = length(X);
xdft = X;
xdft = xdft(1:N/2+1);
psdx =abs(xdft).^2 * (1/(Fs*N));
psdx(2:end-1) = 2*psdx(2:end-1);
freq = 0:Fs/length(X):Fs/2;

########## PSD FFT/2  ###############
N2 = length(X2);
xdft2 = X2;
xdft2 = xdft2(1:N2/2+1);
psdx2 =abs(xdft2).^2 * (1/(Fs*N2));
psdx2(2:end-1) = 2*psdx2(2:end-1);
freq2 = 0:Fs/length(X2):Fs/2;



%%%%%%%%%%% plotting PSD %%%%%%%%%%%%%%%%
subplot(3, 1, 1); plot(signal); xlabel('n');ylabel('x(n)');title('ECG Signal');
subplot(3, 1, 2);plot(freq,(psdx));grid on;title('Periodogram construction Using total Signal');
xlabel('Frequency (Hz)');
ylabel('Power/Frequency (dB/Hz)');
xlim([1 300]);
subplot(3, 1, 3);plot(freq2,(psdx2));grid on;title('Periodogram construction Using half Signal and total FFT ');xlabel('Frequency (Hz)');
xlim([1 300 ]);
ylabel('Power/Frequency (dB/Hz)');
