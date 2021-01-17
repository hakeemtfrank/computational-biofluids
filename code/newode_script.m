clear all
Nx = 20;
z0 = zeros(1,Nx);
len = 1;
dx=len/(Nx-1);
kb=1000;
dt=1e-4;
tfinal =1;
x = [0:dx:len];
z0 = .1*sin(2*pi*x);

%warning
v(1:length(z0))=z0(1:length(z0));
vminus(1:length(z0))=z0(1:length(z0));



nt = floor(tfinal/dt);
for tstep = 1:nt

fb = zeros(Nx,1);
f = zeros(Nx,1);

for m = 2:Nx-1
    fb(m)=(kb*dx)/(dx^4)*(v(m-1)+v(m+1)-2*v(m));
end

for l = 1:Nx
    for m = 2:Nx-1
        if m-1 == l
            f(m-1,1) = f(m-1,1) -1*fb(m);
        elseif m == l
            f(m,1) = f(m,1) +2*fb(m);
        elseif m+1 == l
            f(m+1,1) = f(m+1,1) -1*fb(m);
        end
    end
end


vplus = 2*v-vminus+(dt^2)*f;
vminus=v;
v=vplus;


figure(1)
plot([0:dx:len],v,'-om','LineWidth',2)
title(['Time=',num2str(tstep*dt)])
axis([0 len -.2 .2])
pause(.1)

end
