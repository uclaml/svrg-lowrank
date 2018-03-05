function [X_hat,dist] = MC_SVRG(X,X_star,supp,omega,S,m,eta,p,r,mu)
n=length(omega);
p1=p/n;
% Initialization
[U0,V0,limit] = initialization_mc(X,p,r,mu);
tU = projection(U0,limit(1));
tV = projection(V0,limit(2));
dist = zeros(S,1);
% SVRG
for s = 1:S
    % Calculate the full gradient w.r.t. tU,tV
    mat = (tU*tV'-X_star) .* supp;
    tG_U=1/p*mat * tV;
    tG_V=1/p*mat' * tU;
    U=tU;
    V=tV;
    for t=1:m
        i_t=unidrnd(n);
        % Calculate the new gradient of the component
        mat_i = (U*V'-X_star) .* omega{i_t};
        tmat_i = (tU*tV'-X_star) .* omega{i_t};

        nablali_U = 1/p1*mat_i * V + 0.5*U*(U'*U - V'*V);
        nablali_V = 1/p1*mat_i' * U + 0.5*V*(V'*V - U'*U);

        tnablali_U = 1/p1*tmat_i * tV;
        tnablali_V = 1/p1*tmat_i' * tU;

        U = projection(U - eta * (nablali_U-tnablali_U+tG_U), limit(1));
        V = projection(V - eta * (nablali_V-tnablali_V+tG_V), limit(2));
    end     
    %j=unidrnd(m);
    tU=U;
    tV=V;
    dist(s) = norm( tU*tV' - X_star, 'fro');
    disp(dist(s));
end
X_hat = tU*tV';
end