function flag = isObstacle( m,obstacle )

%§P??˜òm¬O§_?»Ù”Â˜ò¡A¦pªG¬O´Nªð?1¡A¤£¬O´Nªð¦^0
for io=1:length(obstacle(:,1))
    if isequal(obstacle(io,:),m(1:2))
        flag=true;
        return;
    end
end
flag=false;
end
