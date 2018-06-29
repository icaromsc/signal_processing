clear all;
pkg load signal;
#---load signal file
load ecg.txt ecg; 
#rotate signal to vector
amostras=rot90(ecg);

data = amostras;
[pks, loc] = findpeaks (data,"DoubleSided","MinPeakHeight",12);
plot(data);
xlim([(loc(1)-200) (loc(1)+1000)]);
title('ECG 10 ciclos');