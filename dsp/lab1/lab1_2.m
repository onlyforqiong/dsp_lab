n= 0:10;
x = [cos(0.48*pi*n) + cos(0.52*pi*n),zeros(1,90)];
n = 0: 100
w = -pi:0.01*pi : pi;
X = x * exp(-j*n'*w);
subplot(211);
xlabel('n');title('Magnitude');
H = fft(x);
stem(n,abs(H),'filled');
axis tight;hold on;
subplot(212);
xlabel('n');title('Phase');
stem(n,angle(H),'filled');
axis tight;hold on;