function [isopenFlag,Id] = isopen( node,open )

%§P??˜ò¬O§_¦bopen¦Cªí¤¤¡A¦bopen¤¤¡AisopenFlag = 1,¤£¦bopen¤¤¡AisopenFlag = 0 .¦}¤Ï¦^¯Á¤Þ­

isopenFlag = 0;
Id = 0;

%¦pªGopen¦Cªí?ªÅ¡A?¤£¦bopen¦Cªí¤¤
if  isempty(open)
    isopenFlag = 0;

else %open¦Cªí¤£?ªÅ?
    for i = 1:length( open(:,1) )
       if isequal(  node(1:2) , open(i,1:2)  )  %¦bOpenlist¤¤
            isopenFlag = 1;
            Id = i;
            return;
       end 
    end
end

end
