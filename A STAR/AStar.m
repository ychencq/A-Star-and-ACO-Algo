function path=AStar(obstacle,map)

%{

1. Put the starting point into the Openlist
2. repeat the following procedure:
  
  a. Do we got the goal position 
       if : The final node is in Openlist, then we already find the path
       if: the openlist is empty, then there is no desired path

  b. Use the value in the Col 3 in Openlist (f= g+h) to do sorting, find
     the smallest f and this point
  c. Move the selected point into the closelist, it is the new current node
  d. Refer to the 8 surrounding points near the current point
    if: not reachable, do nothing
    if: in closelist, do nothing
    if: not in openlist, add it into openlist, record its f value，
    if: already in the openlist, check -> can we get a better f value 
          if yes: the answer is yes, set the current node as parent node, and
          update the F AND G value
          else: do nothing

3. We finally find the path or there is no path, save the path
%}




path=[];
%OpenList
open=[];
%CloseList
close=[];
%findFlag: does the loop finish?
findFlag=false;

%================1======================

% Open Structure:  x-axis, y-axis, F value (cost+ h function), cost (G function), 
% parent's x-axis, parent's y-axis
open =[map.start(1), map.start(2) , 0+h(map.start,map.goal) , 0 , map.start(1) , map.start(2)];

% for check the surrounding 8 nodes
next=MotionModel();

%=======================2==============================

while ~findFlag
    


%------Is open empty?------
    if isempty(open(:,1))
        disp('there is no path to go');
        return;
    end
    
    %is in openlist?
    [isopenFlag,Id]=isopen(map.goal,open);
    if isopenFlag
        disp('Found');
        close = [open(Id,:);close]
        findFlag=true;
        break;
    end
    %------------------sort the smallest F
    [Y,I] = sort(open(:,3)); %
    open=open(I,:);% extract it
    
    %------------------put it into close
    close = [open(1,:);close];
    current = open(1,:);
    open(1,:)=[];%removed, leave empty
    
    %--------------------check the 8 surrounding points------------------------
    for in=1:length(next(:,1))
        
        %
        m=[current(1,1)+next(in,1) , current(1,2)+next(in,2) , 0 , 0 , 0 ,0]; 
        m(4)=current(1,4)+next(in,3); % m(4) : g value
        m(3)=m(4)+h(m(1:2),map.goal);% m(3)  f = g + h  
        
        %>> if not reachable, do nothing
        if isObstacle(m,obstacle)
            continue;
        end
        
        %flag == 1： IN Closelist中  targetInd = index of row in close
        %flag == 2： Not in Openlist中   targetInd = []
        %flag == 3： IN Openlist中   targetInd = index of rowin open
        [flag,targetInd]=FindList(m,open,close);
        
        %>> in Closelist, ignore
        if flag==1 
            continue;
        %>>not in Openlist中，add into Openlist,set parent node
        elseif flag==2 
            m(5:6)=[current(1,1),current(1,2)];
            open = [open;m];% add into openlist
        %>>In Openlist, check F    
        else
            % if better
            if m(3) < open(targetInd,3)
                
                m(5:6)=[current(1,1),current(1,2)];%set parent
                open(targetInd,:) = m;%update in Openlist
            end
        end
        
        %
    end
    plot_map(map,obstacle,open,close);
    

end

% find path
path=GetPath(close,map.start);
