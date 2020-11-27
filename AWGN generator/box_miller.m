reg1 = [0 0 1 0 0 0 0 0];
reg2 = [0 0 0 1 0 0 0 0];

% [bi2de(reg1) bi2de(reg2)]

u1 = zeros(255,1);
u2 = zeros(255,1);

u1(1) = reinterpretcast(uint8(bi2de(reg1)),numerictype(0,8,8));
u2(1) = reinterpretcast(uint8(bi2de(reg2)),numerictype(0,8,8));

for i = 2:255
    exit1 = mod(reg1(1)+reg1(3)+reg1(5)+reg1(8), 2);
    exit2 = mod(reg2(2)+reg2(3)+reg2(4)+reg2(8), 2);
    
    reg1 = [exit1 reg1(1:end-1)];
    reg2 = [exit2 reg2(1:end-1)];
    
    u1(i) = reinterpretcast(uint8(bi2de(reg1)),numerictype(0,8,8));
    u2(i) = reinterpretcast(uint8(bi2de(reg2)),numerictype(0,8,8));
end

u1 = double(u1);
u2 = double(u2);

z0=sqrt(-2*log(u1)).*cos(2*pi*u2);
z1=sqrt(-2*log(u1)).*sin(2*pi*u2);

N = length(z0);
figure,plot(sort(z0), (1:N)/N);
hold on
plot(sort(z1), (1:N)/N);
x_values = linspace(min(z0),max(z0));
plot(x_values,normcdf(x_values,0,1),'r-')
title('Box-Muller transform');
legend('Empirical CDF','Empirical CDF','Standard Normal CDF','Location','best')

figure,plot(abs(fft(complex(z0,z1))));
title('Box-Muller transform spectrum');

% z0=randn(2550,1);
% z1=randn(255,1);
% 
% figure,plot(abs(fft(complex(z0,z1))));
% title('Randn spectrum');
