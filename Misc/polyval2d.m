% POLYVAL2D  Evaluates 2D polynomial surface generated by POLYFIT2D
%    
% Usage: z = polyval2d(x, y, c)
%   
% Arguments:  x, y - Locations where polynomial is to be evaluated
%                c - Coefficients of polynomial as generated by polyfit2d
%                 
% Returns        z - The surface values evalated at x, y
%    
% For a degree 3 surface the coefficients are expected to progress in the
% form 
%     00 01 02 03 10 11 12 20 21 30
% where the first digit is the y exponent and the 2nd the x exponent
%
%      0 0      0 1      0 2      0 3      1 0      1 1      1 2
%  c1 x y + c2 x y + c3 x y + c4 x y + c5 x y + c6 x y + c7 x y + ...
%                   
% See also: POLYFIT2D   

% Peter Kovesi 2014
% Centre for Exploration Targeting
% The University of Western Australia
% peter.kovesi at uwa edu au

% PK July 2014

function z = polyval2d(x, y, c)
    
    % Solve quadratic to determin degree of polynomial
    % ncoeff = (degree+1)*(degree+2)/2
    ncoeff = length(c);
    degree = -1.5 + sqrt(2.25 - 2*(1-ncoeff));
    if round(degree) ~= degree
        error('Cannot determine polynomial degree from number of coefficients');
    end

    % p1 is the x exponent and p2 is the y exponent
    z = zeros(size(x));
    ind = 1;
    for p2 = 0:degree
        for p1 = 0:(degree-p2)    
            z = z + c(ind) * x.^p1 .* y.^p2;
            ind = ind+1;
        end
    end
