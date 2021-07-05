function Y=mutation(P,n)
% Variable declations begins.
% P = population
% n = chromosomes to be mutated
% Variable declations ends.
[x1,y1]=size(P);
Z=zeros(n,y1);
for i = 1:n
    r1=randi(x1);
    A1=P(r1,:); % Get a random parent
    r2=randi(y1);
    if A1(1,r2)== 1
        A1(1,r2) = 0; %  Bit flipping.
    else
        A1(1,r2) = 1;
    end
    Z(i,:)=A1;
end
Y=Z;
end

