function flag = isObstacle( m,obstacle )

%�P??��m�O�_?�ٔ�A�p�G�O�N��?1�A���O�N��^0
for io=1:length(obstacle(:,1))
    if isequal(obstacle(io,:),m(1:2))
        flag=true;
        return;
    end
end
flag=false;
end
