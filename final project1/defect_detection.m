O = imread('III.jpg');
T = imread('IX.jpg');
resized_image_O = imresize(O,.125);
gray_resized_image_O  = rgb2gray(resized_image_O);
BW_O = im2bw(gray_resized_image_O);% Convert image to binary image by thresholding
white_O = sum(resized_image_O(:));
black_O = numel(resized_image_O)-white_O;

resized_image_T = imresize(T,.125);
gray_resized_image_T  = rgb2gray(resized_image_T);
BW_T = im2bw(gray_resized_image_T);% Convert image to binary image by thresholding
% imtool(BW_O)
% imtool(BW_T)
white_T = sum(resized_image_T(:));
black_T = numel(resized_image_T)-white_T;

n_O = black_O;
n_T = black_T;

if n_T > n_O
    status=1;
    disp('Defect found');
else
    if n_T < n_O
        status=1;
        disp('Defect found');
    else
        status=0;
    disp('Defects not found');
    end
end
if status == 1
    myicon =  imread('delete.png');
    h= msgbox('Defect found','Defect Detection Result','custom',myicon);
else
    myicon = imread('tick.png');
    h= msgbox('Defect not found','Defect Detection Result','custom',myicon);
end