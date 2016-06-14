
addpath(genpath('~/Documents/master/masterarbeit/matlab'));

clear;
iscase = 'q2_5e-4'

load(['../vel/' iscase '_vel']);
% Nlong = length(lon);
phi=linspace(0,2*pi,Nlong);


% Further Geometry 

[r_,phi_]     = meshgrid(r,phi);
[x_dat,y_dat] = pol2cart(phi_,r_);

Nlat=length(lat);
ilat=Nlat/2;
NR = length(r);
%% PLOTS
ilat=Nlat/2;

f1=figure('name',[iscase ' Contour-Plot'], 'visible','on');
f1.Units='centimeters';
set(f1, 'Position', [1, 3, 15.,15.]);
set(f1,'PaperPositionMode','auto');
set(f1,'PaperOrientation','landscape');

[r_,phi_]     = meshgrid(r,phi);
[x_dat,y_dat] = pol2cart(phi_,r_);

contourf(x_dat,y_dat,squeeze(V.mean.r(:,:,ilat))',50,'linestyle','none');
colormap bluewhitered(500);
% caxis([-120 ,120]);

% DRAW inner and outer circle
[phi_,r_]     = meshgrid(phi,r(NR));
[x_dat,y_dat] = pol2cart(phi_,r_);
line(x_dat,y_dat,'color','black','linesmoothing','on');
hold on;

[phi_,r_]     = meshgrid(phi,r(1));
[x_dat,y_dat] = pol2cart(phi_,r_);
line(x_dat,y_dat,'color','black');
hold on;

% Labels degree
[phi_,r_]     = meshgrid(phi(5),(r(NR)+0.15));
[x_dat,y_dat] = pol2cart(phi_,r_);
text(x_dat,y_dat,'0°','fontsize',20,'rotation',270)
hold on;

[phi_,r_]     = meshgrid(phi(Nlong/4+5),(r(NR)+0.13));
[x_dat,y_dat] = pol2cart(phi_,r_);
text(x_dat,y_dat,'90°','fontsize',20)
hold on;

[phi_,r_]     = meshgrid(phi(Nlong/2+6),(r(NR)+0.15));
[x_dat,y_dat] = pol2cart(phi_,r_);
text(x_dat,y_dat,'180°','fontsize',20,'rotation',90)
hold on;

[phi_,r_]     = meshgrid(phi(3*Nlong/4-3),(r(NR)+0.15));
[x_dat,y_dat] = pol2cart(phi_,r_);
text(x_dat,y_dat,'270°','fontsize',20)
hold on;

% Bars
[phi_,r_]     = meshgrid(phi(1),(r(NR)+0.04));
[x1,y1] = pol2cart(phi_,r_);
[phi_,r_]     = meshgrid(phi(1),(r(NR)-0.04));
[x2,y2] = pol2cart(phi_,r_);
line([x1,x2],[y1,y2], 'linewidth',1.5, 'color','black');
hold on;

[phi_,r_]     = meshgrid(phi(Nlong/4+1),(r(NR)+0.04));
[x1,y1] = pol2cart(phi_,r_);
[phi_,r_]     = meshgrid(phi(Nlong/4+1),(r(NR)-0.04));
[x2,y2] = pol2cart(phi_,r_);
line([x1,x2],[y1,y2], 'linewidth',1.5, 'color','black');
hold on;

[phi_,r_]     = meshgrid(phi(Nlong/2+1),(r(NR)+0.04));
[x1,y1] = pol2cart(phi_,r_);
[phi_,r_]     = meshgrid(phi(Nlong/2+1),(r(NR)-0.04));
[x2,y2] = pol2cart(phi_,r_);
line([x1,x2],[y1,y2], 'linewidth',1.5, 'color','black');
hold on;

[phi_,r_]     = meshgrid(phi(3*Nlong/4+1),(r(NR)+0.04));
[x1,y1] = pol2cart(phi_,r_);
[phi_,r_]     = meshgrid(phi(3*Nlong/4+1),(r(NR)-0.04));
[x2,y2] = pol2cart(phi_,r_);
line([x1,x2],[y1,y2], 'linewidth',1.5, 'color','black');
hold on;

% t = title(['Ttotal'],'interpreter','none');
% set(t,'FontSize',15);
colorbar('southoutside','fontsize',20);
shading flat;
axis off;
axis square;

