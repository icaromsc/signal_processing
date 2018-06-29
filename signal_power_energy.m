pkg load syms;

#k = 4
EN = 4;
k =4;
n = 0:k-1;
x = 2*sin(2*pi*n/k); 
potencia = (1/k)*sum(x.^2) 
energia = sum(x.^2) 


#k=8
k = 8;
n = 0:k-1;
x = 2*sin(2*pi*n/k);
potencia = (1/k)*sum(x.^2) 
energia = sum(x.^2) 

#continuo
t0=1/5;
syms t;
x=4*cos(10*pi*t);
P=(1/t0)*int(x.^2,-t0/2,t0/2) 