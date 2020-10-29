function obstacle=GetObstacle(nob,obstacle,map)
%Generate obstacles
ob=round(rand([nob,2])*map.XYMAX);
% remove if has start or goal point
removeInd=[];

for io=1:length(ob(:,1))
   if(isequal(ob(io,:),map.start) || isequal(ob(io,:),map.goal))
        removeInd=[removeInd;io];
    end  
end

% remove
ob(removeInd,:)=[];
% add
obstacle=[obstacle;ob];

