function result = DeformedBottle(O,T)
im_O = O;
im_T = T;
% crope the image [min value of x to be cropped , min value of y to be cropped, width of the image , height of the image]
cropped_T = imcrop(im_T,[4,163.510000000000,131.980000000000,31.9800000000000]);
red_channel = cropped_T(:, :, 1);
imageR = imadjust(red_channel);
BW1 = edge(imageR,'sobel','horizontal');
BW = bwareaopen(BW1,60);
cutskelimg = bwmorph(BW,'skel');
mn =bwmorph(cutskelimg,'endpoints');
[row, column] = find(mn);
x = length(column);
if (column(x)-column(1)) < 110
    result = 1;
else
    result = 0;
end
end