n= 0:10;
x=(-0.8).^n;
x';
w = 0:0.01*pi:2*pi;
X = x * exp(-j*n'*w);
subplot(211);
plot(w,abs(X));xlabel('\Omega/\pi');title('Magnitude');
subplot(212);
plot(w,angle(X)/pi);xlabel('\Omega/\pi');title('Phase');
