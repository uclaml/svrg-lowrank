% Define projection function
function [Y] = projection(X,l)
Y = X;
[d1, ~] = size(Y);

for i = 1:d1
    if norm(X(i,:)) > l
        Y(i,:) = X(i,:)/norm(X(i,:))*l;
    end
end

end

