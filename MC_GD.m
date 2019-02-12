function [X_hat,dist] = MC_GD(X,X_star,supp,eta,p,r,mu,T)
% Initialization
[U0,V0,limit] = initialization_mc(X,p,r,mu);
U = projection(U0,limit(1));
V = projection(V0,limit(2));
dist = zeros(T,1);
% Projected GD
for t = 1:T 
    % Calculate the gradient
    mat = (U*V'-X_star) .* supp;
    nabla_U = 1/p*mat * V + 0.5*U*(U'*U - V'*V);
    nabla_V = 1/p*mat' * U + 0.5*V*(V'*V - U'*U);
    U = projection(U - eta * nabla_U, limit(1)); 
    V = projection(V - eta * nabla_V, limit(2));
    dist(t) = norm(U*V'- X_star, 'fro');
    disp(dist(t));
end
X_hat=U*V';



