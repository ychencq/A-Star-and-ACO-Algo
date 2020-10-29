function  plot_map( map,obstacle,open,close )

%œ{¥X»Ù”Â˜ò¡B°_©l˜ò¡B?˜ò
if length(obstacle)>=1
    plot(obstacle(:,1),obstacle(:,2),'sk','MarkerFaceColor','k');hold on;
end
plot(map.start(1),map.start(2),'*r');hold on;
plot(map.goal(1),map.goal(2),'*g');hold on;

axis equal;
axis([-1.5,map.XYMAX+2.5,-1.5,map.XYMAX+2.5]);

%?¨îÊI®æ
for i = 1:map.XYMAX+3
   line([-0.5,map.XYMAX+1.5],[i-1.5,i-1.5]);
end

for j = 1:map.XYMAX+3
   line([j-1.5,j-1.5],[-0.5,map.XYMAX+1.5]);
end
pause(0.1);
title('A star path planning');
%?¨î?˜ò

plot(close(:,1),close(:,2),'sr','MarkerFaceColor','r');
hold on;
%pause(0.1);
plot(open(:,1),open(:,2),'sg','MarkerFaceColor','g');
hold on;
%pause(0.1);

end
