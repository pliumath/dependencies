function L = dm2dl(D)
%DM2DL converts a distance matrix to a distnace list.

n = size(D,3);
m = size(D,1);

L = zeros(nchoosek(m,2),n);

for i = 1:n

    Lt = [];

    for j = 1:(m-1)

        Lt = [Lt;D((j+1):m,j,i)];

    end

    L(:,i) = Lt;

end

end