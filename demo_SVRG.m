%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This code is a demo for matrix completion using stochastic variance
% reduced gradient descent algorithm on synthetic data with 
% dimensions d_1=d_2=10000 rank r=100 and sampling rate p=0.2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear 
close all
% Generate data first
d1 = 10000;
d2 = 10000;
r = 100;
% Generate the low rank matrix 
X_star = data_generation_mc(d1,d2,r);
X_star_fro = norm(X_star,'fro');
%get oberved matrix
p = 0.2; 
supp = double(rand(d1,d2) <= p);   
% Save the generated matrices
save(['./Data/data_d1_' num2str(d1) '_d2_' num2str(d2) '_r_' num2str(r) '_p_' num2str(p) '.mat'],'X_star');
% Save the observed suppot
save(['./Data/support_d1_' num2str(d1) '_d2_' num2str(d2) '_r_' num2str(r) '_p_' num2str(p) '.mat'],'supp');
%load data and support
d1=10000;
d2=10000;
r=100;
p=0.2;
%load data
load(['./Data/data_d1_' num2str(d1) '_d2_' num2str(d2) '_r_' num2str(r) '_p_' num2str(p) '.mat']);
%load support
load(['./Data/support_d1_' num2str(d1) '_d2_' num2str(d2) '_r_' num2str(r) '_p_' num2str(p) '.mat']);
% % Calculate the incoherence and spectral norm of X^*
% [mu,sigma1,kappa] = calc_para(X_star,r);
%set Obervation matrix
X=X_star.*supp;
N=sum(sum(supp~=0));
%%parameters
n=5;                            %number of components
S=10;                           %outer iteration number
m=n;                            %inner iteration number
omega=randombatch(supp,n);      %observation support of each component
eta1 = 0.25;                    %stepsize
mu=1.625;                       %incoherence of X^*
[X_hat_svrg,dist_svrg,iter_num] = MC_SVRG(X,X_star,supp,omega,S,m,eta1,p,r,mu);
hold on
plot(iter_num,dist_svrg,'LineWidth',1.5);
xlabel('Number of iterations','FontSize', 12);
ylabel('Frobenius norm error','FontSize', 12);
