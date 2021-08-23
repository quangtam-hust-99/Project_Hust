clc ; 
clearvars ;
close all ;
header = [1 1 1 1 1 1 1  0 ];
A = 1 ;
br = 1000;
bp = 1/br ;
% signal = [header randi([0,1] , 1,16)];
signal=[0 1 0 0 1 0 1 1 0 0 0 1 1 0 1 0 ];
bit = [];
for n = 1:1: length(signal)
    if (signal(n) == 1)
        se = ones(1,100);
    else (signal(n) == 0);
        se = zeros (1,100);
    end 
    bit = [bit se];
end
t1 = bp/100 : bp/100 : 100*length(signal)*(bp/100);
subplot (2,1,1);
plot (t1,bit,'lineWidth' , 2.5);
grid on;
axis ([0 bp*length(signal) -1.5 1.5 ]);
ylabel('(volt)');
xlabel('(sec)');
title('Bit truyen ');
% Modulation FSK 
f1=br*16 ; %1
f2 = br*13; %0
t2 = bp/100 : bp/100 : bp ;
ss= length(t2);
m = [];
for n = 1:1: length(signal)
    if (signal(n) == 1)
        k = A*sin(2*pi*f1*t2);
    else (signal(n) == 0);
        k = A*sin(2*pi*f2*t2);
    end
    m = [m k];
end
t3 = bp/100 : bp/100 : bp*length(signal);
subplot (2,1,2);
plot(t3,m);
axis([0 bp*length(signal) -1.5 1.5 ]);
xlabel ('(sec)');
ylabel ('(volt)');
title('FSK signal');
% Demodulation FSK 
t=bp/100:bp/100:16*bp;
y1 = A*sin(2*pi*f1*t);
y2 = A*sin(2*pi*f2*t);
m1=y1.*m;
m2=y2.*m;
figure ;
subplot(4,1,1);
plot(t,y1);
subplot(4,1,2);
plot(t,y2);
subplot(4,1,3);
plot(t,m1);
subplot(4,1,4);
plot(t,m2);
fs=100000;
Wp=3000*2/fs;
Ws1 = 10000*2/fs;
Rp=3;
Rs=50;
% [n1,Wn1] = buttord(Wp,Ws1,Rp,Rs);
[b1,a1] = butter(9,12000*2/fs,'low');
% Ws2 = 20000*2/fs;
% [n2,Wn2]= buttord(Wp,Ws2,Rp,Rs);
[b2,a2] = butter (9,10000*2/fs,'low');
m11 = filter(b1,a1,m1);
m21 = filter(b2,a2,m2);
figure;
subplot(4,1,1);
plot(t,m11);
subplot(4,1,2);
plot(t,m21);
m_out = m11-m21;
yy1=abs(m11);
figure ;
subplot(2,1,1);
plot(t,m11);
subplot(2,1,2);
plot(yy1);
fc=5000;
fs=100000;
[b,a]=butter(20,2*fc/fs,'low');
yy11=filter(b,a,yy1);
figure;
plot(yy11);



% 
% bit_out1 = [];
% bit_out2 = [];
% for p =50:100:1600;%2400
%     if (m_out(p)>= 0 )
%         k1 = ones(1,100);
%         k2 = 1;
%     else 
%         k1= zeros(1,100);
%         k2 = 0;
%     end
%     bit_out1 = [bit_out1 k1];
%     bit_out2 = [bit_out2 k2];
% end
% figure ;
% o1 = fft(m);
% o11 = fft(y1);
% o2 = fft(m2);
% o21 = fft(m21);
% subplot(2,2,1);
% plot(abs(o1));
% subplot(2,2,2);
% plot(abs(o11));
% subplot(2,2,3);
% plot(abs(o2));
% subplot(2,2,4);
% plot(abs(o21));
% disp('Bit in');
% disp(signal);
% disp('Bit out');
% disp(bit_out2);
% disp('a1');
% disp(a1);
% disp('b1');
% disp(b1);
% disp('a2');
% disp(a2);
% disp('b2');
% disp(b2);
% figure;
% freqz(b1,a1,9,100000);
% figure;
% freqz(b2,a2,9,100000);
% 
% 




