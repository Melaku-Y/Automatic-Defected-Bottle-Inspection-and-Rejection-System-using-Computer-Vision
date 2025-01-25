function result = CheckMissingBottle(O,T)
im_O = O;
im_T = T;
cropped_T = imcrop(im_T,[50,2,33,288]);% crope the image [min value of x to be cropped , min value of y to be cropped, width of the image , height of the image]

gray_cropped_T = rgb2gray(cropped_T);%change the cropped image in to gray scale image
BW = imbinarize(gray_cropped_T, double(150/256));

nBlack = sum(BW(:) == 0);
nWhite = numel(BW(:));

percentage = nBlack/nWhite;
if percentage < 0.10
    result = 1;
else
    result = 0;
end