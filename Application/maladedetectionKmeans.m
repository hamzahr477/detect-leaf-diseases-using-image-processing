function  [A1,A2,p,plant,malade]=maladedetectionKmeans(I)
cform = makecform('srgb2lab');
lab_he = applycform(I,cform);

ab = double(lab_he(:,:,2:3));
nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,2);
close=0;
nc=3;
while(~close)
    a = inputdlg('Enterez le nombre de classes que vous voullez');
    nc = str2double(a)
    nColors = nc;
    [cluster_idx cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean', ...
                                          'Replicates',nc);
    pixel_labels = reshape(cluster_idx,nrows,ncols);
    segmented_images = cell(1,nc);

    % Creer les images de chaque objet 
    rgb_label = repmat(pixel_labels,[1,1,3]);

    for k = 1:nColors
        colors = I;
        colors(rgb_label ~= k) = 0;
        segmented_images{k} = colors;
    end


    figure;
    for n=1:nc
        subplot(1,nc,n);
        imshow(segmented_images{n});title(["Cluster ",n]); 
    end
    set(gcf, 'Position', get(0,'Screensize'));
    m=inputdlg('Vous voulez repeter la classification? Y/N [Y]:','s')
    if m=="N"
        close=1;
    end
end


x = inputdlg('Entrez le nombre de classe qui contient le maladie:');
i = str2double(x);
seg_img = segmented_images{i};


s = inputdlg('Entrez les nombres de classe qui contient la plante:');
si = split(s);

malade=segmented_images{i};
%Ectraction du plant
fullplantimage=zeros(size(seg_img,1),size(seg_img,2));
for ii=1:size(si)
    fullplantimage=fullplantimage+double(segmented_images{str2double(si(ii))});
end

plant=uint8(fullplantimage);

% Convert to grayscale if image is RGB
if ndims(seg_img) == 3
   img = rgb2gray(seg_img);
end


cc = bwconncomp(seg_img,6);
diseasedata = regionprops(cc,'basic');
A1 = diseasedata.Area;

kk = bwconncomp(I,6);
leafdata = regionprops(kk,'basic');
A2 = leafdata.Area;
Affected_Area = (A1/A2);
if Affected_Area < 0.1
    Affected_Area = Affected_Area+0.15;
end
p=Affected_Area*100;
end