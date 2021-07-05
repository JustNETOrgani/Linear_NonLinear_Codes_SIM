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
 xlabel('X-values'), ylabel('Y-values'), title('Linear regression for pressure exerted');
 grid on
 