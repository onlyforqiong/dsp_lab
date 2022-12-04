clc;clear;close;
RB  = 1000;
N = 100;
show_n = 10;
x = rand([1 N ]) ;
x = fenduanhanshu(x,0.5);
N_sample = 100; % 单个码元抽样点数
dt = 1 / RB / N_sample; % 抽样时间间隔
t = 0 : dt : ((1 + show_n) * N_sample - 1) * dt; % 序列传输时间
n1 = 0:N_sample - 1;
gt1 = sin(n1*2 *pi /(100 / 10.5)); % sin
gt0 = -gt1;%-sin
first_ten = x(1:10)
se_bpsk = [];
last_x = 0;
for i = 1:show_n + 1
    if x (i) ^ last_x == 1
        se_bpsk = [se_bpsk gt1];
    else
        se_bpsk = [se_bpsk gt0];
    end
    last_x = x(i)
end
subplot(5, 1, 1);plot(t, se_bpsk);axis tight;hold on;title('a');xlabel('t');ylabel('level');

n2 = 0:(length(se_bpsk) - 1);

%接受和发送频率差一点
%延迟一下

n2 = 0:(length(se_bpsk) - 1);
decoder1_cos = [zeros(1,N_sample),se_bpsk(1:show_n * N_sample)];
subplot(5, 1, 2);plot(t, decoder1_cos);axis tight;hold on;title('b');xlabel('\Omega');ylabel('level');
decoder1_getdata = (decoder1_cos .* se_bpsk);
%decoder1_getdata = decoder1_getdata(1:show_n * N_sample);
subplot(5, 1, 3);plot(t, decoder1_getdata);axis tight;hold on;title('c');xlabel('\Omega');ylabel('level');
h1 = ones(1,10);
h1_bpsk = conv(h1,decoder1_getdata);
t1= 0 : dt : ((show_n + 1)* N_sample + length(h1) - 1-1) * dt;
subplot(5, 1, 4);plot(t1, (h1_bpsk));axis tight;hold on;title('d');xlabel('\Omega');ylabel('level');

decoder_final_data = [];
for i = 0:show_n  
   if h1_bpsk(i*N_sample + 50) > 0 
       decoder_final_data = [decoder_final_data ones(1,N_sample)];
   else 
       decoder_final_data = [decoder_final_data -ones(1,N_sample)];
   end
end
subplot(5, 1, 5);plot(t, (decoder_final_data));axis tight;hold on;title('d');xlabel('\Omega');ylabel('level');

function m=fenduanhanshu(t,r)
m=0.*(t>=0 & t< r)+1.*(t<1 & t>= r);  % 注意此处是点乘，否则会报错内部矩阵维度不一致；
end 