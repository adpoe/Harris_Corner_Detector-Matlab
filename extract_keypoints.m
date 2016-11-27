function [ x, y, scores, Ix, Iy ] = extract_keypoints( image )
%EXTRACT_KEYPOINTS Extracts points with a high degree of 'cornerness' from
%RGB image matrix of type uint8
%   Input - image = NxMx3 RGB image matrix
%   Output - x = nx1 vector denoting the x location of each of n
%                detected keypoints 
%            y = nx1 vector denoting the y location of each of n 
%                detected keypoints
%            scores = an nx1 vector that contains the value (R) to which a
%            a threshold was applied, for each keypoint
%            Ix = A matrix with the same number of rows and columns as the
%            input image, storing the gradients in the x-direction at each
%            pixel
%            Iy = A matrix with the same nuimber of rwos and columns as the
%            input image, storing the gradients in the y-direction at each
%            pixel

% compute the gradients, re-use code from HW2P, use window size of 5px
% convert image to grayscale first
G = rgb2gray(image);

% convert to double
G2 = im2double(G);

% create X and Y Sobel filters
horizontal_filter = [1 0 -1; 2 0 -2; 1 0 -1];
vertical_filter = [1 2 1; 0 0 0 ; -1 -2 -1];

% using imfilter to get our gradient in each direction
filtered_x = imfilter(G2, horizontal_filter);
filtered_y = imfilter(G2, vertical_filter);

% store the values in our output variables, for clarity
Ix = filtered_x;
Iy = filtered_y;

% Compute the values we need for the matrix...
% Using a gaussian blur, because I get more positive values after applying
% it, my values all skew negative for some reason...
f = fspecial('gaussian');
Ix2 = imfilter(Ix.^2, f);
Iy2 = imfilter(Iy.^2, f);
Ixy = imfilter(Ix.*Iy, f);

% set empirical constant between 0.04-0.06
k = 0.04;

num_rows = size(image,1);
num_cols = size(image,2);

% create a matrix to hold the Harris values
H = zeros(num_rows, num_cols);

% % get our matrix M for each pixel
for y = 6:size(image,1)-6
    for x = 6:size(image,2)-6
        % build a matrix using what we computed earlier
%         M = zeros(2,2);
%         M(1,1) = Ix2(y,x);
%         M(2,1) = Ixy(y,x);
%         M(1,2) = Ixy(y,x);
%         M(2,2) = Iy2(y,x);
%       
        % calculate means
        % Ix2 mean
        Ix2_matrix = Ix2(y-2:y+2,x-2:x+2);
        Ix2_mean = mean(Ix2_matrix(:));
        
        % Iy2 mean
        Iy2_matrix = Iy2(y-2:y+2,x-2:x+2);
        Iy2_mean = mean(Iy2_matrix(:));
        
        % Ixy mean
        Ixy_matrix = Ixy(y-2:y+2,x-2:x+2);
        Ixy_mean = mean(Ixy_matrix(:));
        
        Matrix = [Ix2_mean, Ixy_mean; 
                  Ixy_mean, Iy2_mean];
        R1 = det(Matrix) - (k * trace(Matrix)^2);
        
        
        % compute R, using te matrix we just created
        %R = det(M) - ( k * trace(M)^2 );
        %alt
        %R = (Ix2.*Iy2 - Ixy.^2) - k(Ix2+Iy2).^2;
        
        % store the R values in our Harris Matrix
       
        % H(y,x) = R;
        
        H(y,x) = R1;
       
    end
end

% set threshold of 'cornerness' to 5 times average R score
avg_r = mean(mean(H))
threshold = abs(5 * avg_r)

[row, col] = find(H > threshold);

scores = [];
%get all the values
for index = 1:size(row,1)
    %see what the values are
    r = row(index);
    c = col(index);
    
    %store the scores
    %score(index) = H(r,c);
    scores = cat(2, scores,H(r,c));
end

y = row;
x = col;


% This needs to be LAST
% non max suppression
% http://www.mathworks.com/help/images/ref/imregionalmax.html
% BW = imregionalmax(H);


end

