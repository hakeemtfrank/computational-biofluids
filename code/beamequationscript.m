clear
close all
l=.05;                          %Length of beam, 'c'
h=1e-6;                         % 'ds'
x=0:h:l;                           % x axis
k=[1.87510406871196,4.69409113297417,7.85475743823761,10.99554073487546699]./l;
D4=1;                           %Coefficient D4 value
for i=1:length(k)
    hold
    D2=-(sin(k(i)*l)+sinh(k(i)*l))./(cos(k(i)*l)+cosh(k(i)*l));
    y(:,i)=D2*(cos(k(i)*x)-cosh(k(i)*x))+D4*(sin(k(i)*x)-sinh(k(i)*x)); %Phi-equation
    y_norm(:,i)=y(:,i)/(y(:,i)*y(:,i)*h)^.5;                   %Normalized Phi-equation
    figure(1)
    plot(x,y(:,i),'-','Color',[0 0 (i-1)*.8/length(k)])
    legend('k_1','k_2','k_3','k_4', 'k_5','k_6','k_7','location','SouthWest')
end


v=sin(x*pi);                    %Experimental Deflection Shape
test=zeros(size(y_norm(:,1)));
    figure(2)
    plot(x,test);
    hold on
    plot(x,v,'-r');
    hold off
    legend('modal approximation','reality','location','SouthWest')
    pause;
for i=1:length(k)
    beam_mode(i)=v*y_norm(:,i)*h; %inner product
    test=test+beam_mode(i)*y_norm(:,i);
    figure(2)
    plot(x,test);
    hold on
    plot(x,v,'-r');
    hold off
    legend('modal approximation','reality','location','SouthWest')
    pause;

end

test2=zeros(size(y_norm(:,1)));
for i=1:length(k)
    beam_mode(i)=randn; %inner product
    test2=test2+beam_mode(i)*y_norm(:,i);
    figure(3)
    plot(x,test2);
%     hold on
%     plot(x,v,'-r');
%     hold off
%     legend('modal approximation','reality','location','SouthWest')
    pause;

end



hold off
