function [flag,targetInd]=FindList(m,open,close)
%{
��?�\��G
�p�G�ە�?��(m�s?��H��)  �w�r�bCloselist���A?flag = 1  targetInd = ��Ҧbclose����?�A��?�w��
�p�G�ە�?��(m�s?��H��)    ���bOpenlist ���A?flag = 2  targetInd = []
�p�G�ە�?��(m�s?��H��)  �w�r�bOpenlist ���A?flag = 3  targetInd = ��Ҧbopen����?�A��?�w��
%}

%�p�Gopenlist?�šA?�@�w���bopenlist��
if  isempty(open)
    flag = 2;
    targetInd = [];
    
else  %open��?��?�A�ݭn?�d�O�_�bopenlist��
    %�M?openlist�A?�d�O�_�bopenlist��
    for io = 1:length(open(:,1))
        if isequal(  m(1:2) , open(io,1:2)  )  %�bOpenlist��
            flag = 3;
            targetInd = io;
            return;
        else  %���bOpenlist��
            flag = 2;
            targetInd = [];
        end
    end
end

%�p�G���?�@�B�A?���G  �@�w���bOpenlist��    ���\�ݭn�P?�O�_�bcloselist��

%�M?Closelist�]�`�Ncloselist���i��?�š^
for ic = 1:length(close(:,1))
    if isequal(  m(1:2) , close(ic,1:2)  )  %�bCloselist��
        flag = 1;
        targetInd = ic;
        return;%�bCloselist������return
    end
end

end










%{
�H�U�N?�Τ_??����?�����̩ʡG
open = [ 1,1 ; 2,2; 3,3; 4,4; 5,5; 6,6; 7,7; 8,8; 9,9];
%?���@�����G�Gopen�C��?��
close = [1,2 ; 2,3; 3,4; 4,5; 5,6; 6,7; 7,8];

m1 = [5,6]; %�bclose�� ��?flag??1 targetInd ?? 5
m2 = [0,0]; %���bopen���A ��?flag??2 targetInd ??��[]
m3 = [3,3]; %�bopen�� ��?flag??3  targetInd ?? 3

[flag,targetInd] = FindList(m1,open,close)  %flag = 1 targetInd = 5
[flag,targetInd] = FindList(m2,open,close)  %flag = 2 targetInd = []
[flag,targetInd] = FindList(m3,open,close)  %flag = 3 targetInd = 3
%}
