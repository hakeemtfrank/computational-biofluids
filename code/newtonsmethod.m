function [ x ] = newtonsmethod( x0 )
%function is defined
f =@(x) cos(x).*cosh(x)+1;

%derivative of function is defined
df =@(x) cos(x).*sinh(x)-sin(x).*cosh(x);

%initial value of x0 is stored
x=x0;

%excessive iterations are used to ensure accuracy of the approximation
for k=1:100
    
    %new approximated value is calculated using tangent line approximation
    x2 = x - f(x)./df(x);
    % diff between old and new approx is small enough
    if abs(x2-x)<1e-9, break; end 
    %new approximation set to output variable
    x = x2;
end

end

