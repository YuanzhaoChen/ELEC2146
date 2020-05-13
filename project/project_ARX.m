% ELEC2146 ARX model
close all
clear
clc
st = 0.01;
tf = 5;
y = [0:st:tf];
t = [0:st:tf];
u = [0:st:tf];
y(1) = 0;
%----------cos----------------------
%u = cos(t);
%----------impulse-----------------
%u = [10^9 zeros([1,length(t)-1])];
%-----------step response----------
u = [ones([1 length(t)])];
%------------------------------------
[y,t] = blackbox(u,st,y(1));
figure(1)
plot(t,y)
title('response from Black Box')
xlabel('t')
ylabel('y')
%------------ARX model--------------
T = 1;
Y = [y(3) y(20) y(30) y(40) y(50) y(60) y(70) y(80) y(90) y(100) y(200)]';
X1 = [ -y(3-T) -y(3-2*T) u(3-2*T)];
X2 = [ -y(20-T) -y(20-2*T) u(20-2*T)];
X3 = [ -y(30-T) -y(30-2*T) u(30-2*T)];
X4 = [ -y(40-T) -y(40-2*T) u(40-2*T)];
X5 = [ -y(50-T) -y(50-2*T) u(50-2*T)];
X6 = [ -y(60-T) -y(60-2*T) u(60-2*T)];
X7 = [ -y(70-T) -y(70-2*T) u(70-2*T)];
X8 = [ -y(80-T) -y(80-2*T) u(80-2*T)];
X9 = [ -y(90-T) -y(90-2*T) u(90-2*T)];
X10 = [ -y(100-T) -y(100-2*T) u(100-2*T)];
X20 = [ -y(200-T) -y(200-2*T) u(200-2*T)];
X = [X1;X2;X3;X4;X5;X6;X7;X8;X9;X10;X20];
c = inv(X'*X)*X'*Y;
yofARX = [0:st:tf];
yofARX(1) = y(1);
yofARX(2) = y(2);
MSE = 0;
for i = 3:length(t)
    yofARX(i) = -c(1)*yofARX(i-T) -c(2)*yofARX(i-2*T) + c(3)*u(i-2*T);
    MSE = MSE + (y(i)-yofARX(i))^2;
end
MSE = MSE/length(t);
fprintf('MSE of ARX model is %s\n',MSE);
figure(2)
plot(t,yofARX)
title('ARX model')
xlabel('t')
ylabel('y')
figure(1)
hold on
plot(t,yofARX)
legend('black box output','model output');
hold off
