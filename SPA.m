%% Convert dependency trees to parent lists

clear,clc

addpath('functions/');
addpath('data/PUD/');

Files = struct2cell(dir('data/PUD/')); %get all file names
Files = Files(1,3:end)';
n = size(Files,1); %get the number of languages

L = cell(n,2); %preallocate parent lists

for i = 1:n

    Name = Files{i}; %the i-th file name
    Lan = strsplit(Name,'.'); %the i-th language
    Lan = Lan{1};

    L{i,1} = Lan; %record the current language
    L{i,2} = raw2pl(Name,i,5); %convert to parent list

end

SID = unique(L{1,2}(:,3)); %sentence indices
m = length(SID); %number of sentences

%% Convert parent lists to polynomials

P = cell(m,n); %preallocate polynomials

for j = 12:12 %convert sentences to polynomials

    List = L{j,2}; %get parent lists in language j

    for i = 1:m 

        [SID(i),j]

        tList = List;
        T = tList(tList(:,3) == SID(i),:);

        P{i,j} = pl2poly(T(:,1),T(:,2));

    end

end

%% Compute language distance matrix

D = zeros(n,n,m); %preallocating the distance matrices (per sentence)

parfor i = 1:m

    i

    Q = P;
    Dtemp = zeros(n,n);
    
    for u = 1:n
        
        for v = (u+1):n
            
            Dtemp(u,v) = bipardist(Q{i,u},Q{i,v});
            Dtemp(v,u) = Dtemp(u,v);
            
        end
        
    end

    D(:,:,i) = Dtemp;

end


%% Compute sentence pairwise distances

E = zeros(m,m,n); %preallocating the distance matrices (per language)

parfor i = 1:n

    i

    Q = P;
    Etemp = zeros(m,m);
    
    for u = 1:m
        
        for v = (u+1):m
            
            Etemp(u,v) = bipardist(Q{u,i},Q{v,i});
            Etemp(v,u) = Etemp(u,v);
                       
        end
        
    end

    E(:,:,i) = Etemp;

end

%% save data

save("data/SPA","L","P","D","E")

