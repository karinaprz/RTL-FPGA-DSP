clc; clear;
close all;

a = [1 -2.5641 2.2185 -0.6456];
b = [0.0089 -0.0045 -0.0045 0.0089];

[gd,w] = grpdelay(b, a, 1024, 'whole');
[h,w] = freqz(b, a, 1024, 'whole');

figure;

subplot(3,1,1);
plot(w/2*pi, 10*log10(abs(h)));
xlabel('Частота, Гц'); ylabel('Амплитуда, дБ');
title('АЧХ фильтра'); grid on;

subplot(3,1,2);
plot(w/2*pi, angle(h)*180/pi);
xlabel('Частота, Гц'); ylabel('Фаза, градусы');
title('ФЧХ фильтра'); grid on;

subplot(3,1,3);
plot(w/(2*pi), gd);
xlabel('Частота, Гц'); ylabel('Групповая задержка');
title('Групповая задержка фильтра');
grid on;