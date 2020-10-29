function [flag,targetInd]=FindList(m,open,close)
%{
¨ç?¥\¯à¡G
¦pªG¬Û•Ø?˜ò(m¦s?¨ä«H®§)  ¤w‰r¦bCloselist¤¤¡A?flag = 1  targetInd = ¨ä©Ò¦bcloseªº¦æ?¡A¥Î?©w¦ì
¦pªG¬Û•Ø?˜ò(m¦s?¨ä«H®§)    ¤£¦bOpenlist ¤¤¡A?flag = 2  targetInd = []
¦pªG¬Û•Ø?˜ò(m¦s?¨ä«H®§)  ¤w‰r¦bOpenlist ¤¤¡A?flag = 3  targetInd = ¨ä©Ò¦bopenªº¦æ?¡A¥Î?©w¦ì
%}

%¦pªGopenlist?ªÅ¡A?¤@©w¤£¦bopenlist¤¤
if  isempty(open)
    flag = 2;
    targetInd = [];
    
else  %open¤£?ªÅ?¡A»Ý­n?¬d¬O§_¦bopenlist¤¤
    %¹M?openlist¡A?¬d¬O§_¦bopenlist¤¤
    for io = 1:length(open(:,1))
        if isequal(  m(1:2) , open(io,1:2)  )  %¦bOpenlist¤¤
            flag = 3;
            targetInd = io;
            return;
        else  %¤£¦bOpenlist¤¤
            flag = 2;
            targetInd = [];
        end
    end
end

%¦pªG¯à¨ì?¤@¨B¡A?©ú¡G  ¤@©w¤£¦bOpenlist¤¤    ¨º¤\»Ý­n§P?¬O§_¦bcloselist¤¤

%¹M?Closelist¡]ª`·Ncloselist¤£¥i¯à?ªÅ¡^
for ic = 1:length(close(:,1))
    if isequal(  m(1:2) , close(ic,1:2)  )  %¦bCloselist¤¤
        flag = 1;
        targetInd = ic;
        return;%¦bCloselist¤¤ª½±µreturn
    end
end

end










%{
¥H¤U¥N?¥Î¤_??¦¹¨ç?ªº¥¿ÚÌ©Ê¡G
open = [ 1,1 ; 2,2; 3,3; 4,4; 5,5; 6,6; 7,7; 8,8; 9,9];
%?¦³¤@Ïú±¡úG¡Gopen¦Cªí?ªÅ
close = [1,2 ; 2,3; 3,4; 4,5; 5,6; 6,7; 7,8];

m1 = [5,6]; %¦bclose¤¤ ¦¹?flag??1 targetInd ?? 5
m2 = [0,0]; %¤£¦bopen¤¤¡A ¦¹?flag??2 targetInd ??ªÅ[]
m3 = [3,3]; %¦bopen¤¤ ¦¹?flag??3  targetInd ?? 3

[flag,targetInd] = FindList(m1,open,close)  %flag = 1 targetInd = 5
[flag,targetInd] = FindList(m2,open,close)  %flag = 2 targetInd = []
[flag,targetInd] = FindList(m3,open,close)  %flag = 3 targetInd = 3
%}
