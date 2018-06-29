clear all;
function conv = magical_convolution (signal_a, signal_b)
  conv = [];
  
  #reverse signal
  signal_a=flip(signal_a);
  
 #padding zeros left and right to signal
  padding=zeros(1,length(signal_a)-1,1);
  signal_b=[padding,signal_b,padding];
 
  #shifting convolution 
  for i = 1:length (signal_b)-length(signal_a)+1
    total=0;
    for j =1:length(signal_a)
      total = total + signal_a(j).*signal_b(j+i-1);
    endfor
    #add conv[k]
    conv=[conv, total];
  endfor
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
signal_a= -k : k;
signal_b= -k : k;

#default octave
conv_octave=conv2(signal_a,signal_b);
#me
conv_me=magical_convolution(signal_a,signal_b);

figure(1);
#subplot(4,1,1); stem(signal); title('Original Signal with 1 complex');
subplot(4,1,1); stem(signal_a); grid on; title('Original Signal a');
subplot(4,1,2); stem(signal_b); grid on; title('Original Signal b');
subplot(4,1,3); stem([0:(length(conv_octave)-1)],conv_octave); grid on; title('Octave Convolution');
subplot(4,1,4); stem([0:(length(conv_me)-1)],conv_me); grid on; title('Convolution developed by me');
