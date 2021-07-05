% Implementation of Linear method.
% Model for Presure exerted by water in a container: p = (mg)/A.
% Available data.
dataX = [14.7; 19.6; 24.5; 29.4; 34.3; 39.2];
dataY = [3.7; 4.9; 6.1; 7.4; 8.6; 9.8];
 % Output dataX and dataY.
 disp([dataX, dataY]);
 % Perform computations.
 % Performing mldivide for least-square regression.
 lsr = dataX\dataY; % Model like p = lsrX
 % Regressor by regression co-efficients
 computedY = lsr*dataX;
 scatter(dataX,dataY)
 hold on
 plot(dataX,computedY)
 xlabel('X-values'), ylabel('Y-values'), title('Linear regression (original and improved) for pressure exerted');
 grid on
 
% Improvement
N = length(dataX);
 % Computing linear regresssion
X_ones = [ones(N,1), dataX];
% Compute phi value
phi = inv(X_ones'*X_ones)*X_ones'*dataY;
lsrVal = X_ones*phi; % Regressor by regression co-efficients
% Plotting.
plot(dataX,lsrVal,'--')
legend('Data','Original','Improved','Location','best');
% Confirming improvement by computing coefficient of determination R^2.
CoffOfDet_1 = 1 - sum((dataY - computedY).^2)/sum((dataY - mean(dataY)).^2);
CoffOfDet_2 = 1 - sum((dataY - lsrVal).^2)/sum((dataY - mean(dataY)).^2);

