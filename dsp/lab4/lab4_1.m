
wp=0.3*pi;ws=0.5*pi;tr_width=ws-wp;
M=ceil(6.6*pi/tr_width)+1;
n=[0:1:M-1];
wc=(ws+wp)/2;
hd=ideal_lp(wc,M); w_ham=(hamming(M))'; h=hd.*w_ham;
[db,mag,pha,grd,w]=freqz_m(h,[1]); 
subplot(2,2,1);stem(n,hd);axis([0 M-1 -0.2 0.4]); 
title('Ideal Impulse Response');
xlabel('n');ylabel('hd(n)'); 
subplot(2,2,2);
stem(n,w_ham);axis([0 M-1 0 1.1]);
title('Hamming Window');xlabel('n');ylabel('w(n)');
subplot(2,2,3);stem(n,h);axis([0 M-1 -0.2 0.4]); 
title('Actual Impulse Response');xlabel('n');ylabel('h(n)'); subplot(2,2,4);plot(w/pi,db);axis([0 1 -100 10]);grid; 
title('Magnitude Response in dB');
xlabel('frequency in piunits');ylabel('Decibels');
