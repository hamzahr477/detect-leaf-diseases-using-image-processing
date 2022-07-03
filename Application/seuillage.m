function im1=seuillage(i,T)
tmp=(i>T(1) & i<T(2)).*255;
im1=uint8(tmp);
%%tmp=(i>T(1)).*double(i);
%im2=uint8(tmp);
%tmp=(i<T(2)).*double(i);
%im3=uint8(tmp);
end