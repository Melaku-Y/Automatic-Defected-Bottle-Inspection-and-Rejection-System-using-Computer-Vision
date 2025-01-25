function result = CheckBottleOver_filled(O,T)
im_O = O;
im_T = T;

% crope the image [min value of x to be cropped , min value of y to be cropped, width of the image , height of the image]
cropped_T = imcrop(im_T,[55,84.5100000000000,25.9800000000000,80.9800000000000]);
gray_cropped_T = rgb2gray(cropped_T);%change the cropped image in to gray scale image
BW = imbinarize(gray_cropped_T, double(100/256));
BW = imfill(BW,'holes');

nBlack = sum(BW(:) == 0);
nWhite = numel(BW(:));
percentage = nBlack/nWhite;

if percentage > 0.4
    result  = 1;
else
    result = 0;
end
end