% Implementation of Linear method.
% Model for rate of reaction: r = k_0e^{-E/RT}C^n.
% Converted to linear form via log: ln(r) = In(k_0) + (-E/R)1/T + n In C
% Historial data for rate of reaction given c, t and r.
r = [0.15 0.23 0.56 0.78 0.82
     1.21 1.32 1.45 1.65 1.95
     2.35 2.45 2.56 2.67 2.78
     3.61 3.25 3.56 3.63 3.79];
 c = [1; 2; 3; 4];
 t = [100; 150; 200; 250; 300];
 % Repeat copies of u to match order of v.
 c = repmat(c,5,1);
 % Reshape 'at' to 20x1 array.
 t = reshape(repmat(t',4,1),20,1);
 dataX = [c,t];
 dataY = reshape(r,20,1);
 % Output dataX and dataY.
 disp([dataX, dataY]);
 % Perform computations.
 x = 1 ./ dataX(:,2);
 u = log(dataX(:,1));
 y = log(dataY);
 N = length(y);
 
 X = [ones(N,1),x, u];
 Y = y;
 phi = inv(X'*X)* X'*Y;
 k0 = exp(phi(1));
 negEbyR = -phi(2);
 n = phi(3);
 % Plotting phase.
 plot(x,y, 'bs',[0.00001 0.01], phi(1)+ phi(2)*[0.001 1]+ phi(3)*[0.00001 0.01], '-r');
 xlabel('X-values'), ylabel('phi values'), title('Multiple linear regression for rate of reaction');