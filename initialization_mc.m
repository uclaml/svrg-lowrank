function [U0,V0,limit] = initialization_mc(X,p,r,mu)

[d1,d2] = size(X);


[A,Sigma,B] = svds(X/p,r);
Sigma = sqrt(Sigma);
%Sigma = diag(Sigma);
%Sigma = sqrt(Sigma);
%Sigma = diag(Sigma);

%d = min(d1,d2);
%Z0 = [A*Sigma; B*Sigma];
%limit = sqrt(mu*r/d)*norm(Z0);  % whether we should add a constant before?

U0=A*Sigma;
V0=B*Sigma;

limitU = sqrt(mu*r/d1)*norm(U0);
limitV = sqrt(mu*r/d2)*norm(V0);
limit=[limitU,limitV];

end

