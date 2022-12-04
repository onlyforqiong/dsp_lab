tic
M = 409600;
L = 409600;
x = [1,ones(1,L )];
n = 0:M;
h = cos(0.2*pi*n);
line_conv  = conv(x,h);
subplot(211);
n = 0:M+L;
plot(n,line_conv);
axis tight;
toc
tic
x0 = [1,ones(1,L )];
x = [x0,zeros(1,M + L - L )];
n = 0:M;
h0 = cos(0.2*pi*n);
h = [h0,zeros(1,M + L - M )];
X = fft(x);
H = fft(h);
conv_fft = (X .* H);
final_data = ifft(conv_fft);
subplot(212);
axis tight;
n = 0:M+L;
plot(n,final_data);
toc