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
[n, m] = size(dataX);
[Xsort, Is] = sort(dataX);
for i=1:size(dataY)
    Ysort(i,1) = dataY(Is(i),1);
end
Dat = [Xsort Ysort];
c = fix(4*n/15);
k = fix((n - c)/2);
if floor(k) > 0.4
    k = k+1;
end
k;
% Performing Selective aggregate 1:
Dat1 = Dat(1:k,:);
[b1,dev1,stats1] = glmfit(Dat1(:,1),Dat1(:,2));
S1 = sum(stats1.resid.^2);
% Performing Selective aggregate 2:
Dat2 = Dat(n-k+1:n,:);
[b2,dev2,stats2] = glmfit(Dat2(:,1),Dat2(:,2));
S2 = sum(stats2.resid.^2);
% Hypothesis testing:
if S1 > S2
    Fp = S1/S2;
else
    Fp = S2/S1;
end
Ft = finv(0.95,k-m-1,k-m-1);
if Fp > Ft
    disp('Heteroscedasticity detected');
    dataSetX = [14.7 19.6 24.5 29.4 34.3 39.2];
    meanOfData = mean(dataSetX);
    varianceOfData = var(dataSetX);
else
    disp('No Heteroscedasticity');
    N = length(dataX);
    % Computing linear regresssion
    X_ones = [ones(N,1), dataX];
    % Compute phi value
    phi = inv(X_ones'*X_ones)*X_ones'*dataY;
    lsrVal = X_ones*phi; % Regressor by regression co-efficients
    % Plotting.
    plot(dataX,lsrVal,'--')
    legend('Data','Original','Improved','Location','best');
end
