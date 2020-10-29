function main() 
G=[0 0 0 0 0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0; 
   0 1 1 0 0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0; 
   0 1 1 0 0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0; 
   0 0 0 0 0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0; 
   0 0 0 0 0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0; 
   0 0 0 0 0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0; 
   0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
   0 0 0 0 0 0 0 0 0 0 1 1 1 1 0 0 0 0 0 0; 
   0 0 0 0 0 0 0 0 0 0 1 1 1 1 0 0 0 0 0 0; 
   0 0 0 0 0 0 0 0 0 0 1 1 1 1 0 0 0 0 0 0; 
   0 0 0 0 0 0 0 1 1 1 1 1 1 1 0 0 0 0 0 0; 
   0 0 0 0 0 0 0 1 1 1 1 1 1 1 0 0 0 0 0 0; 
   0 0 0 0 0 0 0 0 0 0 0 1 1 1 0 1 1 1 1 0; 
   0 0 0 0 0 0 0 0 0 0 0 1 1 1 0 1 1 1 1 0; 
   1 1 1 1 0 0 0 0 0 0 0 1 1 1 0 1 1 1 1 0; 
   1 1 1 1 0 0 1 1 1 1 1 1 0 0 0 0 0 0 0 0; 
   0 0 0 0 0 0 1 1 1 1 1 1 0 0 0 0 0 1 1 0; 
   0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 0 0 1 1 0; 
   0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0; 
   0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0;];
MM=size(G,1);                  	  
% Tau initial elements
Tau=ones(MM*MM,MM*MM);        
Tau=8.*Tau; 
%number of rounds
K=100;                       	 
%number of ants
M=50;                        	   
%Start point
S=381;                         	  
%Goal point
%E=MM*MM;  
E = 280;
Alpha=1;                      	   % Alpha: setting
Beta=7;                       	   % Beta: setting
Rho=0.3 ;                      	   % Rho: information decay parameter
Q=1;                               % Q: information strength parameter 
minkl=inf;       % Min length totally (to record best result)
mink=0;          % Min's round number
minl=0;          % Min's ant

D=G2D(G);  % A necessary component for ACO in matlab, a connection matrix
%N: complexity

N=size(D,1);               
 a=1;                     %side length
 Ex=a*(mod(E,MM)-0.5);    %x axis of goal point
 if Ex==-0.5 
Ex=MM-0.5; 
end 
Ey=a*(MM+0.5-ceil(E/MM));  %x axis of goal point
 
Eta=zeros(N);             %tau matrix  1/dij


 for i=1:N 
 ix=a*(mod(i,MM)-0.5); 
   if ix==-0.5 
   ix=MM-0.5; 
   end 
iy=a*(MM+0.5-ceil(i/MM));  
   if i~=E 
   Eta(i)=1/((ix-Ex)^2+(iy-Ey)^2)^0.5; 
   else 
   Eta(i)=100; 
   end 
 end

% Use cells to store the path of each ant each round
ROUTES=cell(K,M);     % path
PL=zeros(K,M);         %length


tic
% K round, each time send M ants
for k=1:K 
for m=1:M 

%Initialization
W=S;                  %start point
Path=S;                %path : start point S
PLkm=0;               % path length: 0
TABUkm=ones(N);       % Tabu initializtion 
TABUkm(S)=0;          % start point 
DD=D;                 %Initial D
%Next avaliable node
DW=DD(W,:); 
DW1=find(DW); 
for j=1:length(DW1) 
   if TABUkm(DW1(j))==0 
      DW(DW1(j))=0; 
  end 
end 
LJD=find(DW); 
Len_LJD=length(LJD);%number of avaliable nodes

% Ants do not meet food or trapped  
while W~=E&&Len_LJD>=1 

%prob.
PP=zeros(Len_LJD); 
for i=1:Len_LJD 
    PP(i)=(Tau(W,LJD(i))^Alpha)*((Eta(LJD(i)))^Beta); 
end 
sumpp=sum(PP); 

%Prob distribution
PP=PP/sumpp;
Pcum(1)=PP(1); 
  for i=2:Len_LJD 
  Pcum(i)=Pcum(i-1)+PP(i); 
  end 
% selection
Select=find(Pcum>=rand); 
to_visit=LJD(Select(1)); 
%update
Path=[Path,to_visit];       % Update path
PLkm=PLkm+DD(W,to_visit);    %Update length
W=to_visit;                   %move to next node
   for kk=1:N 
      if TABUkm(kk)==0 
      DD(W,kk)=0; 
      DD(kk,W)=0; 
      end 
   end 
TABUkm(W)=0;				%delete from tabu table (k(times)m(ant))
 DW=DD(W,:); 
DW1=find(DW); 
for j=1:length(DW1) 
    if TABUkm(DW1(j))==0 
       DW(j)=0; 
    end 
  end 
LJD=find(DW); 
Len_LJD=length(LJD);% number of avaliable node
 end 
%record k th time, m ant's path
 ROUTES{k,m}=Path; 
   if Path(end)==E 
      PL(k,m)=PLkm; 
      if PLkm<minkl 
          mink=k;minl=m;minkl=PLkm; 
      end 
   else 
      PL(k,m)=0; 
   end 
end















%Update information message
Delta_Tau=zeros(N,N);%initialization
   for m=1:M 
     if PL(k,m)  
        ROUT=ROUTES{k,m}; 
        TS=length(ROUT)-1;
         PL_km=PL(k,m); 
        for s=1:TS 
          x=ROUT(s); 
          y=ROUT(s+1); 
          Delta_Tau(x,y)=Delta_Tau(x,y)+Q/PL_km; 
          Delta_Tau(y,x)=Delta_Tau(y,x)+Q/PL_km; 
        end 
     end 
  end 
Tau=(1-Rho).*Tau+Delta_Tau;%from formula. new information message
end











t1 = toc


% Plot the map
plotif=1;

% Plot converge curve
if plotif==1 
    minPL=zeros(K); 
   for i=1:K 
     PLK=PL(i,:); 
     Nonzero=find(PLK); 
     PLKPLK=PLK(Nonzero); 
     minPL(i)=min(PLKPLK); 
   end 
figure(1) 
plot(minPL); 
hold on 
grid on 
title('Converge curve'); 
xlabel('iteration'); 
ylabel('Toal Length'); 

% plot path graph
figure(2) 
axis([0,MM,0,MM]) 
for i=1:MM 
for j=1:MM 
if G(i,j)==1 
x1=j-1;y1=MM-i; 
x2=j;y2=MM-i; 
x3=j;y3=MM-i+1; 
x4=j-1;y4=MM-i+1; 
fill([x1,x2,x3,x4],[y1,y2,y3,y4],[0.2,0.2,0.2]); 
hold on 
else 
x1=j-1;y1=MM-i; 
x2=j;y2=MM-i; 
x3=j;y3=MM-i+1; 
x4=j-1;y4=MM-i+1; 
fill([x1,x2,x3,x4],[y1,y2,y3,y4],[1,1,1]); 
hold on 
end 
end 
end 
hold on 
title('ACO path planning'); 
xlabel('x'); 
ylabel('y');
ROUT=ROUTES{mink,minl}; 
LENROUT=length(ROUT); 
Rx=ROUT; 
Ry=ROUT; 
for ii=1:LENROUT 
Rx(ii)=a*(mod(ROUT(ii),MM)-0.5); 
if Rx(ii)==-0.5 
Rx(ii)=MM-0.5; 
end 
Ry(ii)=a*(MM+0.5-ceil(ROUT(ii)/MM)); 
end 
plot(Rx,Ry) 
end

% Not to show, path at each round
plotif2=0;
if plotif2==1 
figure(3) 
axis([0,MM,0,MM]) 
for i=1:MM 
for j=1:MM 
if G(i,j)==1 
x1=j-1;y1=MM-i; 
x2=j;y2=MM-i; 
x3=j;y3=MM-i+1; 
x4=j-1;y4=MM-i+1; 
fill([x1,x2,x3,x4],[y1,y2,y3,y4],[0.2,0.2,0.2]); 
hold on 
else 
x1=j-1;y1=MM-i; 
x2=j;y2=MM-i; 
x3=j;y3=MM-i+1; 
x4=j-1;y4=MM-i+1; 
fill([x1,x2,x3,x4],[y1,y2,y3,y4],[1,1,1]); 
hold on 
end 
end 
end 
for k=1:K 
PLK=PL(k,:); 
minPLK=min(PLK); 
pos=find(PLK==minPLK); 
m=pos(1); 
ROUT=ROUTES{k,m}; 
LENROUT=length(ROUT); 
Rx=ROUT; 
Ry=ROUT; 
for ii=1:LENROUT 
Rx(ii)=a*(mod(ROUT(ii),MM)-0.5); 
if Rx(ii)==-0.5 
Rx(ii)=MM-0.5; 
end 
Ry(ii)=a*(MM+0.5-ceil(ROUT(ii)/MM)); 
end 
plot(Rx,Ry) 
hold on 
end 
end










function D=G2D(G)
l=size(G,1); 
D=zeros(l*l,l*l); 
for i=1:l 
    for j=1:l 
        if G(i,j)==0 
            for m=1:l 
                for n=1:l 
                    if G(m,n)==0 
                        im=abs(i-m);jn=abs(j-n); 
                        if im+jn==1||(im==1&&jn==1) 
                        D((i-1)*l+j,(m-1)*l+n)=(im+jn)^0.5; 
                        end 
                    end 
                end 
            end 
        end 
    end 
end
