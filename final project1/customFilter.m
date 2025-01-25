function [I] = customFilter(I1)
I=rgb2gray(I1);
[m,n]=size(I);
for i=1:m
        for j=1:n
    
            if I(i,j)>90
            I(i,j)=256;
            end
        end
end 