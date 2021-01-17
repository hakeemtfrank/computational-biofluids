[N Beam] = beamnetworksetup(2,1,2,2);

z0=[0 .25 0 0 0 0 0 0];
dx=.01;
kb=.1;
opts = odeset('RelTol',1e-4,'AbsTol',1e-6);
[t, z] = ode45(@(t,z) babybeamsys(t, z, dx, kb), [0:.1:1], z0,opts);


for i=1:size(z,1)
    figure(1)
    plot([0 dx 2*dx 3*dx],z(i,1:4),'-om','LineWidth',2)
    title(['Time=',num2str(t(i))])
    axis([0 .03 -2 2])
    pause(1)
end
