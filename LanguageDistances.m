%% load dataset and result

clear,clc

addpath('functions/');
addpath('data/');
addpath('data/PUD');

Datasets = {'ENG','GER','FRE','ITA','SPA'};

s = 1; %dataset index
c = [1,3,4,5,2]; %color order

load(strcat(Datasets{s},'.mat'))


Colors = lines(7); %load colors
fs = 16; %set font size

Names = L(:,1); %get language name mapping

n = size(L,1);
M = mean(D,3);

% reorder the languages
A = [4,7,18,9,11,6,15,17,3,14,16,8,1,2,5,10,12,13,19,20];
NA = Names(A);
MA = M;
MA(:,:) = M(A,A);

%% plot heatmap of language distance matrix

MA = MA + diag(nan(20,1));

figure('Position', [0 1000 980 600]);

CL = [linspace(Colors(c(s),1),1,512)',linspace(Colors(c(s),2),1,512)',linspace(Colors(c(s),3),1,512)'];

HM = heatmap(NA,NA,MA,'Colormap',flipud(CL),'ColorbarVisible','off','ColorScaling','log','MissingDataColor', [177 177 177]./256);
HM.CellLabelFormat = '%.2f';

set(gca,'fontname','Palatino','fontsize',16)

%% plot summaries

SA = zeros(14,1);
SN = {'Mean', 'Median', 'Nearest','2nd nearest', '3rd nearest', '3rd farthest', ...
    '2nd farthest', 'farthest', 'Smallest', '2nd smallest', '3rd smallest', ...
    '3rd largest', '2nd largest', 'largest'};
SL = cell(12,1);

%pairwise language distance
so = sort(dm2dl(MA));
% mean and median
SA(1) = mean(so);
SA(2) = median(so);

% nearest
SA(3) = so(1);
[x,y]= find(MA==so(1));
SL{1} = NA(x);

% second nearest
SA(4) = so(2);
[x,y]= find(MA==so(2));
SL{2} = NA(x);

% third nearest
SA(5) = so(3);
[x,y]= find(MA==so(3));
SL{3} = NA(x);

% third farthest
SA(6) = so(end-2);
[x,y]= find(MA==so(end-2));
SL{4} = NA(x);

% second farthest
SA(7) = so(end-1);
[x,y]= find(MA==so(end-1));
SL{5} = NA(x);

% farthest
SA(8) = so(end);
[x,y]= find(MA==so(end));
SL{6} = NA(x);


%average languange distance
mm = sum(MA,1)./19;
mso = sort(mm);
% smallest
SA(9) = mso(1);
ind = find(mm==mso(1));
SL{7} = NA(ind);

% second smallest
SA(10) = mso(2);
ind = find(mm==mso(2));
SL{8} = NA(ind);

% third smallest
SA(11) = mso(3);
ind = find(mm==mso(3));
SL{9} = NA(ind);

% third largest
SA(12) = mso(end-2);
ind = find(mm==mso(end-2));
SL{10} = NA(ind);

% second largest
SA(13) = mso(end-1);
ind = find(mm==mso(end-1));
SL{11} = NA(ind);

% largest
SA(14) = mso(end);
ind = find(mm==mso(end));
SL{12} = NA(ind);

CL = [linspace(Colors(c(s),1),1,256)',linspace(Colors(c(s),2),1,256)',linspace(Colors(c(s),3),1,256)'];

figure('Position', [500 1000 300 800]);

HM = heatmap(Datasets{s},SN,SA,'Colormap',flipud(CL),'ColorbarVisible','off','ColorLimits',[min(so),max(so)]);
HM.CellLabelFormat = '%.2f';

set(gca,'fontname','Palatino','fontsize',16)

%% closeness

clear,clc

addpath('functions/');
addpath('data/');
addpath('data/PUD');

Datasets = {'ENG','GER','FRE','ITA','SPA'};

M = zeros(20,20,5);

for s = 1:5

    load(strcat(Datasets{s},'.mat'))

    Names = L(:,1);
    n = size(L,1);

    M(:,:,s) = mean(D,3);

end

A = [4,7,18,9,11,6,15,17,3,14,16,8,1,2,5,10,12,13,19,20];

i = A(13);

od = zeros(20,5);
nd = cell(20,5);

nnd = cell(6,5);

for c = 1:5

    odt = M(:,i,c);
    [odt,oid] = sort(odt);
    od(:,c) = odt;
    nd(:,c) = Names(oid);

    nnd(:,c) = nd([2:4,end-2:end],c);

end

tod = od([2:4,end-2:end],:)';
tnnd = nnd';
