im = imread('P2_seg/feli.tif');
im = rgb2gray(im);
im = double(im);
im = im / 255.0;
winSize = [5];
[height, width] = size(im);
distance = [1];
dx = [0 -1 -1 -1];
dy = [1 1 0 -1];
orient = [0, 45, 90, 135];

for ws = 1:length(winSize)
    for dist = 1:length(distance)
        for dir = 1:length(dx)
            sprintf('doing winsize=%d, distance=%d, orientation=%d', winSize(ws), distance(dist), orient(dir))
            [energy, contrast, correlation, homogeneity, entropy] = features( im, winSize(ws), distance(dist), dx(dir), dy(dir), false);
            fileName = sprintf('features/feli-ws%d-dist%d-orient%d',winSize(ws),distance(dist),orient(dir));
            save(fileName, 'energy', 'contrast', 'correlation', 'homogeneity', 'entropy');
            sprintf('saved to a file.')
        end;
    end;
end;