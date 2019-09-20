t = linspace(0, 1, 100);

a1 = 1; % Amplitude
f1 = 10; % Frequency (Hertz)
w1 = 2 * pi * f1;
v1 = a1 * sin(w1 * t); % Sinusoidal signal
n = 0.5*rand(length(t));
vn = v1 + n;
%v1(0:10) = v1(0:10) + randn(0, 1);
% plot(t, vn); % Plot sine signal
% hold on; % Hold the previous plot and draw the following overlapped
plot(t, v1); 