function d = bipardist(P,Q)
%BIPARDIST computes the bipartite distance between the two polynomials P
%  and Q representing two dependency structures.

n = size(P,1); %number of terms in P and Q
m = size(Q,1);

l = size(P,2); %number of variables

tp = P(:,1:l); %terms
tq = Q(:,1:l);

dp = [];
dq = [];

for i = 1:n % for each term in P

    t = tp(i,:); %the ith term

    tdp = min(sum(abs(tq - t),2)); %minimum exponent differnece

    dp = [dp;tdp];

end

for i = 1:m

    t = tq(i,:);

    tdq = min(sum(abs(tp - t),2));

    dq = [dq;tdq];

end

d = (sum(dp)+sum(dq))/(size(dp,1)+size(dq,1));

end