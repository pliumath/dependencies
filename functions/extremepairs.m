function [m,mp,M,Mp] = extremepairs(D,L,l1,l2)
%EXTREMEPAIRS exports the pairs of sentences with the minimum languange
%distance and maximum language distance between languages l1 and l2.

Dists = D(l1,l2,:);

SD = sort(Dists);

m = SD(1);

M = SD(end);

K = L{l1,2};

SID = unique(K(:,3));

mp = SID(Dists == m);
Mp = SID(Dists == M);

end