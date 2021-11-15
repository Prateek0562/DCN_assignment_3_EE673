clc
clear all; 
close all; 

%%

global X;
global buffer; 
global Adjacency; 

Adjacency = [0  1  3  7 ;
             1  0  1 inf ;
             3  1  0  2 ;
             7 inf 2  0 ];
         
X = [];

%buffer = inf.*[Adjacency];  

D0 = rinit0();
D1 = rinit1();
D2 = rinit2();
D3 = rinit3();

%%

while size(X,1) ~=0
   pkt_info = X(1,:); 
   rtpkt = struct('source', pkt_info(1), 'dest', pkt_info(2), 'mincost', pkt_info(3:end));
   switch pkt_info(2)
       case 0 
           D0 = rtupdate0(rtpkt,D0); 
       case 1
           D1 = rtupdate1(rtpkt,D1);
       case 2
           D2 = rtupdate2(rtpkt,D2);
       case 3
           D3 = rtupdate3(rtpkt,D3);
           
   end
   X(1,:) = []; 
end
    
source = input('Enter the source node: ');
destination = input('Enter the destination node: ');

cost = D0(source+1, destination+1);
fprintf('Minimum cost: %d \n' , cost );

fprintf('The updated distance tables at each node are:')

D0
D1
D2
D3
    
    


         
%%
%functions

function dist = rinit0()
    global Adjacency; 
    source = 0; 
    n = [0 1 1 1];
    dist = [];
    for i = 1:4
        if i == source+1
            d = Adjacency(source+1,:); 
        else
            d = [inf inf inf inf]; 
        end
        dist = [dist;d ];
    end
    for i=1:4
        %rtpkt = struct('source', source, 'destination', i, 'mincost', dist);
        if n(i) == 1
            packet = [source i-1 dist(source+1,:)];
            tolayer(packet);
       % else
            %packet = [source i [inf inf inf inf]]; 
            %tolayer(packet);
        end
    end
    
end


function dist = rinit1()
    global Adjacency; 
    source = 1; 
    n = [1 0 0 1];
    dist = [];
    for i = 1:4
        if i == source+1
            d = Adjacency(source+1,:); 
        else
            d = [inf inf inf inf]; 
        end
        dist = [dist;d ];
    end 
    
    for i=1:4
        %rtpkt = struct('source', source, 'destination', i, 'mincost', dist);
        if n(i) == 1
            packet = [source i-1 dist(source+1,:)];
            tolayer(packet);
       % else
            %packet = [source i [inf inf inf inf]]; 
            %tolayer(packet);
        end
    end
    
end


function dist = rinit2()
   global Adjacency; 
    source = 2; 
    n = [1 1 0 1];
    dist = [];
    for i = 1:4
        if i == source+1
            d = Adjacency(source+1,:); 
        else
            d = [inf inf inf inf]; 
        end
        dist = [dist;d ];
    end 
    
    for i=1:4
        %rtpkt = struct('source', source, 'destination', i, 'mincost', dist);
        if n(i) == 1
            packet = [source i-1 dist(source+1,:)];
            tolayer(packet);
       % else
            %packet = [source i [inf inf inf inf]]; 
            %tolayer(packet);
        end
    end
    
end


function dist = rinit3()
    global Adjacency; 
    source = 3; 
    n = [1 0 1 0];
    dist = [];
    for i = 1:4
        if i == source+1
            d = Adjacency(source+1,:); 
        else
            d = [inf inf inf inf]; 
        end
        dist = [dist;d ];
    end
    
    for i=1:4
        %rtpkt = struct('source', source, 'destination', i, 'mincost', dist);
        if n(i) == 1
            packet = [source i-1 dist(source+1,:)];
            tolayer(packet);
       % else
            %packet = [source i [inf inf inf inf]]; 
            %tolayer(packet);
        end
    end
    
end


function updated_dist = rtupdate0(rtpkt, D)
global buffer
    source = 0; 
    n = [1 1 1 1];
    %updated_cost = [];
    cost = D(source+1,:); 
    
    
    p = rtpkt.source;
    distTable = rtpkt.mincost; 
    D(p+1,:) = distTable; 
    
    for i = 1:4 
        %if n(i) == 1
            cost2 = [];
            for j = 1:4
               % if i~=j
                     cost2 = [cost2; (cost(j)+D(j,i))]; 
               % end
            end
            mincost = min(cost2); 
            D(source+1,i) = mincost;
        %end
        %updated_cost(i) = min(D(i), distTable(p+1)+ distTable(i));
    end
    updated_dist = D;
    buffer(source+1,:) = D(source+1,:);
    
    if D(source+1,:) - cost == 0
    else
        for i = 1: 4
            if i ~= source+1
                tolayer([source i-1 D(source+1,:)]);
            end
        end
    end

end

 
function updated_dist = rtupdate1(rtpkt, D)
    source = 1; 
    n = [1 1 0 1];
    %updated_cost = [];
    cost = D(source+1,:); 
    
    
    p = rtpkt.source;
    distTable = rtpkt.mincost; 
    D(p+1,:) = distTable; 
    
    for i = 1:4 
       % if n(i) == 1
            cost2 = [];
            for j = 1:4
               % if i~=j
                     cost2 = [cost2; (cost(j)+D(j,i))]; 
               % end
            end
            mincost = min(cost2); 
            D(source+1,i) = mincost;
       % end
        %updated_cost(i) = min(D(i), distTable(p+1)+ distTable(i));
    end
    updated_dist = D;
    buffer(source+1,:) = D(source+1,:);
    
    if D(source+1,:) - cost == 0
    else
       for i = 1: 4
            if i ~= source+1
                tolayer([source i-1 D(source+1,:)]);
            end
        end
    end

end

function updated_dist = rtupdate2(rtpkt, D)
global buffer;
    source = 2; 
    n = [1 1 1 1];
    %updated_cost = [];
    cost = D(source+1,:); 
    
    
    p = rtpkt.source;
    distTable = rtpkt.mincost; 
    D(p+1,:) = distTable; 
    
    for i = 1:4 
       % if n(i) == 1
            cost2 = [];
            for j = 1:4
                %if i~=j
                     cost2 = [cost2; (cost(j)+D(j,i))]; 
               % end
            end
            mincost = min(cost2); 
            D(source+1,i) = mincost;
       % end
        %updated_cost(i) = min(D(i), distTable(p+1)+ distTable(i));
    end
    updated_dist = D;
    buffer(source+1,:) = D(source+1,:);
    
    if D(source+1,:) - cost == 0
    else
      for i = 1: 4
            if i ~= source+1
                tolayer([source i-1 D(source+1,:)]);
            end
        end 
    end

end


function updated_dist = rtupdate3(rtpkt, D)
global buffer
    source = 3; 
    n = [1 0 1 1];
    %updated_cost = [];
    cost = D(source+1,:); 
    
    
    p = rtpkt.source;
    distTable = rtpkt.mincost; 
    D(p+1,:) = distTable; 
    
    for i = 1:4 
        %if n(i) == 1
            cost2 = [];
            for j = 1:4
               % if i~=j
                     cost2 = [cost2; (cost(j)+D(j,i))]; 
              %  end
            end
            mincost = min(cost2); 
            D(source+1,i) = mincost;
       % end
        %updated_cost(i) = min(D(i), distTable(p+1)+ distTable(i));
    end
    updated_dist = D;
    buffer(source+1,:) = D(source+1,:);
    
    if D(source+1,:) - cost == 0
    else
      for i = 1: 4
            if i ~= source+1
                tolayer([source i-1 D(source+1,:)]);
            end
        end
    end

end

        

function []= tolayer(packet)
    global X; 
    global buffer; 
    %pkt_info = [packet(1) packet packet.mincost];
    X = [X; packet];
    buffer(packet(1)+1,:) = packet(3:end);

end