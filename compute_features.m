function [ features, x, y, scores ] = compute_features( x, y, scores, Ix, Iy )
% COMPUTE_FEATURES Compute features based on SIFT Scores
%   INPUTS
%       x = vector of x-values at which our features are located
%       y = vector of y-values at which our features are located
%       scores = actual score values, for each feature
%       Ix = Column derivatives
%       Iy = Row Derivatives
%   OUTPUTS
%       features = nxd matrix, each row of which contains the
%       d-dimensional descriptors for the nth keypoint
%       - also return: same x, y, and scores values as are passed in


grad_mag = zeros(size(Ix));
grad_orient = zeros(size(Ix));

% size of score
features = [];

for i = 1:size(Iy, 1)
    for j = 1:size(Ix, 2)
        % fill the magnitude matrix
        grad_mag(i, j) = sqrt(Ix(i,j)^2 + Iy(i,j)^2);
        
        % find the orient
        orient_raw = atand(Iy(i,j) / Ix(i,j));
        
        if (isnan(orient_raw))
            assert(grad_mag(i,j) == 0);
            orient_raw = 0; % if no change, we won't count a gradient magnitude
        end
        
        % get the correct bin
        assert(orient_raw >= -90);
        if (orient_raw <= -67.5)
            grad_orient(i,j) = 1;
        elseif (orient_raw <= -45)
            grad_orient(i,j) = 2;
        elseif (orient_raw <= 22.5)
            grad_orient(i,j) = 3;
        elseif (orient_raw <= 0)
            grad_orient(i,j) = 4;
        elseif (orient_raw <= 22.5)
            grad_orient(i,j) = 5;
        elseif (orient_raw <= 45)
            grad_orient(i,j) = 6;
        elseif (orient_raw <= 67.5)
            grad_orient(i,j) = 7;
        else % orient_raw > 67.5
            grad_orient(i,j) = 8;
        end
        
    end
end


% find 8-d descriptor for the 11x11 grid aroud each feature
% get values for each feature
for index = 1:size(scores,2)
    % save the descriptor
    descriptor = zeros(8,1);
    
    % get indices
    row = y(index, 1);
    col = x(index, 1);
    
    % check if feature is < 5px from top-left/bottom-right, erase if so
     if row <= 5 || col <= 5 || (size(grad_mag,1) - row) <= 5 || (size(grad_mag,2) - col) <= 5
         % then skip, we just don't add the feature
         continue 
     end
     
    % assert that we don't have row or col values that will be -1 or lower
    assert(row-5 >= 1, 'Row is < 1!');
    assert(col-5 >= 1, 'Col is < 1!');
    
    % iterate through the 11x11 area AROUND the feature
    for y_val = row-5:row+5
        for x_val = col-5:col+5
            mag = grad_mag(y_val,x_val);
            orient = grad_orient(y_val, x_val);
            
            % store that orient/mag
            descriptor(orient, 1) = descriptor(orient, 1) + mag;
        end
    end
    
    % cat this onto the features vector
    features = cat(2, features, descriptor);
end

% normalize the vectors
for index = 1:size(features,2)
    f = features(:,index);
    f_normal = f(:)/sum(f);
    features(:, index) = f_normal;
end

% clip values to 0.2 
features( features > 0.2 ) = 0.2;
% and normalize the vectors again, with this new value set
for index = 1:size(f_normal,2)
    f = features(:,index);
    f_normal = f(:)/sum(f);
    features(:, index) = f_normal;
end


end