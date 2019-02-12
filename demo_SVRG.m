%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This code is a demo for matrix completion using stochastic variance
% reduced gradient descent algorithm on synthetic data with 
% dimensions d_1=d_2=1000 rank r=30 and sampling rate p=0.2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clc
% clear 
% close all
%load data and support
d1=1000;
d2=1000;
r=30;
p=0.2;
%load data
load(['./Data/data_d1_' num2str(d1) '_d2_' num2str(d2) '_r_' num2str(r) '_p_' num2str(p) '.mat']);
%load support
load(['./Data/support_d1_' num2str(d1) '_d2_' num2str(d2) '_r_' num2str(r) '_p_' num2str(p) '.mat']);
% Calculate the incoherence and spectral norm of X^*
[mu,sigma1,kappa] = calc_para(X_star,r);
%set Obervation matrix
X=X_star.*supp;
N=sum(sum(supp~=0));
%%parameters
n=5;                            %number of components
S=40;                           %outer iteration number
m=n;                            %inner iteration number
omega=randombatch(supp,n);      %observation support of each component
eta1 = 0.3;                      %stepsize
[X_hat_svrg,dist_svrg,iter_num] = MC_SVRG(X,X_star,supp,omega,S,m,eta1,p,r,mu);
plot(iter_num,dist_svrg,'LineWidth',1.5);
xlabel('Number of iterations','FontSize', 12);
ylabel('Frobenius norm error','FontSize', 12);
