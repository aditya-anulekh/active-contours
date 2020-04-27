%
% The Heavside function
% Inputs
% z - The matrix for which you would like to compute the Heavside function
% type - '1' for the H1 regularization and '2' for the infinity
% regularization. For further information please refer the paper - Active
% Contours without Edges (Chan-Vese)
%

function [H,H_d] = Heavside(z,type)
epsilon = 1;
H = zeros(size(z,1),size(z,2));
H_d = zeros(size(z,1),size(z,2));
switch(type)
    case '1'
        index1 = find(z>epsilon);
        index2 = find(z<=epsilon & z>=-epsilon);
        H(index1) = 1;
        H_d(index1) = 0;
        for i=1:length(index2)
            H(index2(i)) = 1/2*(1+z(index2(i))/epsilon+1/pi*sin(pi*z(index2(i))/epsilon));
            H_d(index2(i)) = (1/(2*epsilon))*(1+cos(pi*z(index2(i))/epsilon));
        end
    case '2'
        H = 0.5*(1+(2/pi).*atan(z/epsilon));
        H_d = epsilon./(pi*(epsilon^2+z.^2));
end
end