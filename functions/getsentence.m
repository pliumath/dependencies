function [pl,wd] = getsentence(L,s,l)
%GETPL get the parent list and the words of the sentence with SID s 
%from the list L in language index l.

K = L{l,2};

pl = K(K(:,3) == s,1:2);

Names = L(:,1);
File = strcat('PUD/',Names{l},'.csv');
opts = detectImportOptions(File); %read the raw data
TB = readtable(File,opts);

wd = TB(TB.SID == s,4);
wd = wd.WORD;

end