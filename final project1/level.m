O = imread('IV.jpg');
T = imread('IX.jpg');
% Resizing the Image to scale 1/4
resized_image_O = imresize(O,.125);
resized_image_T = imresize(T,.125);
% Removing shadow from image
inhanced_O = customFilter(resized_image_O);
inhanced_T = customFilter(resized_image_T);
% Converting Image from RGB to Binary
new_O = im2bw(inhanced_O);
new_T = im2bw(inhanced_T);

[m,n]=size(new_O);
count1=0;
for i=1:m
        for j=1:n
    
            if new_O(i,j)==0
            count1=count1+1;
            end
        end
end 
disp(count1);

[m,n]=size(new_T);
count2=0;
for i=1:m
        for j=1:n
    
            if new_T(i,j)==0
            count2=count2+1;
            end
        end
end    
disp(count2);

diff = count1-count2;
if diff > 700
        status = 1;
    else
        status = 0;
end
if status == 1
    disp(' NOT FILLED ');
    myicon =  imread('delete.png');
    h= msgbox('Not Filled','Level Detection Result','custom',myicon);
else
    disp(' FILLED ');
    myicon = imread('tick.png');
    h= msgbox('Filled','Level Detection Result','custom',myicon);
end
