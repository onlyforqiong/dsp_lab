clc;clear;close;
%�����˲���ָ��Ҫ��
ap=1;as=15;fp=1000;fs=1500;
Fs = 10000;
%����������Ӧ���䷨
wap = 2 *pi*fp;
was = 2 *pi*fs;
[N,wac] = buttord(wap,was,ap,as,'s');
[z,p,k]=buttap(N);
[Bap,Aap]=zp2tf(z,p,k);
[Bbs,Abs]=lp2lp(Bap,Aap,wac);     % ��ͨ����ͨ ����ȥ��һ��Ha(s)
[B,A]=impinvar(Bbs,Abs,Fs);       % ģ����������
[H2,w2] = freqs(Bbs,Abs);
[H1,w]=freqz(B,A);  
N
% ���������˲���Ƶ�������
 
figure(1);
 
f=w*Fs/(2*pi);
 
subplot(221);
 
plot(f,20*log10(abs(H1)),'r');          % ���Ʒ�����Ӧ
axis tight;hold on;

f1=w2 / 2 /pi;
plot(f1,20*log10(abs(H2)),'b');          % ���Ʒ�����Ӧ
xlabel('Ƶ��/Hz');
 
ylabel('H1��ֵ/dB');
 
subplot(222);
 
plot(f,unwrap(angle(H1)));          % ������λ��Ӧ
 
xlabel('Ƶ��/Hz');
 
ylabel('�Ƕ�/Rad');


%˫���Ա任
%ģ��ת����
wp = 2 *pi*fp/Fs;
ws = 2 *pi*fs/Fs;
%Ԥ����
wap=2*tan(wp/2)*Fs;
was=2*tan(ws/2)*Fs;
%���ģ���˲���
[N,wac] = buttord(wap,was,ap,as,'s');
[z,p,k]=buttap(N);
[Bap,Aap]=zp2tf(z,p,k);
[Bbs,Abs]=lp2lp(Bap,Aap,wac);     % ��ͨ����ͨ ����ȥ��һ��Ha(s)
[B,A] = bilinear(Bbs,Abs,Fs);       % ģ����������
[H2,w2] = freqs(Bbs,Abs);
[H1,w]=freqz(B,A);  
N
% ���������˲���Ƶ�������
 
figure(1);
 
f=w*Fs/(2*pi);
 
subplot(223);
 
plot(f,20*log10(abs(H1)),'r');          % ���Ʒ�����Ӧ
axis tight;hold on;

f1=w2 / 2 /pi;
plot(f1,20*log10(abs(H2)),'b');          % ���Ʒ�����Ӧ
xlabel('Ƶ��/Hz');
 
ylabel('H1��ֵ/dB');
 
subplot(224);
 
plot(f,unwrap(angle(H1)));          % ������λ��Ӧ
 
xlabel('Ƶ��/Hz');
 
ylabel('�Ƕ�/Rad');

subplot(223);
 
