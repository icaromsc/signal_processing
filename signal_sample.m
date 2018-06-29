N=35; 
fo = 700; %frequência do maior sinal
Ts=1/1400; 
n=0:N-1; 
x=(2*cos(2*pi*700* n * Ts))+ (3*cos(2*pi*450* n * Ts))+(cos(2*pi*630* n * Ts+(2*pi/5))) ;
stem(n,x) 
title('Amostrando sinal estacionario com 3 frequencias');
hold(on);
grid(on);
plot(n,x,":");