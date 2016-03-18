function [ energy, contrast, correlation, homogeneity, entropy ] = features( im, winSize, distance, dx, dy, symmetric)
    [height, width] = size(im);
    g = fspecial('gaussian', 9, 2);
    im = conv2(im, g, 'same');
    contrast = zeros(height, width);
    homogeneity = zeros(height, width);
    energy = zeros(height, width);
    correlation = zeros(height, width);
    entropy = zeros(height, width);
    for i = 1:height-winSize+1
        for j = 1:width-winSize+1
            w = im(i:i+winSize-1, j:j+winSize-1);
            glcm = graycomatrix(w, 'NumLevels', 8, 'Offset', [dx*distance dy*distance], 'Symmetric', symmetric);
            prop = graycoprops(glcm);
            x = i+floor(winSize/2);
            y = j+floor(winSize/2);
            contrast(x, y) = prop.Contrast;
            correlation(x, y) = prop.Correlation;
            energy(x, y) = prop.Energy;
            homogeneity(x, y) = prop.Homogeneity;
            eval = 0.0;
            for k= 1:size(glcm,1)
                for t = 1:size(glcm,2)
                    eval = eval + glcm(k,t)*log(glcm(k,t));
                end;
            end;
            entropy(x,y) = eval;
        end;
    end;

end

