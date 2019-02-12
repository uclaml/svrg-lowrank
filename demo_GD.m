%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This code is a demo for matrix completion using gradient descent
% algorithm on synthetic data with dimensions d_1=d_2=10000
% rank r=100 and sampling rate p=0.2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear 
close all
% Generate data first
disp('Generating the data...');
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%load data and support
disp('Loading the data...')
d1=10000;
d2=10000;
r=100;
p=0.2;
%load data
load(['./Data/data_d1_' num2str(d1) '_d2_' num2str(d2) '_r_' num2str(r) '_p_' num2str(p) '.mat']);
%load support
load(['./Data/support_d1_' num2str(d1) '_d2_' num2str(d2) '_r_' num2str(r) '_p_' num2str(p) '.mat']);
%Calculate the incoherence and spectral norm of X^*
[mu,sigma1,kappa] = calc_para(X_star,r);
%set Obervation matrix
X=X_star.*supp;
N=sum(sum(supp~=0));
%%parameters
T=20;                           %number of iterations
eta1 = 0.3;                     %stepsize   
% matrix completion using GD
disp('Solving by GD...')
[X_hat_GD,dist_GD] = MC_GD(X,X_star,supp,eta1,p,r,mu,T);
plot(1:T,dist_GD,'LineWidth',1.5,'color',[0,0,1]);
xlabel('Number of iterations','FontSize', 12);
ylabel('Frobenius norm error','FontSize', 12);
