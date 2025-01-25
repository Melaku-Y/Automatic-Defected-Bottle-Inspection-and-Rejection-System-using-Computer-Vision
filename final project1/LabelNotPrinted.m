function result = LabelNotPrinted(O,T)
im_O = O;
im_T = T;
% crope the image [min value of x to be cropped , min value of y to be cropped, width of the image , height of the image]
cropped_T = imcrop(im_T,[20,192.510000000000,109.980000000000,67.9800000000000]);
gray_cropped_T = rgb2gray(cropped_T);%change the cropped image in to gray scale image
BW = imbinarize(gray_cropped_T, double(145/256));
nBlack = sum(BW(:) == 0);
nWhite = numel(BW(:));
percentage = nBlack/nWhite;
if percentage < 0.50;
    result = 1;
else
    result = 0;
end
end