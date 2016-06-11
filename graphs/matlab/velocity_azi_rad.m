
addpath(genpath('~/Documents/master/masterarbeit/matlab'));

clear;
iscase = 'q2_200_d080'

load([iscase '_vel']);
phi=linspace(0,2*pi,Nlong);


% Further Geometry 

[r_,phi_]     = meshgrid(r,phi);
[x_dat,y_dat] = pol2cart(phi_,r_);

Nlat=length(lat);
ilat=Nlat/2;
%% PLOTS
ilat=Nlat/2;

f1=figure('name','Contour-Plot', 'visible','on');
f1.Units='centimeters';
set(f1, 'Position', [1, 3, 15.,15.]);
set(f1,'PaperPositionMode','auto');
set(f1,'PaperOrientation','landscape');

contour(x_dat,y_dat,squeeze(V.mean.p(:,:,ilat))',30);
t=title([name ' Azimuthal Velocity'],'interpreter','none');
set(t,'FontSize',12);
axis square;
shading flat;
h = colorbar('eastoutside');
