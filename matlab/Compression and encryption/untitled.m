clc;clear;
%原始图像相邻像素相关性分析
%{
先随机在0~M-1行和0~N-1列选中5000个像素点，
计算水平相关性时，选择每个点的相邻的右边的点；
计算垂直相关性时，选择每个点的相邻的下方的点；
计算对角线相关性时，选择每个点的相邻的右下方的点。
%}
I=imread('./data/Airplane (U-2)/suoluetu_E.tiff'); 
I = double(I);
[M, N] = size(I);
NN=2000;    %随机取NN对像素点
x1=ceil(rand(1,NN)*(M-1));      %生成NN个1~M-1的随机整数作为行
y1=ceil(rand(1,NN)*(N-1));      %生成NN个1~N-1的随机整数作为列
%预分配内存
XX_R_SP=zeros(1,NN);YY_R_SP=zeros(1,NN);        %水平

XX_R_CZ=zeros(1,NN);YY_R_CZ=zeros(1,NN);        %垂直

XX_R_DJX=zeros(1,NN);YY_R_DJX=zeros(1,NN);      %对角线

for i=1:NN
    %水平
    XX_R_SP(i)=I(x1(i),y1(i));
    YY_R_SP(i)=I(x1(i)+1,y1(i));
 
    %垂直
    XX_R_CZ(i)=I(x1(i),y1(i));
    YY_R_CZ(i)=I(x1(i),y1(i)+1);
  
    %对角线
    XX_R_DJX(i)=I(x1(i),y1(i));
    YY_R_DJX(i)=I(x1(i)+1,y1(i)+1);
  
end
%水平
% figure;scatter(XX_R_SP,YY_R_SP,18,'filled');xlabel('Pixel value on loation(x,y)');ylabel('Pixel value on loation(x+1,y)');title('Horizontal direction');axis([0 255,0 255]);set(gca,'XTick',0:15:255);set(gca,'YTick',0:15:255);
% 
% %垂直
% figure;scatter(XX_R_CZ,YY_R_CZ,18,'filled');xlabel('Pixel value on loation(x,y)');ylabel('Pixel value on loation(x,y+1)');title('Vertical direction');axis([0 255,0 255]);set(gca,'XTick',0:15:255);set(gca,'YTick',0:15:255);
% 
% %对角线
% figure;scatter(XX_R_DJX,YY_R_DJX,18,'filled');xlabel('Pixel value on loation(x,y)');ylabel('Pixel value on loation(x+1,y+1)');title('Diagonal direction');axis([0 255,0 255]);set(gca,'XTick',0:15:255);set(gca,'YTick',0:15:255);
% %R通道
EX1_R=0;EY1_SP_R=0;DX1_R=0;DY1_SP_R=0;COVXY1_SP_R=0;    %计算水平相关性时需要的变量
EY1_CZ_R=0;DY1_CZ_R=0;COVXY1_CZ_R=0;                %垂直
EY1_DJX_R=0;DY1_DJX_R=0;COVXY1_DJX_R=0;             %对角线
%I=double(I);

for i=1:NN
    %第一个像素点的E，水平、垂直、对角线时计算得出的第一个像素点的E相同，统一用EX1表示
    EX1_R=EX1_R+I(x1(i),y1(i)); 
    %第二个像素点的E，水平、垂直、对角线的E分别对应EY1_SP、EY1_CZ、EY1_DJX
    EY1_SP_R=EY1_SP_R+I(x1(i),y1(i)+1);
    EY1_CZ_R=EY1_CZ_R+I(x1(i)+1,y1(i));
    EY1_DJX_R=EY1_DJX_R+I(x1(i)+1,y1(i)+1);
end
%统一在循环外除以像素点对数1000，可减少运算次数
% R通道
EX1_R=EX1_R/NN;
EY1_SP_R=EY1_SP_R/NN;
EY1_CZ_R=EY1_CZ_R/NN;
EY1_DJX_R=EY1_DJX_R/NN;
for i=1:NN
    %第一个像素点的D，水平、垂直、对角线时计算得出第一个像素点的D相同，统一用DX表示
    DX1_R=DX1_R+(I(x1(i),y1(i))-EX1_R)^2;
    %第二个像素点的D，水平、垂直、对角线的D分别对应DY1_SP、DY1_CZ、DY1_DJX
    %R通道
    DY1_SP_R=DY1_SP_R+(I(x1(i),y1(i)+1)-EY1_SP_R)^2;
    DY1_CZ_R=DY1_CZ_R+(I(x1(i)+1,y1(i))-EY1_CZ_R)^2;
    DY1_DJX_R=DY1_DJX_R+(I(x1(i)+1,y1(i)+1)-EY1_DJX_R)^2;
    
    %两个相邻像素点相关函数的计算，水平、垂直、对角线
    %R通道
    COVXY1_SP_R=COVXY1_SP_R+(I(x1(i),y1(i))-EX1_R)*(I(x1(i),y1(i)+1)-EY1_SP_R);
    COVXY1_CZ_R=COVXY1_CZ_R+(I(x1(i),y1(i))-EX1_R)*(I(x1(i)+1,y1(i))-EY1_CZ_R);
    COVXY1_DJX_R=COVXY1_DJX_R+(I(x1(i),y1(i))-EX1_R)*(I(x1(i)+1,y1(i)+1)-EY1_DJX_R);
    
end
%统一在循环外除以像素点对数1000，可减少运算次数
%R通道
DX1_R=DX1_R/NN;
DY1_SP_R=DY1_SP_R/NN;
DY1_CZ_R=DY1_CZ_R/NN;
DY1_DJX_R=DY1_DJX_R/NN;
COVXY1_SP_R=COVXY1_SP_R/NN;
COVXY1_CZ_R=COVXY1_CZ_R/NN;
COVXY1_DJX_R=COVXY1_DJX_R/NN;

%水平、垂直、对角线的相关性
%R通道
RXY1_SP_R=COVXY1_SP_R/sqrt(DX1_R*DY1_SP_R)
RXY1_CZ_R=COVXY1_CZ_R/sqrt(DX1_R*DY1_CZ_R)
RXY1_DJX_R=COVXY1_DJX_R/sqrt(DX1_R*DY1_DJX_R)



