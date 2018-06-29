N = 50;
k = 50;
n = 0:N-1;
xn = 2*sin(2*pi*n/k);
dirac = (n)==0;
xn_dirac= xn.*dirac;

subplot(3,1,1);stem(n,xn);title('Original x[n]');
xlim([-1 50]);

subplot(3,1,2);stem(n,dirac);title('[Delta de Dirac');
xlim([-1 50]);
subplot(3,1,3);stem(n,xn_dirac);title('x[n].dirac[n]');
xlim([-1 50]);