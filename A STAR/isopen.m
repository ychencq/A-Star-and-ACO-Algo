function [isopenFlag,Id] = isopen( node,open )

%�P??��O�_�bopen�C���A�bopen���AisopenFlag = 1,���bopen���AisopenFlag = 0 .�}�Ϧ^���ޏ�

isopenFlag = 0;
Id = 0;

%�p�Gopen�C��?�šA?���bopen�C��
if  isempty(open)
    isopenFlag = 0;

else %open�C��?��?
    for i = 1:length( open(:,1) )
       if isequal(  node(1:2) , open(i,1:2)  )  %�bOpenlist��
            isopenFlag = 1;
            Id = i;
            return;
       end 
    end
end

end
