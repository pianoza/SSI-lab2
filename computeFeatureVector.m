function v = computeFeatureVector(A)
%
% Describe an image A using texture features.
%   A is the image
%   v is a 1xN vector, being N the number of features used to describe the
% image
%

if size(A,3) > 1,
    B = rgb2hsv(A);
	A = rgb2gray(A);
end
dx = [0 -1 -1 -1];
dy = [1 1 0 -1];
%distance = [2 4 8 16 32]; %0.8250, 0.8375(included entropy). using this and features of R,G,B and graylevel separately gave 0.85. used contrast, correlation, energy, homogeneity, entropy
distance = [1, 32]; %0.9625 with mean and standard deviation of Hue and Sat
v = [mean(mean(B(:,:,1))), std2(B(:,:,1)), mean(mean(B(:,:,2))), std2(B(:,:,2))];
% TODO: try to quantize the VALUE channel
% 0.9875 with NumLevels equal to 6
for i = 1:length(distance)
    for j = 1:length(dx);
        glcm = graycomatrix(B(:,:,3), 'Offset', [dx(j)*distance(i) dy(j)*distance(i)], 'Symmetric', false, 'NumLevels', 6);
        prop = graycoprops(glcm);
        if isnan(prop.Correlation)
            prop.Correlation = 1.0;
        end;
        v = [v, prop.Contrast, prop.Correlation, prop.Energy, prop.Homogeneity, entropy(glcm)];
    end;
end;

function out = entropy(A)
    out = 0.0;
    for i = 1:size(A,1)
        for j = 1:size(A,2)
            out = out + A(i,j)*log(A(i,j));
        end;
    end;

