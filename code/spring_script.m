clear all
close all
tspan=[0:.01:2];
Nx=10;
Ny=3;

h=.5;
k=50000*h;

D=509*h;

ktarget = 5000000*h;

a=5*h;
for r=1:length(k)
    [N, links] = SP1(Nx,Ny,h,k(r));
    z_0=[N(1:Nx:Nx*Ny,1) N(1:Nx:Nx*Ny,2)];
    % Set z0(1:2*Nx*Ny) here
    for i=1:Nx*Ny
        z0(i)=N(i,1);
        z0(i+Nx*Ny)=N(i,2);

    end
    z0(2*Nx*Ny+1:4*Nx*Ny)=0;
%     z0(1:6)=[0 2 2 0 0 0];
%     z0(3)=4;clc



    [t, z] = ode45(@(t,z) springsys(t, z, links, D, Nx,Ny,z_0,ktarget,a), tspan, z0);

    for i=1:length(t)
        plotLinks(Nx, Ny, [z(i,1:Nx*Ny)' z(i,Nx*Ny+1:2*Nx*Ny)'],links);
        axis([-1 5 -2.5 3.5])
        pause(.1)
        [i,t(i),z(i)];
        xlabel('x')
        ylabel('y')
%         print(['TargPts_',num2str(i)],'-dpng');

    end
%     for i=1:length(t)
%         distmatrix(r,i)=sqrt((z(i,1)-z(i,2))^2+(z(i,4)-z(i,5))^2);
%         distmatrix2(r,i)=sqrt((z(i,2)-z(i,3))^2+(z(i,5)-z(i,6))^2);
%     end


end
% figure(5)
% plot(t,distmatrix(1,:), '*g', t, distmatrix2(1,:),'dg')
% hold on
% plot(t,distmatrix(2,:), '*b', t, distmatrix2(2,:),'db')
% plot(t,distmatrix(2,:), '*r', t, distmatrix2(3,:),'dr')
% xlabel('time')
% ylabel('distance')
% legend('k=1', 'k=1','k=5','k=5','k=10')
% hold off
