O = imread('XII.jpg');
T = imread('XI.jpg');
% Resizing the Image to scale 1/4
resized_image_O = imresize(O,.125);
resized_image_T = imresize(T,.125);
% Converting Image from RGB to Binary
new_O = im2bw(resized_image_O);
new_T = im2bw(resized_image_T);
% crop Image
cropped_image_O = imcrop(new_O,[100 1 100 110]);
cropped_image_T = imcrop(new_T,[100 1 100 110]);

imtool(cropped_image_O)
imtool(cropped_image_T)