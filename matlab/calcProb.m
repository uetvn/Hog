% Read input image
imageName = 'test_pos_1.png';
src = imread(imageName);
[ rows, cols, z ] = size(src);

% Convert input image into Grayscale image
if  z > 1
    img = rgb2gray(src);
else
    img = src;
end

% ===============================
%    Compute Gradient Vectors
% ===============================
% Compute the gradient vector at every pixel in the image.

% Create the operators for computing image derivative at every pixel.
hx = [-1  0  1];
hy = [-1; 0; 1];

% Compute the derivative in the x and y direction for every pixel.
%img = img(3:132, 3:68);
dx = filter2(hx, img);
dy = filter2(hy, img);

% Remove the 1 pixel border.
dx = dx(2 : (size(dx, 1) - 1), 2 : (size(dx, 2) - 1));  % 128 x 64
dy = dy(2 : (size(dy, 1) - 1), 2 : (size(dy, 2) - 1));  % 128 x 64

Fx = dx(:);

subplot(2, 1, 1);
xRange = -30:30;
N = hist(Fx, xRange);
plot(xRange, N./numel(Fx));
xlabel('Integer value');
ylabel('Probability');

subplot(2, 1, 2);
cdfplot(Fx);
grid off;
axis([-30 30 0 1]);
xlabel('Integer value');
ylabel('Cumulative distribution probability');