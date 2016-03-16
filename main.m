im = imread('P2_seg/hand2.tif');
im = rgb2gray(im);
im = double(im);
im = im / 255.0;
%g = fspecial('gaussian', 9, 2);
%im = conv2(im, g, 'same');
winSize = 11;
[height, width] = size(im);
A = zeros(height*winSize, width*winSize);
contrast = zeros(height, width);
hg = zeros(height, width);
energy = zeros(height, width);
correlation = zeros(height, width);
for i = 1:height-winSize+1
    for j = 1:width-winSize+1
        w = im(i:i+winSize-1, j:j+winSize-1);
        glcm = graycomatrix(w, 'NumLevels', 8, 'Offset', [-1 0]);
        prop = graycoprops(glcm);
        x = i+floor(winSize/2);
        y = j+floor(winSize/2);
        contrast(x, y) = prop.Contrast;
        correlation(x, y) = prop.Correlation;
        energy(x, y) = prop.Energy;
        hg(x, y) = prop.Homogeneity;
    end;
end;
