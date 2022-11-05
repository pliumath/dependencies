function L = raw2pl(File,i,lan)
%RAW2PL transform a raw data file for the i-th language to a parent list.

opts = detectImportOptions(File); %read the raw data
D = readtable(File,opts);

L = []; %preallocate parent list

%get necessary data
L(:,1) = D.PARENT;
L(:,2) = D.RID;
L(:,3) = D.SID;
L(:,4) = D.WID;
L(:,5) = i;

if lan == 1 %ENG dataset

    L(L(:,3) > 750,:) = [];

end

if lan == 2 %GER dataset

    L(L(:,3) <= 750,:) = [];

    L(L(:,3) > 800 & L(:,3) <= 875,:) = [];

    L(L(:,3) > 925,:) = [];

end

if lan == 3 %FRE dataset

    L(L(:,3) <= 800,:) = [];
    
    L(L(:,3) > 825 & L(:,3) <= 925,:) = [];

    L(L(:,3) > 950,:) = [];

end

if lan == 4 %ITA dataset

    L(L(:,3) <= 825,:) = [];
    
    L(L(:,3) > 850 & L(:,3) <= 950,:) = [];

    L(L(:,3) > 975,:) = [];
end

if lan == 5 %SPA dataset

    L(L(:,3) <= 850,:) = [];
    
    L(L(:,3) > 875 & L(:,3) <= 975,:) = [];


end

end