clear all
close all
clc
% Params to use begin--------------------------------------------------------------------------
p=100; % Population size
c=30; % number of pairs of chromosomes to be crossovered
m=30; % number chromosomes to be mutated
tg=250; % Total number of generations 
% Params to use ends--------------------------------------------------------------------------
figure
title('Blue - Average         Red - Maximum');
xlabel('Generation')
ylabel('Objective Function Value')
hold on
P=population(p);
K=0;
[x1, y1]=size(P);
P1 = 0;
for i=1:tg   
    Cr=crossover(P,c);
    Mu=mutation(P,m);
    P(p+1:p+2*c,:)=Cr;
    P(p+2*c+1:p+2*c+m,:)=Mu;
    E=evaluation(P);
    [P, S]=selection(P,E,p);
    K(i,1)=sum(S)/p;
    K(i,2)=S(1); % best
    plot(K(:,1),'b.'); drawnow
    hold on
    plot(K(:,2),'r.'); drawnow
end
Max_fitness_value=max(K(:,2));
P2 = P(1,:); % Best chromosome
% convert binary to real numbers
A=bi2de(P2(1,1:y1/2));
x=-3+A*(3-(-3))/(2^(y1/2)-1);
B=bi2de(P2(1,y1/2+1:y1));
y=-3+B*(3-(-3))/(2^(y1/2)-1);
Optimal_solution=[x y];