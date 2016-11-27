
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% @author:  Anthony (Tony) Poerio (adp59@pitt.edu)
%
% CS1674 - Computer Vision
% Programming Assignment #4
% Fall 2016 
% Show Keypoints for 10 different pictures
% --> Pictures displayed and keypoints extracted based on 'cornerness',
% using the Harris Corner Detector Algorithm
% --> Features for each corner determined using the SIFT algorithm for
% Scale Invariant Feature Extraction
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%% (1) Pittsburgh.png %%%%%%%%%%%%%
image = imread('pittsburgh.png');
image = imresize(image, 0.75);
[ x, y, scores, Ix, Iy ] = extract_keypoints( image );
figure; imshow(image) 
hold on
for i = 1:size(scores,2)
    %plot(x(i), y(i), 'ro', 'MarkerSize', scores(i) / 1000000000);
    plot(x(i), y(i), 'ro', 'MarkerSize', scores(i) * 5);
    
end
saveas(gcf,'hw04_pittsburgh_corners.png');
hold off

% get the feature descriptors via SIFT
[ pgh_features, x, y, scores ] = compute_features( x, y, scores, Ix, Iy );
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%% (2) Rainbow.jpg %%%%%%%%%%%%
image = imread('Rainbow.jpg');
image = imresize(image, 0.5);
[ x, y, scores, Ix, Iy ] = extract_keypoints( image );
figure; imshow(image) 
hold on
for i = 1:size(scores,2)
    plot(x(i), y(i), 'ro', 'MarkerSize', scores(i) * 5 );
    
end
saveas(gcf,'hw04_rainbow_corners.png');
hold off

% get the feature descriptors via SIFT
[ rainbow_features, x, y, scores ] = compute_features( x, y, scores, Ix, Iy );
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%% (3) leopard2.jpg  %%%%%%%%%% 
image = imread('leopard2.jpg');
image = imresize(image, 0.5);
[ x, y, scores, Ix, Iy ] = extract_keypoints( image );
figure; imshow(image) 
hold on
for i = 1:size(scores,2)
    plot(x(i), y(i), 'ro', 'MarkerSize', scores(i) * 5);
    
end
saveas(gcf,'hw04_leopard2_earing_corners.png');
hold off

% get the feature descriptors via SIFT
[ leopard2_features, x, y, scores ] = compute_features( x, y, scores, Ix, Iy );
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%% (4) Prague.jpg %%%%%%%%%%%%
image = imread('prague.jpg');
image = imresize(image, 0.75);
[ x, y, scores, Ix, Iy ] = extract_keypoints( image );
figure; imshow(image) 
hold on
for i = 1:size(scores,2)
    plot(x(i), y(i), 'ro', 'MarkerSize', scores(i) );
    
end
saveas(gcf,'hw04_prague_corners.png');
hold off

% get the feature descriptors via SIFT
[ prague_features, x, y, scores ] = compute_features( x, y, scores, Ix, Iy );
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%% (5) Provence.jpg %%%%%%%%%%%%
image = imread('Provence.jpg');
image = imresize(image, 0.5);
[ x, y, scores, Ix, Iy ] = extract_keypoints( image );
figure; imshow(image) 
hold on
for i = 1:size(scores,2)
    plot(x(i), y(i), 'ro', 'MarkerSize', scores(i) *5 );
    
end
saveas(gcf,'hw04_provence_corners.png');
hold off

% get the feature descriptors via SIFT
[ provence_features, x, y, scores ] = compute_features( x, y, scores, Ix, Iy );
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%% (6) circuit_board.jpg %%%%%%%%%%%%%
image = imread('circuit_board.JPG');
image = imresize(image, 0.7);
[ x, y, scores, Ix, Iy ] = extract_keypoints( image );
figure; imshow(image) 
hold on
for i = 1:size(scores,2)
    plot(x(i), y(i), 'ro', 'MarkerSize', scores(i)  *5);
    
end
saveas(gcf,'hw04_circuit_corners.png');
hold off

% get the feature descriptors via SIFT
[ circuit_features, x, y, scores ] = compute_features( x, y, scores, Ix, Iy );
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%% (7) vermeer.jpg %%%%%%%%%%%%%%%%
image = imread('vermeer.jpg');
image = imresize(image, 0.25);
[ x, y, scores, Ix, Iy ] = extract_keypoints( image );
figure; imshow(image) 
hold on
for i = 1:size(scores,2)
    plot(x(i), y(i), 'ro', 'MarkerSize', scores(i) *5);
    
end
saveas(gcf,'hw04_vermeer_corners.png');
hold off
% get the feature descriptors via SIFT
[ vermeer_features, x, y, scores ] = compute_features( x, y, scores, Ix, Iy );
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%% (8) eiffel.jpg %%%%%%%%%%%%%% 
image = imread('eiffel.jpg');
image = imresize(image, 1);
[ x, y, scores, Ix, Iy ] = extract_keypoints( image );
figure; imshow(image) 
hold on
for i = 1:size(scores,2)
    plot(x(i), y(i), 'ro', 'MarkerSize', scores(i) *5 );
end
saveas(gcf,'hw04_eiffel_corners.png');
hold off
% get the feature descriptors via SIFT
[ eiffel_features, x, y, scores ] = compute_features( x, y, scores, Ix, Iy );
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%% (9) leopard1.jpg %%%%%%%%%%%%%%%% 
image = imread('leopard1.jpg');
image = imresize(image, 0.75);
[ x, y, scores, Ix, Iy ] = extract_keypoints( image );
figure; imshow(image) 
hold on
for i = 1:size(scores,2)
    plot(x(i), y(i), 'ro', 'MarkerSize', scores(i) *5);
    
end
saveas(gcf,'hw04_leopard1_corners.png');
hold off
% get the feature descriptors via SIFT
[ leopard1_features, x, y, scores ] = compute_features( x, y, scores, Ix, Iy );
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%% (10) panda1.jpg %%%%%%%%%%%%%%  
image = imread('panda1.jpg');
image = imresize(image, 0.66);
[ x, y, scores, Ix, Iy ] = extract_keypoints( image );
figure; imshow(image) 
hold on
for i = 1:size(scores,2)
    plot(x(i), y(i), 'ro', 'MarkerSize', scores(i) *5 );
    
end
saveas(gcf,'hw04_panda1_corners.png');
hold off

% get the feature descriptors via SIFT
[ panda_features, x, y, scores ] = compute_features( x, y, scores, Ix, Iy );
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
