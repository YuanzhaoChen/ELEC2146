% ELEC2146 AR model
close all
clear
clc
st = 0.01;
tf = 5;
t = [0:st:tf];
% y = [0:st:tf];
y = zeros(length(t),1);
u = [0:st:tf];
y(1) = 0;
%---------- impulse signal--------- 
u = [1 zeros([1,length(t)-1])]; 
%----------- cos -------------------
%u = cos(t);
%-----------------------------------
%---------log-----------------------
% u = [-10 log(t(2:end))];
[y,t] = blackbox(u,st,y(1));
figure(1)
plot(t,y)
title('Response from Black Box')
xlabel('t')
ylabel('y')

% -------------AR model------------------
T = 1;
Y = [y(10) y(20) y(30) y(40) y(50) y(60) y(70) y(80) y(90) y(100) y(200)]';
X1 = [ -y(10-T) -y(10-2*T) ];
X2 = [ -y(20-T) -y(20-2*T) ];
X3 = [ -y(30-T) -y(30-2*T) ];
X4 = [ -y(40-T) -y(40-2*T) ];
X5 = [ -y(50-T) -y(50-2*T) ];
X6 = [ -y(60-T) -y(60-2*T) ];
X7 = [ -y(70-T) -y(70-2*T) ];
X8 = [ -y(80-T) -y(80-2*T) ];
X9 = [ -y(90-T) -y(90-2*T) ];
X10 = [ -y(100-T) -y(100-2*T) ];
X20 = [ -y(200-T) -y(200-2*T) ];
X = [X1;X2;X3;X4;X5;X6;X7;X8;X9;X10;X20];
c = inv(X'*X)*X'*Y;
yofAR = [0:st:tf];
yofAR(1) = y(1);
yofAR(2) = y(2);
MSE = 0;
for i = 3:length(t)
   yofAR(i) = -c(1)*y(i-T) - c(2)*y(i-2*T);
   MSE = MSE + (yofAR(i)-y(i))^2;
end
MSE = MSE/length(t);
fprintf('MSE of AR model is %s\n',MSE);
figure(1)
hold on
plot(t,yofAR,'g')
legend('black box output','model output')
hold off
figure(2)
plot(t,yofAR)
title('AR model')
ylabel('y')
xlabel('t')
