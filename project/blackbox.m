function [y,t] = blackbox(u, T, y0)
% Blackbox is a function that simulates a 'black box' dynamic model 
% Usage: [y,t] = blackbox(u, T, y0)
% y is the output response to an input provided by the user
% t is the resulting time vector
% u is the input signal (sequence not time referenced)
% T is the simulation step size
% y0 is the initial condition on the output


N = length(u);
tf = N*T;
y = zeros(N,1);
d = randn(size(u));
y(1) = y0; 
y(2) = 0.5*y0 + 0.7*u(1) + 0.01*d(1);
y(3) = 0.5*y(2)+0.1*y0+0.7*u(2)+0.2*u(1)+0.01*d(2);
for i = 4:N
    t(i,1) = (i-1)*T;
    y(i) = 0.5*y(i-1)+0.1*y(i-2)-0.5*y(i-3);
    y(i) = y(i) + 0.7*u(i-1) + 0.2*u(i-2) + 0.1*u(i-3);
    y(i) = y(i) + 0.01*d(i-1) + 0*d(i-2) + 0.01*d(i-3);  
end
end

