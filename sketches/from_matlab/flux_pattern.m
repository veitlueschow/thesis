clear;

amp =1;

phi = linspace(0,2*pi,100);
f = -amp*cos(2*phi)+1;
g = -2*amp*cos(2*phi)+1;

%% 

zero = zeros(1,length(phi));
one = zero+1;
x= rad2deg(phi);
f2=figure; 
set(f2, 'Position', [300, 150, 1200, 500]);
set(f2,'PaperPositionMode','auto');
set(f2,'PaperOrientation','landscape');
p1 = plot(x,f,x,one,'--','color','black','linewidth',1.5);
hold on all;
p3= plot(x,g,'color','r','linewidth',1.5);
% hold on;
p4 = plot(x,zero,'-','LineWidth',2,'color','black');
legend([p1(1),p3],'Amp=1','Amp=2','location','north')

text(370,1,'q_{mean}','fontsize',15);
text(370,0,'0','fontsize',15);
hold off;

xlim([0, 360]);
ax=gca;
ax.XTick = [0 90 180 270 360];
ax.XTickLabel = {'0\circ', '90\circ', '180\circ', '270\circ', '360\circ' };
ylim([-1.5,3]);
set (ax,'yticklabel',[]);
xlabel('Longitude');
ylabel(' Core-mantle flux');

patch([0 360 360 0],[-1.5 -1.5 0 0],'blue','facealpha',0.2,'linestyle','none')
set(gca,'fontsize',18);


