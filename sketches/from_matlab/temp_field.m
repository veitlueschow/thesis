clear;
addpath(genpath('~/Documents/master/masterarbeit/matlab'));


load('q2_200_d080_field');

%% compute conductive T-profile -------------------------------------------
phi      = linspace(0,2*pi,Nlong);
phi=phi';
aspect=0.35;
amp=1.5;

T.cond = zeros(NR,Nlong,Nlat);
T.grad = zeros(NR,Nlong,Nlat);


%loop over lat and long
for ir=1:NR
    [Tcoeff_22]=Tcoeff_conductive(2,2,aspect,amp,r(ir));
%     Tcoeff_22=1;
    [gradTcoeff_22]=gradTcoeff_conductive(2,2,aspect,amp,r(ir));
    for ilong=1:Nlong
        for ilat=1:Nlat
            % compute SH   
%             Y22=sqrt(15)/2*(sin((lat(ilat)+90)/180*pi)).^2*exp(2*i*(phi(ilong)-pi));
            Y22=(sin(teta(ilat))).^2*exp(2*i*phi(ilong));
    
            T.cond(ir,ilong,ilat)= 1/((aspect-1).^2*r(ir))+Tcoeff_22*Y22;
            T.grad(ir,ilong,ilat)=-1/ ( (aspect - 1).^2 * r(ir).^2  )+gradTcoeff_22*Y22;
        end
    end
end

% add conductive and dynamic solution


T.cond  = real(T.cond);

ilat=Nlat/2;

Tcond=T.cond;
Tgrad=T.grad;

%%

teta=teta-pi/2;
Nlong = length(lon);
phi      = linspace(0,2*pi,Nlong);
phi=phi';

[phi_,r_]     = meshgrid(phi,r);
[x_dat,y_dat] = pol2cart(phi_,r_);



%% PLOT
% clear f1;
ilat=Nlat/2;

% T.total = T.mean(:,:,:)+T.cond(:,:,:);
% T.total = T.total - min(min(min(T.total))); % Normalization is ok because of arbitrary integration constant

f1 = figure('Name','TEMPERATURE','NumberTitle','off');
set(f1, 'Position', [300, 150, 800, 1000]);


[phi_,r_]     = meshgrid(phi,r);
[x_dat,y_dat] = pol2cart(phi_,r_);
contourf(x_dat(:,:),y_dat(:,:),squeeze(double(T.cond(:,:,ilat))), 15,'edgecolor','none');
% colormap bluewhitered(100);
hold on;
axis square;
axis off;
caxis([0,5]);

colormap bluewhitered(100);

% DRAW inner and outer circle
[phi_,r_]     = meshgrid(phi,r(120));
[x_dat,y_dat] = pol2cart(phi_,r_);
line(x_dat,y_dat,'color','black','linesmoothing','on');
hold on;

[phi_,r_]     = meshgrid(phi,r(1));
[x_dat,y_dat] = pol2cart(phi_,r_);
line(x_dat,y_dat,'color','black');
hold on;

% Labels degree
[phi_,r_]     = meshgrid(phi(1),(r(NR)+0.07));
[x_dat,y_dat] = pol2cart(phi_,r_);
text(x_dat,y_dat,'0°','fontsize',20)
hold on;

[phi_,r_]     = meshgrid(phi(Nlong/4+3),(r(NR)+0.13));
[x_dat,y_dat] = pol2cart(phi_,r_);
text(x_dat,y_dat,'90°','fontsize',20)
hold on;

[phi_,r_]     = meshgrid(phi(Nlong/2+1),(r(NR)+0.45));
[x_dat,y_dat] = pol2cart(phi_,r_);
text(x_dat,y_dat,'180°','fontsize',20)
hold on;

[phi_,r_]     = meshgrid(phi(3*Nlong/4-2),(r(NR)+0.15));
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
% caxis([0.4 1.3]);

% hold off;
%
 print(f1,'-dpdf','-r1200','temp_field1.pdf'); 
% saveTightFigure(f1,'tempfield.pdf');

%% PLOT HAMMER


[phi_,teta_] = meshgrid(rad2deg(teta),rad2deg(phi));


f2 = figure('name', 'test');
set(f2, 'Position', [300, 150, 1200, 600]);
set(f2,'PaperPositionMode','auto');
set(f2,'PaperOrientation','portrait');
axes('xlim',[-3.3 3.3],'ylim',[-2.1 1.8]);

% create sky map using Hammer projection
axesm('MapProjection', 'aitoff', 'AngleUnits', 'degrees','grid','on','meridianlabel','on',...
    'mlinelocation',[0 45 90 135 180 225 270 315 360],'mlabelparallel',45, ...
    'maplonlimit',[0 360],'mlabellocation',[0 90 180 270],'fontsize',16 ...
    );
c = colorbar('southoutside','fontsize',20);
c.Position(4) = c.Position(4)*0.85;
c.Position(3) = c.Position(3)*0.9;
c.Position(1) = c.Position(1)+0.03;
c.Position(2) = c.Position(2)-0.015;

% plot point on sky
surfacem(phi_', teta_', squeeze(Tcond(110,:,:))');
shading flat;
framem('flinewidth',1);
% gridm
% mlabel('MlabelLocation',90)

% set(gca, 'box','off','xtick', [],'ytick', [],'color','none')
axis off;

saveas(f2,'temp_field2.png','png');