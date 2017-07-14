    % Read input image
    imageName = 'test_pos_1.png';
    imgfirst = imread(imageName);
    [ rows, cols, z ] = size(imgfirst);

    if  z > 1
        img1 = rgb2gray(imgfirst);
    else
        img1 = imgfirst;
    end
    numBins = 9;

    % Create the operators for computing image derivative at every pixel.
    hx = [-1  0  1];
    hy = [-1; 0; 1];

    % Compute the derivative in the x and y direction for every pixel.
    img = img1(1:480, 1:640);
    %dx = filter2(hx, img1);
    %y = filter2(hy, img1);
    dx = imfilter(img1, hx);
    dy = imfilter(img1, hy);

    % Convert the gradient vectors to polar coordinates (angle and magnitude).
    dx = double(dx);
    dy = double(dy);
    ang = atan2(dy, dx);             % 128 x 64
    mag = ((dy.^2) + (dx.^2)).^.5;   % 128 x 64
    
  
    
    H = zeros(numBins, 1);
    
    % Compute the bin size in radians. 180 degress = pi.
    binSize = pi / numBins;

    % Compute the histogram
    cellSize2 = 64;     %   cellSize^2
    d10  = pi/180*10;   %   binSize/2
    
    % Bin centers
    d30  = d10  + binSize;
    d50  = d30  + binSize;
    d70  = d50  + binSize;
    d90  = d70  + binSize;
    d110 = d90  + binSize;
    d130 = d110 + binSize;
    d150 = d130 + binSize;
    d170 = d150 + binSize;
    magnitudes = mag';
    magnitudes = magnitudes(:);
    angles = ang';
    angles = angles(:);
    img = img';
    img = img(:);
    
    fileID = fopen('test_set_abs_dxy.txt','w');
    for m = 1 : 478
        for n = 1 : 638
        i = m*640 + n + 1;
        % Make the angles unsigned by adding pi to all negative angles.
        if  angles(i) < 0
            angles(i) = angles(i) + pi;
        end
        
        % Gradient angle may lie between two bin centers. For each pixel,
        % split the bin contributions between these two bins based on how
        % far the angle is from the bin centers.
        if      angles(i) >= 0    && angles(i) < d10
                rightPortion = (angles(i) + d10 )/binSize * magnitudes(i);
                leftPortion  = magnitudes(i) - rightPortion;
                %fprintf(fileID, '%d %.2f %.4f \n', i, magnitudes(i),angles(i));
                fprintf(fileID, '%3d %3d %3d %3d  %3d %3d  %.4f %.4f \n', img(i+1), img(i-1), img(i+640), img(i-640), 170, 10, leftPortion, rightPortion);

        elseif  angles(i) >= d10  && angles(i) < d30
                rightPortion = (angles(i) - d10 )/binSize * magnitudes(i);
                leftPortion  = magnitudes(i) - rightPortion;
                %fprintf(fileID, '%d %.2f %.4f\n', i, magnitudes(i),angles(i));
                fprintf(fileID, '%3d %3d %3d %3d  %3d %3d  %.4f %.4f \n', img(i+1), img(i-1), img(i+640), img(i-640), 10, 30, leftPortion, rightPortion);

        elseif  angles(i) >= d30  && angles(i) < d50
                rightPortion = (angles(i) - d30 )/binSize * magnitudes(i);
                leftPortion  = magnitudes(i) - rightPortion;
                %fprintf(fileID, '%d %.2f %.4f\n', i, magnitudes(i),angles(i));
                fprintf(fileID, '%3d %3d %3d %3d  %3d %3d  %.4f %.4f \n', img(i+1), img(i-1), img(i+640), img(i-640), 30, 50, leftPortion, rightPortion);

        elseif  angles(i) >= d50  && angles(i) < d70
                rightPortion = (angles(i) - d50 )/binSize * magnitudes(i);
                leftPortion  = magnitudes(i) - rightPortion;
                %fprintf(fileID, '%d %.2f %.4f\n', i, magnitudes(i),angles(i));
                fprintf(fileID, '%3d %3d %3d %3d  %3d %3d  %.4f %.4f \n', img(i+1), img(i-1), img(i+640), img(i-640), 50, 70, leftPortion, rightPortion);

        elseif  angles(i) >= d70  && angles(i) < d90
                rightPortion = (angles(i) - d70 )/binSize * magnitudes(i);
                leftPortion  = magnitudes(i) - rightPortion;
                %fprintf(fileID, '%d %.2f %.4f\n', i, magnitudes(i),angles(i));
                fprintf(fileID, '%3d %3d %3d %3d  %3d %3d  %.4f %.4f \n', img(i+1), img(i-1), img(i+640), img(i-640), 70, 90, leftPortion, rightPortion);

        elseif  angles(i) >= d90  && angles(i) < d110
                rightPortion = (angles(i) - d90 )/binSize * magnitudes(i);
                leftPortion  = magnitudes(i) - rightPortion;
                %fprintf(fileID, '%d %.2f %.4f\n', i, magnitudes(i),angles(i));
                fprintf(fileID, '%3d %3d %3d %3d  %3d %3d  %.4f %.4f \n', img(i+1), img(i-1), img(i+640), img(i-640), 90, 110, leftPortion, rightPortion);

        elseif  angles(i) >= d110 && angles(i) < d130
                rightPortion = (angles(i) - d110)/binSize * magnitudes(i);
                leftPortion  = magnitudes(i) - rightPortion;
                %fprintf(fileID, '%d %.2f %.4f\n', i, magnitudes(i),angles(i));
                fprintf(fileID, '%3d %3d %3d %3d  %3d %3d  %.4f %.4f \n', img(i+1), img(i-1), img(i+640), img(i-640), 110, 130, leftPortion, rightPortion);

        elseif  angles(i) >= d130 && angles(i) < d150
                rightPortion = (angles(i) - d130)/binSize * magnitudes(i);
                leftPortion  = magnitudes(i) - rightPortion;
                %fprintf(fileID, '%d %.2f %.4f\n', i, magnitudes(i),angles(i));
                fprintf(fileID, '%3d %3d %3d %3d  %3d %3d  %.4f %.4f \n', img(i+1), img(i-1), img(i+640), img(i-640), 130, 150, leftPortion, rightPortion);

        elseif  angles(i) >= d150 && angles(i) < d170
                rightPortion = (angles(i) - d150)/binSize * magnitudes(i);
                leftPortion  = magnitudes(i) - rightPortion;
                %fprintf(fileID, '%d %.2f %.4f\n', i, magnitudes(i),angles(i));
                fprintf(fileID, '%3d %3d %3d %3d  %3d %3d  %.4f %.4f \n', img(i+1), img(i-1), img(i+640), img(i-640), 150, 170, leftPortion, rightPortion);

        else
                rightPortion = (angles(i) - d170)/binSize * magnitudes(i);
                leftPortion  = magnitudes(i) - rightPortion;
                %fprintf(fileID, '%d %.2f %.4f\n', i, magnitudes(i),angles(i));
                fprintf(fileID, '%3d %3d %3d %3d  %3d %3d  %.4f %.4f \n', img(i+1), img(i-1), img(i+640), img(i-640), 170, 10, leftPortion, rightPortion);

        end
        end
    end
fclose(fileID);
