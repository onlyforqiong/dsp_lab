clc;clear;close;
N = 10000;
show_n = 25;
x = rand([1 N ]);
x = fenduanhanshu(x,0.7);

ami_x = zeros(1,N);

a_sign = -1;
% ami code
for i = 1:N - 1 
    if x(i) == 0
        ami_x(i) = 0;
    elseif x(i) == 1 
        a_sign = -a_sign;
        ami_x(i) = a_sign;
    end
end

%hdb3 code
%V+ 2 V- -1 B+ 3 B- -3
hdb3_x = zeros(1,N);
last_sign = -1;
last_v_sign = 0;
zero_counter = 0;
for i = 1:N  
    if x(i) == 0
        hdb3_x(i) = 0;
        zero_counter = zero_counter + 1 ;
        if zero_counter == 4 
            if(last_sign == last_v_sign) 
                hdb3_x(i - 3) = -last_sign;
                hdb3_x(i)     =  -last_sign;
                last_sign     = -last_sign;
                last_v_sign   = last_sign;
            else 
                if(last_v_sign == 0) 
                    last_v_sign = -1;
                end
                last_sign     = -last_v_sign;
                hdb3_x(i)    = -last_v_sign;
                last_v_sign  = -last_v_sign;
            end
            zero_counter = 0 ;
        end
    elseif x(i) == 1 
        last_sign = -last_sign;
        hdb3_x(i) = last_sign;
        zero_counter = 0;
    end
end

Fs = 10000;
Ts = 1/Fs; % 码元周期
N_sample = 10; % 单个码元抽样点数
dt = Ts / N_sample; % 抽样时间间隔
t = 0 : dt : (show_n * N_sample - 1) * dt; % 序列传输时间
gt1 =[ ones(1, N_sample/2),zeros(1,N_sample/2)]; % NRZ
gt0 = [ -1.*ones(1, N_sample/2),zeros(1,N_sample/2)];

se_source = [];
for i = 1:show_n
    if x (i)==1
        se_source = [se_source gt1];
    else
        se_source = [se_source zeros(1,N_sample)];
    end
end

subplot(3, 2, 1);plot(t, se_source);axis tight;hold on;title('SOURCE CODE');xlabel('t');ylabel('level');
x_fft = fftshift(fft(se_source));
w = -pi : 2*pi /(N_sample * show_n  -1):pi;
subplot(3, 2, 2);plot(w, abs(x_fft)/show_n);axis tight;hold on;title('SOURCE CODE POWER');xlabel('\Omega');ylabel('level');

se = [];
for i = 1:show_n
    if ami_x (i)==1
        se = [se gt1];
    else
        if ami_x (i)==-1
        se = [se gt0];
        else
            se = [se zeros(1,N_sample)];
        end
    end
end

subplot(3, 2, 3);plot(t, se);axis tight;hold on;title('AMI CODE');xlabel('t');ylabel('level');
ami_fft = fftshift(fft(se));
w = -pi : 2*pi /(N_sample * show_n  -1):pi;
subplot(3, 2, 4);plot(w, abs(ami_fft)/show_n);axis tight;hold on;title('AMI CODE POWER');xlabel('\Omega');ylabel('level');


se_hdb3 = [];
for i = 1:show_n
    if hdb3_x (i)==1
        se_hdb3 = [se_hdb3 gt1];
    else
        if hdb3_x (i)==-1
        se_hdb3 = [se_hdb3 gt0];
        else
            se_hdb3 = [se_hdb3 zeros(1,N_sample)];
        end
    end
end
subplot(3, 2, 5);plot(t, se_hdb3);axis tight;hold on;title('HDB3 CODE');xlabel('t');ylabel('level');

hdb3_fft = fftshift(fft(se_hdb3));
w = -pi : 2*pi /(N_sample * show_n  -1):pi;
subplot(3, 2, 6);plot(w, abs(hdb3_fft )/show_n);axis tight;hold on;title('HDB3 CODE POWER');xlabel('\Omega');ylabel('level');



function m=fenduanhanshu(t,r)
m=0.*(t>=0 & t< r)+1.*(t<1 & t>= r);  % 注意此处是点乘，否则会报错内部矩阵维度不一致；
end