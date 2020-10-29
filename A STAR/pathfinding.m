clear;
clc;
disp('A Star Path Planing')
map.XYMAX=20;
map.start=[1,2];  %Start point
map.goal=[20,6];  %End point

obstacle=GetBoundary(map);% set boundary
%nObstacle=100;% the number of obstacle I add randomly
%obstacle=GetObstacle(nObstacle,obstacle,map);% add new obstable 
obstacle = [obstacle;2,19; 2,18; 3,19; 3,18; 1,5 ;1,6;];
obstacle = [obstacle;2,5; 2,6; 3,5; 3,6; 4,5 ;4,6;];% no path
obstacle = [obstacle;7,15; 7,16; 7,17; 7,18; 7,19 ;7,20;];% no path
obstacle = [obstacle;8,15; 8,16; 8,17; 8,18; 8,19 ;8,20;];% no path
obstacle = [obstacle;9,15; 9,16; 9,17; 9,18; 9,19 ;9,20;];% no path
obstacle = [obstacle;7,4; 7,5; 8,4; 8,5; 9,4 ;9,5;];% no path
obstacle = [obstacle;10,4; 10,5; 11,4; 11,5; 12,4 ;12,5;];% no path
obstacle = [obstacle;11,1; 11,2; 11,3; 12,1; 12,2 ;12,3;];% no path
obstacle = [obstacle;8,9; 8,10; 9,9; 9,10; 10,9 ;10,10;];% no path
obstacle = [obstacle;11,9; 11,10; 12,9; 12,10; 13,9 ;13,10;14,9 ;14,10;];% no path
obstacle = [obstacle;11,11; 11,12; 11,13; 12,11; 12,12 ;12,13;13,11 ;13,12; 13,13;];% no path
obstacle = [obstacle;14,11; 14,12; 14,13; ];% no path
obstacle = [obstacle;16,6; 16,7; 16,8; 17,6; 17,7 ;17,8;18,6 ;18,7; 18,8; 19,6; 19,7; 19,8;];% no path
obstacle = [obstacle;18,3; 19,3; 18,4; 19,4; ];% no path
obstacle = [obstacle;12,6; 12,7; 12,8; 13,6; 13,7; 13,8; 14,6; 14,7; 14,8;];


%
tic;
path=AStar(obstacle,map)% the core algorithm --- A star
Astar_time = toc



%  Plot the path
if length(path)>=1
    plot(path(:,1),path(:,2),'-b','LineWidth',4);hold on;
end




%obstacle = [obstacle;4,1; 4,2; 4,3; 4,4; 3,4 ;2,4;];% no path
%obstacle = [obstacle;1,2;2,1;2,2];% no path
%obstacle = [obstacle;1,3;2,3;3,3;3,2;3,1];%no path