clc;clear;close;
RB  = 1000;
N = 100;
show_n = 10;
x = rand([1 N ]) ;
x = fenduanhanshu(x,0.5);
N_sample = 100; % 单个码元抽样点数
dt = 1 / RB / N_sample; % 抽样时间间隔
t = 0 : dt : (show_n * N_sample - 1) * dt; % 序列传输时间
n1 = 0:N_sample - 1;
gt1 = sin(n1*2 *pi /10); % sin
gt0 = -gt1;%-sin
first_ten = x(1:10)
se_bpsk = [];
for i = 1:show_n
    if x (i)==1
        se_bpsk = [se_bpsk gt1];
    else
        se_bpsk = [se_bpsk gt0];
    end
end
subplot(6, 1, 1);plot(t, se_bpsk);axis tight;hold on;title('SOURCE CODE');xlabel('t');ylabel('level');
bpsk_fft = fftshift(fft(se_bpsk));
w = -pi : 2*pi /(N_sample * show_n  -1):pi;
subplot(6, 1, 2);plot(w, abs(bpsk_fft)/show_n);axis tight;hold on;title('BPSK POWER');xlabel('\Omega');ylabel('level');
n2 = 0:(length(se_bpsk) - 1);
%接受和发送频率一样
decoder_cos = sin(n2*2 *pi /10); % sin
decoder_getdata = decoder_cos .* se_bpsk;

h1 = ones(1,10);
%w1 = -pi : 2*pi /(10  -1):pi;
%h1_fft = fftshift(fft(h1));
%subplot(3, 2, 4);stem(w1, abs(h1_fft)/10);axis tight;hold on;title('BPSK POWER');xlabel('\Omega');ylabel('level');
h2 = ones(1,12);
h1_bpsk = conv(h1,decoder_getdata);
h2_bpsk = conv(h2,decoder_getdata);
t1= 0 : dt : (show_n * N_sample + length(h1) - 1-1) * dt;
length(t1)
subplot(6, 1, 3);plot(t1, (h1_bpsk));axis tight;hold on;title('BPSK flter');xlabel('\Omega');ylabel('level');

t2= 0 : dt : (show_n * N_sample + length(h2) - 1-1) * dt;
subplot(6, 1, 4);plot(t2, (h2_bpsk));axis tight;hold on;title('BPSK flter');xlabel('\Omega');ylabel('level');

%接受和发送频率差一点
n2 = 0:(length(se_bpsk) - 1);
decoder1_cos = sin(n2*2 *pi /(100/10.05)); % sin
decoder1_getdata = decoder1_cos .* se_bpsk;
h1 = ones(1,10);
h1_bpsk = conv(h1,decoder1_getdata);
t1= 0 : dt : (show_n * N_sample + length(h1) - 1-1) * dt;
length(t1)
subplot(6, 1, 5);plot(t1, (h1_bpsk));axis tight;hold on;title('BPSK flter');xlabel('\Omega');ylabel('level');
decoder_final_data = [];
for i = 0:show_n - 1  
   if h1_bpsk(i*N_sample + 50) > 0 
       decoder_final_data = [decoder_final_data ones(1,N_sample)];
   else 
       decoder_final_data = [decoder_final_data -ones(1,N_sample)];
   end
end
subplot(6, 1, 6);plot(t, (decoder_final_data));axis tight;hold on;title('h1 decoder data');xlabel('\Omega');ylabel('level');


function m=fenduanhanshu(t,r)
m=0.*(t>=0 & t< r)+1.*(t<1 & t>= r);  % 注意此处是点乘，否则会报错内部矩阵维度不一致；
end 