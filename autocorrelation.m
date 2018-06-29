clear all;
function corr = magical_autocorrelation (signal)
  corr = [];
  mirror=zeros(1,length(signal),1);
  temp=[signal,mirror];
  for i = 1:length (signal)
    total=sum(signal.*temp(i:length(signal)+i-1));
    corr=[corr, total];
  endfor
  #add left side to the correlation 
  corr=[flip(corr(2:end)), corr];
  return; 
endfunction



#---main

clc;
pkg load signal;
#---load signal file
#load amostras.txt amostras; 
#rotate signal to vector
#amostras=rot90(amostras);
#signal = amostras(1:935);       # 1 complex
#signal = amostras(1:935*10);      # 10 complex 
#signal = amostras(1:935*100);     # 100 complex
#signal = amostras;              # all signal
k = 512;
signal= -k : k;

#default octave
corr_octave=xcorr(signal);
#me
corr_me=magical_autocorrelation(signal);

figure(1);
subplot(3,1,1); stem(signal);        title('Original Signal with 100 complex');
subplot(3,1,2); stem(corr_octave); title('Octave Autocorrelation');
subplot(3,1,3); stem(corr_me);    title('Autocorrelation developed by me');
