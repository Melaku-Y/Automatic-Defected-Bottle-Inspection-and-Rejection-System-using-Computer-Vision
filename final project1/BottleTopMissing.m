function result = BottleTopMissing(O,T)
im_O = O;
im_T = T;
% crope the image [min value of x to be cropped , min value of y to be cropped, width of the image , height of the image]
cropped_T = imcrop(im_T,[25,5,78.01,54.01]);
YCBCR = rgb2ycbcr(cropped_T);
red_channel = YCBCR(:,:,3);
BW = imbinarize(red_channel, double(170/256));
nBlack = sum(BW(:) == 0);
nWhite = numel(BW(:));

percentage = (nBlack/nWhite);
if percentage > 0.8
    result = 1;
else 
    result = 0;
end
end