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

K = dm2dl(E);
M = max(K);

%% plot distributions

f = figure('Position', [0 1000 980 600]);

for i = 1:n

subplot(5,4,i)

histogram(K(:,i),linspace(0,40,101), 'Normalization','probability', 'FaceColor',Colors(c(s),:));

xlim([0,40])
ylim([0,0.1])
title(Names{i})

hold on
xline(M,'LineWidth',2,'Alpha',0.05)
xline(M(i),'LineWidth',2)

grid on 
box on

set(gca,'fontname','Palatino','fontsize',fs)

end

fig=axes(f,'visible','off'); 
fig.XLabel.Visible='on';
fig.YLabel.Visible='on';
fig.Title.Visible='on';
ylabel(fig,'Proportion','Position',[-0.04,0.5]);

set(fig,'fontname','Palatino','fontsize',fs)


%% 

clear,clc

addpath('functions/');
addpath('data/');
addpath('data/PUD');

Datasets = {'ENG','GER','FRE','ITA','SPA'};

c = [1,3,4,5,2]; %color order


Colors = lines(7); %load colors
fs = 16; %set font size


for s =  1:5

load(strcat(Datasets{s},'.mat'))

Names = L(:,1);
n = size(L,1);

K = dm2dl(E);

Dia(:,s) = max(K)';
Mea(:,s) = mean(K)';

end

%%

for s = 1:5

f1 = figure('Position', [0 1000 180 600]);

CL = [linspace(Colors(c(s),1),1,256)',linspace(Colors(c(s),2),1,256)',linspace(Colors(c(s),3),1,256)'];

HM = heatmap(Datasets{s},Names,Dia(:,s),'Colormap',flipud(CL),'ColorbarVisible','off');
HM.CellLabelFormat = '%.2f';

if s == 1
xlabel("Dataset")
end

set(gca,'fontname','Palatino','fontsize',16)

% saveas(f1,strcat(Datasets{s},'_d.svg'))

f2 = figure('Position', [0 1000 180 600]);

CL = [linspace(Colors(c(s),1),1,256)',linspace(Colors(c(s),2),1,256)',linspace(Colors(c(s),3),1,256)'];

HM = heatmap(Datasets{s},Names,Mea(:,s),'Colormap',flipud(CL),'ColorbarVisible','off');
HM.CellLabelFormat = '%.2f';

if s == 1
xlabel("Diameter Mean pairwise sentence distance")
end

set(gca,'fontname','Palatino','fontsize',16)

% saveas(f2,strcat(Datasets{s},'_m.svg'))


end

