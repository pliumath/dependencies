function l = issimilar(t,ltrms)
%ISSIMILAR Compares a term with a list of terms and check if there exists
%  similar terms in the list. 
%
%  LOGICLIST = ISSIMILAR(TERM,LISTOFTERMS) Returns a logic list showing
%  which terms in the list are similar to the given term.
%


% get the number of variables
v = size(t,2);

% locate the similar terms
la = (ltrms(:,1:(v-1)) == t(1,1:(v-1)));

% check the exponents are the same for each variable
pla = la(:,1);

for j = 2:(v-1)
        
    pla = pla.*la(:,j);
        
end

% return the result
l = logical(pla);

end

