contrast = load('features/hand-contrast');
contrast = contrast.contrast;
correlation = load('features/hand-correlation');
correlation = correlation.correlation;
energy = load('features/hand-energy');
energy = energy.energy;
hg = load('features/hand-hg');
hg = hg.hg;
im = imread('P2_seg/hand2.tif');
im = double(im);
im = im / 255.0;
correlation(isnan(correlation)) = 1.0;
% g = fspecial('gaussian', 25, 2);
% energy = conv2(energy, g, 'same');
% hg = conv2(hg, g, 'same');
% contrast = conv2(contrast, g, 'same');
% correlation = conv2(correlation, g, 'same');
im(:,:,4) = contrast(:,:);
im(:,:,5) = energy(:,:);
im(:,:,6) = hg(:,:);
im(:,:,7) = correlation(:,:);

[seg, n]= regionGrowing(im, 120.0/255.0, 4);
imagesc(seg);


