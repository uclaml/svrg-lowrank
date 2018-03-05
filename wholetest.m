clc
clear 
close all
%load data and support
d1=1000;
d2=1000;
r=30;
p=0.2;
%load data
load(['./Data/data_d1_' num2str(d1) '_d2_' num2str(d2) '_r_' num2str(r) '_p_' num2str(p) '.mat']);
%load support
load(['./Data/support_d1_' num2str(d1) '_d2_' num2str(d2) '_r_' num2str(r) '_p_' num2str(p) '.mat']);
% Calculate the incoherence and spectral norm of M*
[mu,sigma1,kappa] = calc_para(X_star,r);
%set Obervation matrix
X=X_star.*supp;
N=sum(sum(supp~=0));
%%tuning parameter
n=5;
factor=1;
S=40;
m=n;
omega=randombatch(supp,n);
%choose best step size
kk_svrg =  0.2;
eta1 = kk_svrg/sigma1/kappa;
[X_hat_svrg,dist_svrg] = MC_SVRG(X,X_star,supp,omega,S,m,eta1,p,r,mu);
