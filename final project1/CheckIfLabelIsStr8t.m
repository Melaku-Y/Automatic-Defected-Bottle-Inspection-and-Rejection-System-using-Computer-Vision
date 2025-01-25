function result = CheckIfLabelIsStr8t(O,T)
im_O = O;
im_T = T;
% crope the image [min value of x to be cropped , min value of y to be cropped, width of the image , height of the image]
cropped_T = imcrop(im_T,[5,154.510000000000,106.980000000000,100.980000000000]);
red_channel = cropped_T(:, :, 1);
imageR = imadjust(red_channel);
BW1 = edge(imageR,'sobel','horizontal');
BW = bwareaopen(BW1,45);
cutskelimg = bwmorph(BW,'skel');
mn =bwmorph(cutskelimg,'endpoints');
[row, column] = find(mn);
x = length(column);
Angle1 = atan((row(x)- row(1))/(column(x)-column(1)));
if Angle1 > 0.08 && (column(x)-column(1)) < 120
    result = 1;
else
    result = 0;
end
end