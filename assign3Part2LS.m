clc;
clear all; 
close all; 

%% 
global Adjacency; 

Adjacency = [0  1  3  7 ;
             1  0  1 inf ;
             3  1  0  2 ;
             7 inf 2  0 ];
  
%%
D0 = rinit0();
D1 = rinit1();
D2 = rinit2();
D3 = rinit3();


%%
MinCost0 = rtupdate0(D0);
MinCost1 = rtupdate1(D1);
MinCost2 = rtupdate2(D2);
MinCost3 = rtupdate3(D3);
%%

D = [MinCost0 ; MinCost1; MinCost2; MinCost3]
%%
function D = rinit0()
global Adjacency; 
    source = 0; 
    n = [0 1 1 1];
    D = Adjacency; %topology and adjacency matrix is known by all the nodes.
end


function D = rinit1()
global Adjacency; 
    source = 1; 
    n = [1 0 1 0];
    D = Adjacency; %topology and adjacency matrix is known by all the nodes.
end


function D = rinit2()
global Adjacency; 
    source = 2; 
    n = [1 1 0 1];
    D = Adjacency; %topology and adjacency matrix is known by all the nodes.
end


function D = rinit3()
global Adjacency; 
    source = 3; 
    n = [1 0 1 0];
    D = Adjacency; %topology and adjacency matrix is known by all the nodes.
end


function mincost = rtupdate0(D)
source = 0; 
mincost = LinkState(D, source+1);

end

function mincost = rtupdate1(D)
source = 1; 
mincost = LinkState(D, source+1);

end

function mincost = rtupdate2(D)
source = 2; 
mincost = LinkState(D, source+1);

end

function mincost = rtupdate3(D)
source = 3; 
mincost = LinkState(D, source+1);

end

function distance = LinkState(graph, start)

N = 4; 
distance(1:N) = inf ; 

visited(1:N) = 0; 

distance(start) = 0;

while sum(visited) < N
   candidates(1:N) = inf;
   
   for i = 1:N
       if visited(i) == 0
           candidates(i) = distance(i);
       end
       
   end
   
   [NowDist, NowPos] = min(candidates); 
   
   for i = 1:N
       newDist = NowDist + graph(NowPos, i);
       if newDist < distance(i)
           distance(i) = newDist; 
       end
   end
   
   visited (NowPos) = 1; 
    
    
    
end

end
