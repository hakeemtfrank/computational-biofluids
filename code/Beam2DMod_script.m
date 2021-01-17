clear all
close all

%initial param
nodes = 8;                %number of x nodes
%Ny = 2;                 %number of y nodes

len = 1;                %length of beam
%height = 1;             %height of beam
ds=len/(nodes);          %distance between x nodes
dy=0;       %distance between y nodes
x = [0:ds:len-ds];         %vector of x nodes
y = zeros(size(x));      %vector of y nodes

kb=1500;                %spring beam constant
dt=1e-4;                %time step
tfinal =1;              %final time
nt = floor(tfinal/dt);  %number of time steps

%initial condition
v = zeros(nodes,2); %if initial cond. is 0
c = zeros(nodes,2); %if curvature is 0
v(:,1) = x;               %x initial values
%v(3,1) = .6;
%v(3,2) = 1;
v(:,1) = .1*cos(2*pi*x);
v(:,2) = .1*sin(2*pi*x);     %y initial values
vminus = v;             %v and vminus are equal at t=0


c(:,1)=.5*cos(2*pi*x);  %initial curvature x
c(:,2)=.5*sin(2*pi*x);  %initial curvature y


%loop for ode calculator
for tstep = 1:nt
    
    fb(:,1) = zeros(nodes,1);         %x force on a single node
    fb(:,2) = zeros(nodes,1);          %y force on a single node
    f = zeros(nodes,2);            %total forces in the system
    
    %calculates single force on a node
    for m = 1:nodes
        %connecting forces from node 1 to end node
        if m ==1
            fb(m,1)=(kb*ds)/(ds^4)*(v(nodes,1)+v(m+1,1)-2*v(m,1)-c(nodes,1)-c(m+1,1)+2*c(m,1));    %calc x force
            fb(m,2)=(kb*ds)/(ds^4)*(v(nodes,2)+v(m+1,2)-2*v(m,2)-c(nodes,2)-c(m+1,2)+2*c(m,2));    %calc y force
            % connecting forces from end node to node 1
        elseif m == nodes
            fb(m,1)=(kb*ds)/(ds^4)*(v(m-1,1)+v(1,1)-2*v(m,1)-(c(m-1,1)+c(1,1)-2*c(m,1)));    %calc x force
            fb(m,2)=(kb*ds)/(ds^4)*(v(m-1,2)+v(1,2)-2*v(m,2)-(c(m-1,2)+c(1,2)-2*c(m,2)));    %calc y force
            %all other nodes forces
        else
            fb(m,1)=(kb*ds)/(ds^4)*(v(m-1,1)+v(m+1,1)-2*v(m,1)-(c(m-1,1)+c(m+1,1)-2*c(m,1)));    %calc x force
            fb(m,2)=(kb*ds)/(ds^4)*(v(m-1,2)+v(m+1,2)-2*v(m,2)-(c(m-1,2)+c(m+1,2)-2*c(m,2)));    %calc y force
        end
    end
    
    %sums all forces acting on nodes
    for l = 1:nodes
        for m = 2:nodes-1
            %forces acting on previous node
            if m-1 == l
                f(m-1,1) = f(m-1,1) -1*fb(m,1);        %x forces
                f(m-1,2) = f(m-1,2) -1*fb(m,2);         %y forces
                %forces acting on current node
            elseif m == l
                f(m,1) = f(m,1) +2*fb(m,1);         %x forces
                f(m,2) = f(m,2) +2*fb(m,2);         %y forces
                %forces acting on next node
            elseif m+1 == l
                f(m+1,1) = f(m+1,1) -1*fb(m,1);     %x forces
                f(m+1,2) = f(m+1,2) -1*fb(m,2);     %y forces
            end
        end
    end
    %connecting new points
    f(nodes-1,1) = f(nodes-1,1)-1*fb(nodes,1);      %x forces
    f(nodes-1,2) = f(nodes-1,2)-1*fb(nodes,2);      %y forces
    
    %connecting new points
    f(nodes,1) = f(nodes,1)+2*fb(nodes,1);      %x forces
    f(nodes,2) = f(nodes,2)+2*fb(nodes,2);      %y forces
    
    %connecting new points
    f(1,1) = f(1,1)-1*fb(nodes,1);      %x forces
    f(1,2) = f(1,2)-1*fb(nodes,2);      %y forces
    
    %connecting new points
    f(nodes,1) = f(nodes,1)-1*fb(1,1);      %x forces
    f(nodes,2) = f(nodes,2)-1*fb(1,2);      %y forces
    
    %connecting new points
    f(1,1) = f(1,1)+2*fb(1,1);      %x forces
    f(1,2) = f(1,2)+2*fb(1,2);      %y forces
    
    %connecting new points
    f(2,1) = f(2,1)-1*fb(1,1);      %x forces
    f(2,2) = f(2,2)-1*fb(1,2);      %y forces
    
    
    %determines v vector for the next time step
    vplus = 2*v-vminus+(dt^2)*f;
    
    %shifts vectors over
    vminus=v;
    v=vplus;
    
    %plots beam movement
    figure(1)
    plot(v(:,1),v(:,2),'-om','LineWidth',2)
    hold on
    plot([v(1,1),v(end,1)],[v(1,2),v(end,2)], '-om', 'LineWidth',2)
    plot(c(:,1),c(:,2),'-g','LineWidth',2);
    plot([c(1,1),c(end,1)],[c(1,2),c(end,2)], '-g', 'LineWidth',2)
    
    grid on
    title(['Time=',num2str(tstep*dt)])
    axis([-1 1 -1 1])
    hold off
    pause(.1)
    
end