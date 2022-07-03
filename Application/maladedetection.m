function malade=maladedetection(plant)

 rgb = imadjust(plant,stretchlim(plant));

    hsv = rgb2hsv(rgb);
   % hsv =histeq(hsv);
    h = hsv(:, :, 1); % Hue image.cx
    s = hsv(:, :, 2); % Saturation image.
    v = hsv(:, :, 3); % Value (intensity) image.
    threshold =  max(s(:)) .* 0.0999;
    %threshold =    0.03;
    mask = s > threshold  ;
    %imshow(mask);
    Inew = h.*mask;
    Inewf=Inew*255;
    malade=uint8(im2bw(seuillage(Inewf,[180,255])).*double(plant));

end