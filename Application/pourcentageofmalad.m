function [A1,A2,areainfected]=pourcentageofmalad(plant,malade)
black = im2bw(malade,graythresh(malade));
A1=sum(sum(black));
I_black = im2bw(plant,graythresh(plant));
A2=sum(sum(I_black));
areainfected=(A1/A2*100);
end