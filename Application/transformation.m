function Is=transformation(I,min,max)
Is=255/(max-min)*(I-min);
end