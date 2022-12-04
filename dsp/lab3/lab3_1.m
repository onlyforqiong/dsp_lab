clc;clear;close;
%数字滤波器指标要求
ap=1;as=15;fp=1000;fs=1500;
Fs = 10000;
%采用脉冲响应不变法
wap = 2 *pi*fp;
was = 2 *pi*fs;
[N,wac] = buttord(wap,was,ap,as,'s');
[z,p,k]=buttap(N);
[Bap,Aap]=zp2tf(z,p,k);
[Bbs,Abs]=lp2lp(Bap,Aap,wac);     % 低通到低通 计算去归一化Ha(s)
[B,A]=impinvar(Bbs,Abs,Fs);       % 模拟域到数字域
[H2,w2] = freqs(Bbs,Abs);
[H1,w]=freqz(B,A);  
N
% 绘制数字滤波器频响幅度谱
 
figure(1);
 
f=w*Fs/(2*pi);
 
subplot(221);
 
plot(f,20*log10(abs(H1)),'r');          % 绘制幅度响应
axis tight;hold on;

f1=w2 / 2 /pi;
plot(f1,20*log10(abs(H2)),'b');          % 绘制幅度响应
xlabel('频率/Hz');
 
ylabel('H1幅值/dB');
 
subplot(222);
 
plot(f,unwrap(angle(H1)));          % 绘制相位响应
 
xlabel('频率/Hz');
 
ylabel('角度/Rad');


%双线性变换
%模拟转数字
wp = 2 *pi*fp/Fs;
ws = 2 *pi*fs/Fs;
%预畸变
wap=2*tan(wp/2)*Fs;
was=2*tan(ws/2)*Fs;
%设计模拟滤波器
[N,wac] = buttord(wap,was,ap,as,'s');
[z,p,k]=buttap(N);
[Bap,Aap]=zp2tf(z,p,k);
[Bbs,Abs]=lp2lp(Bap,Aap,wac);     % 低通到低通 计算去归一化Ha(s)
[B,A] = bilinear(Bbs,Abs,Fs);       % 模拟域到数字域
[H2,w2] = freqs(Bbs,Abs);
[H1,w]=freqz(B,A);  
N
% 绘制数字滤波器频响幅度谱
 
figure(1);
 
f=w*Fs/(2*pi);
 
subplot(223);
 
plot(f,20*log10(abs(H1)),'r');          % 绘制幅度响应
axis tight;hold on;

f1=w2 / 2 /pi;
plot(f1,20*log10(abs(H2)),'b');          % 绘制幅度响应
xlabel('频率/Hz');
 
ylabel('H1幅值/dB');
 
subplot(224);
 
plot(f,unwrap(angle(H1)));          % 绘制相位响应
 
xlabel('频率/Hz');
 
ylabel('角度/Rad');

subplot(223);
 
