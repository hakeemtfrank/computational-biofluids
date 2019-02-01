%%% cfd rungekutta
function [y,t]=Euler(a, b, c, dt)
y(1)=c;
t(1)=a;
N=floor((b-a)/dt);

for i=1:N
    y(i+1)=y(i) + dt*myFunc(t(i),y(i));
    t(i+1)=t(i)+dt;
end
plot(t,y,t,exp(-t)+t)
xlabel('time')
ylabel('solution')
end

function f=myFunc(t,y)
f = -y + t + 1;
end


