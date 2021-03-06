function rose(del_theta, max_theta, k, amplitude, section, n, spiral, add_cos, cos_red, mirror)
% explanation of inputs
% del_theta = del_theta is the discrete step size for discretizing the continuous range of angles from 0 to 2*pi
% k = petal coefficient
%       if k is odd then k is the number of petals
%       if k is even then k is half the number of petals
% does k need to be an integer?
% amplitude = length of each petal
% section = angle to turn the flower
% n = number of iterations to get to section
% add_cos = ofset to cos (0-1)
% cos_red = amplitude of cos (0-1)
% explanation of outputs
% a 2D plot from calling this function illustrates an example of trigonometry and 2D Cartesian plotting
theta = 0:del_theta*pi:max_theta*pi;
% figure;
if(spiral)
    amp = amplitude*theta/max(theta);
else
    amp = amplitude;
end
for i = linspace(0,section,n+1)
    for a = add_cos
        for b = cos_red
            x = (a+b*cos(k*theta+pi*i)).*cos(theta);
            y = (a+b*cos(k*theta+pi*i)).*sin(theta);
            x = amp.*x/max(x);
            y = amp.*y/max(y);
            hold on;
            plot(x,y)
            if(mirror)
                hold on;
                plot(-x,-y)
            end
        end
    end
end