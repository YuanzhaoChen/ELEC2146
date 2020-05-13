% ELEC2146 underdamp model
close all
clear
clc
st = 0.01;
tf = 5;
y = [0:st:tf];
t = [0:st:tf];
u = [0:st:tf];
y(1) = 1;
%---------- impulse signal--------- 
u = [1 zeros([1,length(t)-1])]; 
%------------sin-------------------
%u = sin(t);
%-----------------------------------
[y,t] = blackbox(u,st,y(1));
figure(1)
plot(t,y)
title('response from Black Box')
xlabel('t')
ylabel('y')
% ----------second order circuits underdamp case-----------------
ymax = -1;
tofmax = -1;
ymin = 1;
tofmin  = -1;
for i = 4:length(t) % points at t = 0 are unreliable so disregard them
    if ( y(i) > ymax )
        ymax = y(i);
        tofmax = t(i);
    end
    if ( y(i) < ymin )
        ymin = y(i);
        tofmin = t(i);
    end
end
T = 2*abs(tofmax -tofmin);
wd = 2*pi/T;
num = 7;
ypeaks = [1:num];
tofpeaks = [1:num];
k = 1;
for i = 1:length(t)-1
   
   if(y(i+1) < y(i) && k<=num && y(i)>0 && y(i+1)>0)
        ypeaks(k) = y(i);
        tofpeaks(k) = t(i);
        k = k + 1;
   end
    
end
figure(3)
plot(tofpeaks,ypeaks)
title('Envelope of under damp (B*exp(-alpha*t))')
xlabel('t')
ylabel('y')
Y = [1:length(ypeaks)-1]';
X = [1:length(ypeaks)-1]';
for i =1:length(ypeaks)-1
   Y(i) = log(ypeaks(i)/ypeaks(i+1));
   X(i) = tofpeaks(i)-tofpeaks(i+1);
end
c =inv(X'*X)*X'*Y;
alpha = -c;

Y = ypeaks';
X = exp(-alpha*tofpeaks)';
A = inv(X'*X)*X'*Y;

theta  = wd*tofpeaks(4)  - acos(ypeaks(4)/(A*exp(-alpha*tofpeaks(4))) );
estimatedy = [1:length(t)];
MSE = 0;
for i =1:length(t)
    estimatedy(i) = A*exp(-alpha*t(i))*cos(wd*t(i) - theta);
    MSE = MSE + (y(i)-estimatedy(i))^2;
end
MSE = MSE/length(t);
fprintf('MSE of the underdamp model is %s\n',MSE);
figure(1)
hold on
plot(t,estimatedy,'r')
hold off
legend('black box output','model output');
figure(2)
hold on
title('underdamp model');
xlabel('t');
ylabel('estimated y');
plot (t,estimatedy,'r')