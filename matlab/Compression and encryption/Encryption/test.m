clear;
clc;
% imagePath = './testImage/lena_gray.bmp';
% a = readImage(imagePath);
% c = splitImageTo8(a);
% c{1, 1}
testMatrix = [137 135 140 140 138 140 140 140;
              143 138 139 143 139 137 140 142;
              135 136 138 139 136 138 138 141;
              138 137 139 139 138 137 143 137;
              137 138 136 135 136 138 141 134;
              136 140 137 136 135 132 138 138;
              137 139 139 136 131 129 139 138;
              138 135 137 134 138 136 139 137];
% img = ones(64, 64);
% for i = 1: 64
%     for j = 1: 64
%         [c{i, j}, img(i, j)] = transform(c{i, j});
%     end
% end
% c{1, 1}
% imwrite(uint8(img), './a.jpg')

[a, ~] = transform(testMatrix)
c = transformInv(a)

isequal(c, testMatrix)

imagePath = './testImage/lena.tiff';
I = readImage(imagePath);
[vdt_image, suoluetu] = transformTotalImage(I);

[LT, RT, LB, RB] = getFour(suoluetu);

aaa = getFourInv(LT,RT,LB,RB);

isequal(aaa, suoluetu)