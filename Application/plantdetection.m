function objets=plantdetection(im)

im=imadjust(im,stretchlim(im));
im=histeq(im);
imgray=rgb2gray(im);
imgray=transformation(imgray,120,120);
bw = im2bw(imgray, graythresh(imgray));
bw=1-bw;
[labeledImage, numberOfRegions] = bwlabel(bw);
i=1;
imObjs=zeros(size(labeledImage,1),size(labeledImage,2));
for k=1:numberOfRegions
    if(sum(sum(labeledImage==k))>=4000)
        imObjs(:,:,i)=labeledImage==k;
        i=i+1;
    end
end
size(imObjs,3)
objets=imObjs(:,:,:);
end