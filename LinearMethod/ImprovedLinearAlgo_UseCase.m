% Implementation of Linear method.
% Model for Presure exerted by water in a container: p = (mg)/A.
% Available data.
% Load dataset. 
dataSet = readtable('Heteroscedasticity.csv');
X_table = dataSet(:, 3);
dataX = table2array(X_table);
Y_table = dataSet(:, 1);
dataY = table2array(Y_table);
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
 xlabel('X-values'), ylabel('Y-values'), title('Linear regression (original and improved) for large dataset');
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
    % Get Regression co-efficients via robustfit.
    robustFit = robustfit(dataX,dataY);
    % Plot fitted model.
    N = length(dataX);
    % Computing linear regresssion
    X_ones = [ones(N,1), dataX];
    % Compute phi value
    phi = inv(X_ones'*X_ones)*X_ones'*dataY;
    lsrVal = X_ones*phi + Ft; % Regressor by regression co-efficients and variance.
    % Plotting.
    plot(dataX,lsrVal)
    legend('Data','Original','Improved','Location','best');
    % Confirming improvement by computing coefficient of determination R^2.
    CoffOfDet_1 = 1 - sum((dataY - computedY).^2)/sum((dataY - mean(dataY)).^2);
    CoffOfDet_2 = 1 - sum((dataY - lsrVal).^2)/sum((dataY - mean(dataY)).^2);
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
