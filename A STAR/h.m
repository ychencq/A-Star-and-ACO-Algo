function hcost = h( m,goal )

%Use Manhattan distance
hcost =10* abs(  m(1)-goal(1)  )+10*abs(  m(2)-goal(2)  );

end