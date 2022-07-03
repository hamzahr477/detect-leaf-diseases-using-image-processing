function Is= convolution(I,filter)
m=size(filter,1);
n=size(filter,2);
Output=zeros(size(I,1)+2*fix(m/2),size(I,2)+2*fix(n/2),size(I,3));
Output(round(m/2):end-fix(m/2),round(n/2):end-fix(n/2),:)=I;
for i = round(m/2):size(I,1)-fix(m/2)
    for j = round(n/2):size(I,2)-fix(n/2)
        Temp = sum(sum(sum(double(Output(i-fix(m/2):i+fix(m/2),j-fix(n/2):j+fix(n/2),:)).*filter)));
        tmpI(i,j) = Temp(:);
    end
end
Is=uint8(tmpI);
end
