function v = computeFeatureVector(A)
%
% Describe an image A using texture features.
%   A is the image
%   v is a 1xN vector, being N the number of features used to describe the
% image
%

if size(A,3) > 1,
	A = rgb2gray(A);
end

glcm = graycomatrix(A);
prop = graycoprops(glcm);
v = [prop.Contrast, prop.Correlation, prop.Energy, prop.Homogeneity];
%v = mean(A);
