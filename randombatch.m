function [omega] = randombatch(supp,n)
[d1,d2] = size(supp);
omega=cell(1,n);
N=sum(sum(supp==1));
b=fix(N/n);
[rindex,cindex]=find(supp==1);
k=randperm(N);
t=1;
for i=1:1:n
    omega{i}=zeros(d1,d2);
    if(i==n)
        b=N-(n-1)*b;
    end
    for j=1:1:b
    omega{i}(rindex(k(t)),cindex(k(t)))=1;
    t=t+1;       
    end
end