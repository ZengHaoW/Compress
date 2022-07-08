%% ����ϵͳ��������Է���
%   @author:���
%   @date:2020.04.17
%% ԭʼͼ��������������Է���
%{
�������0~M-1�к�0~N-1��ѡ��5000�����ص㣬
����ˮƽ�����ʱ��ѡ��ÿ��������ڵ��ұߵĵ㣻
���㴹ֱ�����ʱ��ѡ��ÿ��������ڵ��·��ĵ㣻
����Խ��������ʱ��ѡ��ÿ��������ڵ����·��ĵ㡣
%}
clear;clc;
I=imread('./data/black/suoluetu_E.tiff');         %��ȡͼ����Ϣ


J1=I;             %��ȡͼ����Ϣ

I = J1;
I1=I;        %R
I2=I;        %G
I3=I;        %B
Q_R=I;
Q_G=I;
Q_B=I;
[M,N]=size(I1);                      %��ͼ������и�ֵ��M,N
NN=2000;    %���ȡ5000�����ص�
x1=ceil(rand(1,NN)*(M-1));      %����5000��1~M-1�����������Ϊ��
y1=ceil(rand(1,NN)*(N-1));      %����5000��1~N-1�����������Ϊ��
%Ԥ�����ڴ�
XX_R_SP=zeros(1,NN);YY_R_SP=zeros(1,NN);        %ˮƽ
XX_G_SP=zeros(1,NN);YY_G_SP=zeros(1,NN);
XX_B_SP=zeros(1,NN);YY_B_SP=zeros(1,NN);
XX_R_CZ=zeros(1,NN);YY_R_CZ=zeros(1,NN);        %��ֱ
XX_G_CZ=zeros(1,NN);YY_G_CZ=zeros(1,NN);
XX_B_CZ=zeros(1,NN);YY_B_CZ=zeros(1,NN);
XX_R_DJX=zeros(1,NN);YY_R_DJX=zeros(1,NN);      %�Խ���
XX_G_DJX=zeros(1,NN);YY_G_DJX=zeros(1,NN);
XX_B_DJX=zeros(1,NN);YY_B_DJX=zeros(1,NN);
for i=1:NN
    %ˮƽ
    XX_R_SP(i)=I1(x1(i),y1(i));
    YY_R_SP(i)=I1(x1(i)+1,y1(i));
    XX_G_SP(i)=I2(x1(i),y1(i));
    YY_G_SP(i)=I2(x1(i)+1,y1(i));
    XX_B_SP(i)=I3(x1(i),y1(i));
    YY_B_SP(i)=I3(x1(i)+1,y1(i));
    %��ֱ
    XX_R_CZ(i)=I1(x1(i),y1(i));
    YY_R_CZ(i)=I1(x1(i),y1(i)+1);
    XX_G_CZ(i)=I2(x1(i),y1(i));
    YY_G_CZ(i)=I2(x1(i),y1(i)+1);
    XX_B_CZ(i)=I3(x1(i),y1(i));
    YY_B_CZ(i)=I3(x1(i),y1(i)+1);
    %�Խ���
    XX_R_DJX(i)=I1(x1(i),y1(i));
    YY_R_DJX(i)=I1(x1(i)+1,y1(i)+1);
    XX_G_DJX(i)=I2(x1(i),y1(i));
    YY_G_DJX(i)=I2(x1(i)+1,y1(i)+1);
    XX_B_DJX(i)=I3(x1(i),y1(i));
    YY_B_DJX(i)=I3(x1(i)+1,y1(i)+1);
end
%ˮƽ
R=figure('color',[1 1 1]);
scatter(XX_R_SP,YY_R_SP,18,'filled');
xlabel('Gray value of random pixels');
ylabel('Gray value of pixel in horizontal direction adjacent to the point');
% title('ԭʼͼ��Rͨ��ˮƽ����Ԫ������Ե�ͼ');
axis([0 255,0 255]);
set(gca,'XTick',0:15:255);
set(gca,'YTick',0:15:255);
frame = getframe(R);
R_original_Horizontal=frame2im(frame);
imwrite(R_original_Horizontal,'./testImage/lena����ǰˮƽ.png','png');
% imwrite(R_original_Horizontal,'../������������Է���ͼƬ/����/����ǰRͨ��ˮƽ����Ե�ͼ.png','png');
% imwrite(R_original_Horizontal,'../������������Է���ͼƬ/����/����ǰRͨ��ˮƽ����Ե�ͼ.png','png');
% imwrite(R_original_Horizontal,'../������������Է���ͼƬ/�ɻ�/����ǰRͨ��ˮƽ����Ե�ͼ.png','png');
% imwrite(R_original_Horizontal,'../������������Է���ͼƬ/4.1.05����/����ǰRͨ��ˮƽ����Ե�ͼ.png','png');
% imwrite(R_original_Horizontal,'../������������Է���ͼƬ/4.2.06С��/����ǰRͨ��ˮƽ����Ե�ͼ.png','png');
% imwrite(R_original_Horizontal,'../������������Է���ͼƬ/����/����ǰRͨ��ˮƽ����Ե�ͼ.png','png');
% imwrite(R_original_Horizontal,'../������������Է���ͼƬ/�Ǳ�/����ǰRͨ��ˮƽ����Ե�ͼ.png','png');

% R=figure('color',[1 1 1]);
% scatter(XX_G_SP,YY_G_SP,18,'filled');
% xlabel('Gͨ����������ػҶ�ֵ');
% ylabel('��õ�����ˮƽ�������ػҶ�ֵ');
% title('ԭʼͼ��Gͨ��ˮƽ����Ԫ������Ե�ͼ');
% axis([0 255,0 255]);
% set(gca,'XTick',0:15:255);
% set(gca,'YTick',0:15:255);
% frame = getframe(R);
% G_original_Horizontal=frame2im(frame);
% imwrite(G_original_Horizontal,'../������������Է���ͼƬ/lena/����ǰGͨ��ˮƽ����Ե�ͼ.png','png');
% % imwrite(G_original_Horizontal,'../������������Է���ͼƬ/����/����ǰGͨ��ˮƽ����Ե�ͼ.png','png');
% % imwrite(G_original_Horizontal,'../������������Է���ͼƬ/����/����ǰGͨ��ˮƽ����Ե�ͼ.png','png');
% % imwrite(G_original_Horizontal,'../������������Է���ͼƬ/�ɻ�/����ǰGͨ��ˮƽ����Ե�ͼ.png','png');
% % imwrite(G_original_Horizontal,'../������������Է���ͼƬ/4.1.05����/����ǰGͨ��ˮƽ����Ե�ͼ.png','png');
% % imwrite(G_original_Horizontal,'../������������Է���ͼƬ/4.2.06С��/����ǰGͨ��ˮƽ����Ե�ͼ.png','png');
% % imwrite(G_original_Horizontal,'../������������Է���ͼƬ/����/����ǰGͨ��ˮƽ����Ե�ͼ.png','png');
% % imwrite(G_original_Horizontal,'../������������Է���ͼƬ/�Ǳ�/����ǰGͨ��ˮƽ����Ե�ͼ.png','png');
% 
% R=figure('color',[1 1 1]);
% scatter(XX_B_SP,YY_B_SP,18,'filled');
% xlabel('Bͨ����������ػҶ�ֵ');
% ylabel('��õ�����ˮƽ�������ػҶ�ֵ');
% title('ԭʼͼ��Bͨ��ˮƽ����Ԫ������Ե�ͼ');
% axis([0 255,0 255]);
% set(gca,'XTick',0:15:255);
% set(gca,'YTick',0:15:255);
% frame = getframe(R);
% B_original_Horizontal=frame2im(frame);
% imwrite(B_original_Horizontal,'../������������Է���ͼƬ/lena/����ǰBͨ��ˮƽ����Ե�ͼ.png','png');
% % imwrite(B_original_Horizontal,'../������������Է���ͼƬ/����/����ǰBͨ��ˮƽ����Ե�ͼ.png','png');
% % imwrite(B_original_Horizontal,'../������������Է���ͼƬ/����/����ǰBͨ��ˮƽ����Ե�ͼ.png','png');
% % imwrite(B_original_Horizontal,'../������������Է���ͼƬ/�ɻ�/����ǰBͨ��ˮƽ����Ե�ͼ.png','png');
% % imwrite(B_original_Horizontal,'../������������Է���ͼƬ/4.1.05����/����ǰBͨ��ˮƽ����Ե�ͼ.png','png');
% % imwrite(B_original_Horizontal,'../������������Է���ͼƬ/4.2.06С��/����ǰBͨ��ˮƽ����Ե�ͼ.png','png');
% % imwrite(B_original_Horizontal,'../������������Է���ͼƬ/����/����ǰBͨ��ˮƽ����Ե�ͼ.png','png');
% % imwrite(B_original_Horizontal,'../������������Է���ͼƬ/�Ǳ�/����ǰBͨ��ˮƽ����Ե�ͼ.png','png');
%��ֱ
R=figure('color',[1 1 1]);
scatter(XX_R_CZ,YY_R_CZ,18,'filled');
xlabel('Gray value of random pixels');
ylabel('Gray value of pixel in the vertical direction adjacent to the point');
% title('ԭʼͼ��Rͨ����ֱ����Ԫ������Ե�ͼ');
axis([0 255,0 255]);
set(gca,'XTick',0:15:255);
set(gca,'YTick',0:15:255);
frame = getframe(R);
R_original_Vertical=frame2im(frame);
imwrite(R_original_Vertical,'./testImage/lena����ǰ��ֱ.png','png'); 
% imwrite(R_original_Vertical,'../������������Է���ͼƬ/����/����ǰRͨ����ֱ����Ե�ͼ.png','png');
% imwrite(R_original_Vertical,'../������������Է���ͼƬ/����/����ǰRͨ����ֱ����Ե�ͼ.png','png');
% imwrite(R_original_Vertical,'../������������Է���ͼƬ/�ɻ�/����ǰRͨ����ֱ����Ե�ͼ.png','png');
% imwrite(R_original_Vertical,'../������������Է���ͼƬ/4.1.05����/����ǰRͨ����ֱ����Ե�ͼ.png','png');
% imwrite(R_original_Vertical,'../������������Է���ͼƬ/4.2.06С��/����ǰRͨ����ֱ����Ե�ͼ.png','png');
% imwrite(R_original_Vertical,'../������������Է���ͼƬ/����/����ǰRͨ����ֱ����Ե�ͼ.png','png');
% imwrite(R_original_Vertical,'../������������Է���ͼƬ/�Ǳ�/����ǰRͨ����ֱ����Ե�ͼ.png','png');

% R=figure('color',[1 1 1]);
% scatter(XX_G_CZ,YY_G_CZ,18,'filled');
% xlabel('Gͨ����������ػҶ�ֵ');
% ylabel('��õ����ڴ�ֱ�������ػҶ�ֵ');
% title('ԭʼͼ��Gͨ����ֱ����Ԫ������Ե�ͼ');
% axis([0 255,0 255]);
% set(gca,'XTick',0:15:255);
% set(gca,'YTick',0:15:255);
% frame = getframe(R);
% G_original_Vertical=frame2im(frame);
% imwrite(G_original_Vertical,'../������������Է���ͼƬ/lena/����ǰGͨ����ֱ����Ե�ͼ.png','png');
% % imwrite(G_original_Vertical,'../������������Է���ͼƬ/����/����ǰGͨ����ֱ����Ե�ͼ.png','png');
% % imwrite(G_original_Vertical,'../������������Է���ͼƬ/����/����ǰGͨ����ֱ����Ե�ͼ.png','png');
% % imwrite(G_original_Vertical,'../������������Է���ͼƬ/�ɻ�/����ǰGͨ����ֱ����Ե�ͼ.png','png');
% % imwrite(G_original_Vertical,'../������������Է���ͼƬ/4.1.05����/����ǰGͨ����ֱ����Ե�ͼ.png','png');
% % imwrite(G_original_Vertical,'../������������Է���ͼƬ/4.2.06С��/����ǰGͨ����ֱ����Ե�ͼ.png','png');
% % imwrite(G_original_Vertical,'../������������Է���ͼƬ/����/����ǰGͨ����ֱ����Ե�ͼ.png','png');
% % imwrite(G_original_Vertical,'../������������Է���ͼƬ/�Ǳ�/����ǰGͨ����ֱ����Ե�ͼ.png','png');
% 
% R=figure('color',[1 1 1]);
% scatter(XX_B_CZ,YY_B_CZ,18,'filled');
% xlabel('Bͨ����������ػҶ�ֵ');
% ylabel('��õ����ڴ�ֱ�������ػҶ�ֵ');
% title('ԭʼͼ��Bͨ����ֱ����Ԫ������Ե�ͼ');
% axis([0 255,0 255]);
% set(gca,'XTick',0:15:255);
% set(gca,'YTick',0:15:255);
% frame = getframe(R);
% B_original_Vertical=frame2im(frame);
% imwrite(B_original_Vertical,'../������������Է���ͼƬ/lena/����ǰBͨ����ֱ����Ե�ͼ.png','png');
% % imwrite(B_original_Vertical,'../������������Է���ͼƬ/����/����ǰBͨ����ֱ����Ե�ͼ.png','png');
% % imwrite(B_original_Vertical,'../������������Է���ͼƬ/����/����ǰBͨ����ֱ����Ե�ͼ.png','png');
% % imwrite(B_original_Vertical,'../������������Է���ͼƬ/�ɻ�/����ǰBͨ����ֱ����Ե�ͼ.png','png');
% % imwrite(B_original_Vertical,'../������������Է���ͼƬ/4.1.05����/����ǰBͨ����ֱ����Ե�ͼ.png','png');
% % imwrite(B_original_Vertical,'../������������Է���ͼƬ/4.2.06С��/����ǰBͨ����ֱ����Ե�ͼ.png','png');
% % imwrite(B_original_Vertical,'../������������Է���ͼƬ/����/����ǰBͨ����ֱ����Ե�ͼ.png','png');
% % imwrite(B_original_Vertical,'../������������Է���ͼƬ/�Ǳ�/����ǰBͨ����ֱ����Ե�ͼ.png','png');

%�Խ���
R=figure('color',[1 1 1]);
scatter(XX_R_DJX,YY_R_DJX,18,'filled');
xlabel('Gray value of random pixels');
ylabel('Gray value of pixel in diagonal direction adjacent to the point');
% title('ԭʼͼ��Rͨ���Խ�������Ԫ������Ե�ͼ');
axis([0 255,0 255]);
set(gca,'XTick',0:15:255);
set(gca,'YTick',0:15:255);
frame = getframe(R);
R_original_Diagonal=frame2im(frame);
imwrite(R_original_Diagonal,'./testImage/lena/lena_suoluetu����ǰ�Խ�.png','png');
% imwrite(R_original_Diagonal,'../������������Է���ͼƬ/����/����ǰRͨ���Խ�������Ե�ͼ.png','png');
% imwrite(R_original_Diagonal,'../������������Է���ͼƬ/����/����ǰRͨ���Խ�������Ե�ͼ.png','png');
% imwrite(R_original_Diagonal,'../������������Է���ͼƬ/�ɻ�/����ǰRͨ���Խ�������Ե�ͼ.png','png');
% imwrite(R_original_Diagonal,'../������������Է���ͼƬ/4.1.05����/����ǰRͨ���Խ�������Ե�ͼ.png','png');
% imwrite(R_original_Diagonal,'../������������Է���ͼƬ/4.2.06С��/����ǰRͨ���Խ�������Ե�ͼ.png','png');
% imwrite(R_original_Diagonal,'../������������Է���ͼƬ/����/����ǰRͨ���Խ�������Ե�ͼ.png','png');
% imwrite(R_original_Diagonal,'../������������Է���ͼƬ/�Ǳ�/����ǰRͨ���Խ�������Ե�ͼ.png','png');

% R=figure('color',[1 1 1]);
% scatter(XX_G_DJX,YY_G_DJX,18,'filled');
% xlabel('Gͨ����������ػҶ�ֵ');
% ylabel('��õ����ڶԽ��߷������ػҶ�ֵ');
% title('ԭʼͼ��Gͨ���Խ�������Ԫ������Ե�ͼ');
% axis([0 255,0 255]);
% set(gca,'XTick',0:15:255);
% set(gca,'YTick',0:15:255);
% frame = getframe(R);
% G_original_Diagonal=frame2im(frame);
% imwrite(G_original_Diagonal,'../������������Է���ͼƬ/lena/����ǰGͨ���Խ�������Ե�ͼ.png','png');
% % imwrite(G_original_Diagonal,'../������������Է���ͼƬ/����/����ǰGͨ���Խ�������Ե�ͼ.png','png');
% % imwrite(G_original_Diagonal,'../������������Է���ͼƬ/����/����ǰGͨ���Խ�������Ե�ͼ.png','png');
% % imwrite(G_original_Diagonal,'../������������Է���ͼƬ/�ɻ�/����ǰGͨ���Խ�������Ե�ͼ.png','png');
% % imwrite(G_original_Diagonal,'../������������Է���ͼƬ/4.1.05����/����ǰGͨ���Խ�������Ե�ͼ.png','png');
% % imwrite(G_original_Diagonal,'../������������Է���ͼƬ/4.2.06С��/����ǰGͨ���Խ�������Ե�ͼ.png','png');
% % imwrite(G_original_Diagonal,'../������������Է���ͼƬ/����/����ǰGͨ���Խ�������Ե�ͼ.png','png');
% % imwrite(G_original_Diagonal,'../������������Է���ͼƬ/�Ǳ�/����ǰGͨ���Խ�������Ե�ͼ.png','png');
% 
% R=figure('color',[1 1 1]);
% scatter(XX_B_DJX,YY_B_DJX,18,'filled');
% xlabel('Bͨ����������ػҶ�ֵ');
% ylabel('��õ����ڶԽ��߷������ػҶ�ֵ');
% title('ԭʼͼ��Bͨ���Խ�������Ԫ������Ե�ͼ');
% axis([0 255,0 255]);
% set(gca,'XTick',0:15:255);
% set(gca,'YTick',0:15:255);
% frame = getframe(R);
% B_original_Diagonal=frame2im(frame);
% imwrite(B_original_Diagonal,'../������������Է���ͼƬ/lena/����ǰBͨ���Խ�������Ե�ͼ.png','png');
% % imwrite(B_original_Diagonal,'../������������Է���ͼƬ/����/����ǰBͨ���Խ�������Ե�ͼ.png','png');
% % imwrite(B_original_Diagonal,'../������������Է���ͼƬ/����/����ǰBͨ���Խ�������Ե�ͼ.png','png');
% % imwrite(B_original_Diagonal,'../������������Է���ͼƬ/�ɻ�/����ǰBͨ���Խ�������Ե�ͼ.png','png');
% % imwrite(B_original_Diagonal,'../������������Է���ͼƬ/4.1.05����/����ǰBͨ���Խ�������Ե�ͼ.png','png');
% % imwrite(B_original_Diagonal,'../������������Է���ͼƬ/4.2.06С��/����ǰBͨ���Խ�������Ե�ͼ.png','png');
% % imwrite(B_original_Diagonal,'../������������Է���ͼƬ/����/����ǰBͨ���Խ�������Ե�ͼ.png','png');
% % imwrite(B_original_Diagonal,'../������������Է���ͼƬ/�Ǳ�/����ǰBͨ���Խ�������Ե�ͼ.png','png');

%Rͨ��
EX1_R=0;EY1_SP_R=0;DX1_R=0;DY1_SP_R=0;COVXY1_SP_R=0;    %����ˮƽ�����ʱ��Ҫ�ı���
EY1_CZ_R=0;DY1_CZ_R=0;COVXY1_CZ_R=0;                %��ֱ
EY1_DJX_R=0;DY1_DJX_R=0;COVXY1_DJX_R=0;             %�Խ���
%Gͨ��
EX1_G=0;EY1_SP_G=0;DX1_G=0;DY1_SP_G=0;COVXY1_SP_G=0;
EY1_CZ_G=0;DY1_CZ_G=0;COVXY1_CZ_G=0;
EY1_DJX_G=0;DY1_DJX_G=0;COVXY1_DJX_G=0;
%Bͨ��
EX1_B=0;EY1_SP_B=0;DX1_B=0;DY1_SP_B=0;COVXY1_SP_B=0;
EY1_CZ_B=0;DY1_CZ_B=0;COVXY1_CZ_B=0;
EY1_DJX_B=0;DY1_DJX_B=0;COVXY1_DJX_B=0;

I1=double(I1);%��I1ת����˫���ȸ�������
I2=double(I2);%��I2ת����˫���ȸ�������
I3=double(I3);%��I3ת����˫���ȸ�������
for i=1:NN
    %��һ�����ص��E��ˮƽ����ֱ���Խ���ʱ����ó��ĵ�һ�����ص��E��ͬ��ͳһ��EX1��ʾ
    EX1_R=EX1_R+I1(x1(i),y1(i)); 
    EX1_G=EX1_G+I2(x1(i),y1(i)); 
    EX1_B=EX1_B+I3(x1(i),y1(i)); 
    %�ڶ������ص��E��ˮƽ����ֱ���Խ��ߵ�E�ֱ��ӦEY1_SP��EY1_CZ��EY1_DJX
    %Rͨ��
    EY1_SP_R=EY1_SP_R+I1(x1(i),y1(i)+1);
    EY1_CZ_R=EY1_CZ_R+I1(x1(i)+1,y1(i));
    EY1_DJX_R=EY1_DJX_R+I1(x1(i)+1,y1(i)+1);
    %Gͨ��
    EY1_SP_G=EY1_SP_G+I2(x1(i),y1(i)+1);
    EY1_CZ_G=EY1_CZ_G+I2(x1(i)+1,y1(i));
    EY1_DJX_G=EY1_DJX_G+I2(x1(i)+1,y1(i)+1);
    %Bͨ��
    EY1_SP_B=EY1_SP_B+I3(x1(i),y1(i)+1);
    EY1_CZ_B=EY1_CZ_B+I3(x1(i)+1,y1(i));
    EY1_DJX_B=EY1_DJX_B+I3(x1(i)+1,y1(i)+1);
end
%ͳһ��ѭ����������ص����1000���ɼ����������
% Rͨ��
EX1_R=EX1_R/NN;
EY1_SP_R=EY1_SP_R/NN;
EY1_CZ_R=EY1_CZ_R/NN;
EY1_DJX_R=EY1_DJX_R/NN;
% Gͨ��
EX1_G=EX1_G/NN;
EY1_SP_G=EY1_SP_G/NN;
EY1_CZ_G=EY1_CZ_G/NN;
EY1_DJX_G=EY1_DJX_G/NN;
% Bͨ��
EX1_B=EX1_B/NN;
EY1_SP_B=EY1_SP_B/NN;
EY1_CZ_B=EY1_CZ_B/NN;
EY1_DJX_B=EY1_DJX_B/NN;
for i=1:NN
    %��һ�����ص��D��ˮƽ����ֱ���Խ���ʱ����ó���һ�����ص��D��ͬ��ͳһ��DX��ʾ
    DX1_R=DX1_R+(I1(x1(i),y1(i))-EX1_R)^2;
    DX1_G=DX1_G+(I2(x1(i),y1(i))-EX1_G)^2;
    DX1_B=DX1_B+(I3(x1(i),y1(i))-EX1_B)^2;
    %�ڶ������ص��D��ˮƽ����ֱ���Խ��ߵ�D�ֱ��ӦDY1_SP��DY1_CZ��DY1_DJX
    %Rͨ��
    DY1_SP_R=DY1_SP_R+(I1(x1(i),y1(i)+1)-EY1_SP_R)^2;
    DY1_CZ_R=DY1_CZ_R+(I1(x1(i)+1,y1(i))-EY1_CZ_R)^2;
    DY1_DJX_R=DY1_DJX_R+(I1(x1(i)+1,y1(i)+1)-EY1_DJX_R)^2;
    %Gͨ��
    DY1_SP_G=DY1_SP_G+(I2(x1(i),y1(i)+1)-EY1_SP_G)^2;
    DY1_CZ_G=DY1_CZ_G+(I2(x1(i)+1,y1(i))-EY1_CZ_G)^2;
    DY1_DJX_G=DY1_DJX_G+(I2(x1(i)+1,y1(i)+1)-EY1_DJX_G)^2;
    %Bͨ��
    DY1_SP_B=DY1_SP_B+(I3(x1(i),y1(i)+1)-EY1_SP_B)^2;
    DY1_CZ_B=DY1_CZ_B+(I3(x1(i)+1,y1(i))-EY1_CZ_B)^2;
    DY1_DJX_B=DY1_DJX_B+(I3(x1(i)+1,y1(i)+1)-EY1_DJX_B)^2;
    %�����������ص���غ����ļ��㣬ˮƽ����ֱ���Խ���
    %Rͨ��
    COVXY1_SP_R=COVXY1_SP_R+(I1(x1(i),y1(i))-EX1_R)*(I1(x1(i),y1(i)+1)-EY1_SP_R);
    COVXY1_CZ_R=COVXY1_CZ_R+(I1(x1(i),y1(i))-EX1_R)*(I1(x1(i)+1,y1(i))-EY1_CZ_R);
    COVXY1_DJX_R=COVXY1_DJX_R+(I1(x1(i),y1(i))-EX1_R)*(I1(x1(i)+1,y1(i)+1)-EY1_DJX_R);
    %Gͨ��
    COVXY1_SP_G=COVXY1_SP_G+(I2(x1(i),y1(i))-EX1_G)*(I2(x1(i),y1(i)+1)-EY1_SP_G);
    COVXY1_CZ_G=COVXY1_CZ_G+(I2(x1(i),y1(i))-EX1_G)*(I2(x1(i)+1,y1(i))-EY1_CZ_G);
    COVXY1_DJX_G=COVXY1_DJX_G+(I2(x1(i),y1(i))-EX1_G)*(I2(x1(i)+1,y1(i)+1)-EY1_DJX_G);
    %Bͨ��
    COVXY1_SP_B=COVXY1_SP_B+(I3(x1(i),y1(i))-EX1_B)*(I3(x1(i),y1(i)+1)-EY1_SP_B);
    COVXY1_CZ_B=COVXY1_CZ_B+(I3(x1(i),y1(i))-EX1_B)*(I3(x1(i)+1,y1(i))-EY1_CZ_B);
    COVXY1_DJX_B=COVXY1_DJX_B+(I3(x1(i),y1(i))-EX1_B)*(I3(x1(i)+1,y1(i)+1)-EY1_DJX_B);
end
%ͳһ��ѭ����������ص����1000���ɼ����������
%Rͨ��
DX1_R=DX1_R/NN;
DY1_SP_R=DY1_SP_R/NN;
DY1_CZ_R=DY1_CZ_R/NN;
DY1_DJX_R=DY1_DJX_R/NN;
COVXY1_SP_R=COVXY1_SP_R/NN;
COVXY1_CZ_R=COVXY1_CZ_R/NN;
COVXY1_DJX_R=COVXY1_DJX_R/NN;
%Gͨ��
DX1_G=DX1_G/NN;
DY1_SP_G=DY1_SP_G/NN;
DY1_CZ_G=DY1_CZ_G/NN;
DY1_DJX_G=DY1_DJX_G/NN;
COVXY1_SP_G=COVXY1_SP_G/NN;
COVXY1_CZ_G=COVXY1_CZ_G/NN;
COVXY1_DJX_G=COVXY1_DJX_G/NN;
%Bͨ��
DX1_B=DX1_B/NN;
DY1_SP_B=DY1_SP_B/NN;
DY1_CZ_B=DY1_CZ_B/NN;
DY1_DJX_B=DY1_DJX_B/NN;
COVXY1_SP_B=COVXY1_SP_B/NN;
COVXY1_CZ_B=COVXY1_CZ_B/NN;
COVXY1_DJX_B=COVXY1_DJX_B/NN;
%ˮƽ����ֱ���Խ��ߵ������
%Rͨ��
RXY1_SP_R=COVXY1_SP_R/sqrt(DX1_R*DY1_SP_R);
RXY1_CZ_R=COVXY1_CZ_R/sqrt(DX1_R*DY1_CZ_R);
RXY1_DJX_R=COVXY1_DJX_R/sqrt(DX1_R*DY1_DJX_R);
%Gͨ��
RXY1_SP_G=COVXY1_SP_G/sqrt(DX1_G*DY1_SP_G);
RXY1_CZ_G=COVXY1_CZ_G/sqrt(DX1_G*DY1_CZ_G);
RXY1_DJX_G=COVXY1_DJX_G/sqrt(DX1_G*DY1_DJX_G);
%Bͨ��
RXY1_SP_B=COVXY1_SP_B/sqrt(DX1_B*DY1_SP_B);
RXY1_CZ_B=COVXY1_CZ_B/sqrt(DX1_B*DY1_CZ_B);
RXY1_DJX_B=COVXY1_DJX_B/sqrt(DX1_B*DY1_DJX_B);

%% ����ͼ������ͼ������Է���
%{
�������0~M-1�к�0~N-1��ѡ��1000�����ص㣬
����ˮƽ�����ʱ��ѡ��ÿ��������ڵ��ұߵĵ㣻
���㴹ֱ�����ʱ��ѡ��ÿ��������ڵ��·��ĵ㣻
����Խ��������ʱ��ѡ��ÿ��������ڵ����·��ĵ㡣
%}
%���������
%ˮƽ
XX_R_SP=zeros(1,NN);YY_R_SP=zeros(1,NN);  %Ԥ�����ڴ�
XX_G_SP=zeros(1,NN);YY_G_SP=zeros(1,NN);
XX_B_SP=zeros(1,NN);YY_B_SP=zeros(1,NN);
%��ֱ
XX_R_CZ=zeros(1,NN);YY_R_CZ=zeros(1,NN);  %Ԥ�����ڴ�
XX_G_CZ=zeros(1,NN);YY_G_CZ=zeros(1,NN);
XX_B_CZ=zeros(1,NN);YY_B_CZ=zeros(1,NN);
%�Խ���
XX_R_DJX=zeros(1,NN);YY_R_DJX=zeros(1,NN);  %Ԥ�����ڴ�
XX_G_DJX=zeros(1,NN);YY_G_DJX=zeros(1,NN);
XX_B_DJX=zeros(1,NN);YY_B_DJX=zeros(1,NN);
for i=1:NN
    %ˮƽ
    XX_R_SP(i)=Q_R(x1(i),y1(i));
    YY_R_SP(i)=Q_R(x1(i)+1,y1(i));
    XX_G_SP(i)=Q_G(x1(i),y1(i));
    YY_G_SP(i)=Q_G(x1(i)+1,y1(i));
    XX_B_SP(i)=Q_B(x1(i),y1(i));
    YY_B_SP(i)=Q_B(x1(i)+1,y1(i));
    %��ֱ
    XX_R_CZ(i)=Q_R(x1(i),y1(i));
    YY_R_CZ(i)=Q_R(x1(i),y1(i)+1);
    XX_G_CZ(i)=Q_G(x1(i),y1(i));
    YY_G_CZ(i)=Q_G(x1(i),y1(i)+1);
    XX_B_CZ(i)=Q_B(x1(i),y1(i));
    YY_B_CZ(i)=Q_B(x1(i),y1(i)+1);
    %�Խ���
    XX_R_DJX(i)=Q_R(x1(i),y1(i));
    YY_R_DJX(i)=Q_R(x1(i)+1,y1(i)+1);
    XX_G_DJX(i)=Q_G(x1(i),y1(i));
    YY_G_DJX(i)=Q_G(x1(i)+1,y1(i)+1);
    XX_B_DJX(i)=Q_B(x1(i),y1(i));
    YY_B_DJX(i)=Q_B(x1(i)+1,y1(i)+1);
end
%ˮƽ
R=figure('color',[1 1 1]);
scatter(XX_R_SP,YY_R_SP,18,'filled');
xlabel('Gray value of random pixels in R channel');
ylabel('Gray value of pixel in horizontal direction adjacent to the point');
% title('����ͼ��Rͨ��ˮƽ����Ԫ������Ե�ͼ');
axis([0 255,0 255]);
set(gca,'XTick',0:15:255);
set(gca,'YTick',0:15:255);
frame = getframe(R);
R_aftet_Horizontal=frame2im(frame);
imwrite(R_aftet_Horizontal,'./testImage/lena���ܺ�.png','png');
% imwrite(R_aftet_Horizontal,'../������������Է���ͼƬ/����/���ܺ�Rͨ��ˮƽ����Ե�ͼ.png','png');
% imwrite(R_aftet_Horizontal,'../������������Է���ͼƬ/����/���ܺ�Rͨ��ˮƽ����Ե�ͼ.png','png');
% imwrite(R_aftet_Horizontal,'../������������Է���ͼƬ/�ɻ�/���ܺ�Rͨ��ˮƽ����Ե�ͼ.png','png');
% imwrite(R_aftet_Horizontal,'../������������Է���ͼƬ/4.1.05����/���ܺ�Rͨ��ˮƽ����Ե�ͼ.png','png');
% imwrite(R_aftet_Horizontal,'../������������Է���ͼƬ/4.2.06С��/���ܺ�Rͨ��ˮƽ����Ե�ͼ.png','png');
% imwrite(R_aftet_Horizontal,'../������������Է���ͼƬ/����/���ܺ�Rͨ��ˮƽ����Ե�ͼ.png','png');
% imwrite(R_aftet_Horizontal,'../������������Է���ͼƬ/�Ǳ�/���ܺ�Rͨ��ˮƽ����Ե�ͼ.png','png');

% R=figure('color',[1 1 1]);
% scatter(XX_G_SP,YY_G_SP,18,'filled');
% xlabel('Gͨ����������ػҶ�ֵ');
% ylabel('��õ�����ˮƽ�������ػҶ�ֵ');
% title('����ͼ��Gͨ��ˮƽ����Ԫ������Ե�ͼ');
% axis([0 255,0 255]);
% set(gca,'XTick',0:15:255);
% set(gca,'YTick',0:15:255);
% frame = getframe(R);
% G_aftet_Horizontal=frame2im(frame);
% imwrite(G_aftet_Horizontal,'../������������Է���ͼƬ/lena/���ܺ�Gͨ��ˮƽ����Ե�ͼ.png','png');
% % imwrite(G_aftet_Horizontal,'../������������Է���ͼƬ/����/���ܺ�Gͨ��ˮƽ����Ե�ͼ.png','png');
% % imwrite(G_aftet_Horizontal,'../������������Է���ͼƬ/����/���ܺ�Gͨ��ˮƽ����Ե�ͼ.png','png');
% % imwrite(G_aftet_Horizontal,'../������������Է���ͼƬ/�ɻ�/���ܺ�Gͨ��ˮƽ����Ե�ͼ.png','png');
% % imwrite(G_aftet_Horizontal,'../������������Է���ͼƬ/4.1.05����/���ܺ�Gͨ��ˮƽ����Ե�ͼ.png','png');
% % imwrite(G_aftet_Horizontal,'../������������Է���ͼƬ/4.2.06С��/���ܺ�Gͨ��ˮƽ����Ե�ͼ.png','png');
% % imwrite(G_aftet_Horizontal,'../������������Է���ͼƬ/����/���ܺ�Gͨ��ˮƽ����Ե�ͼ.png','png');
% % imwrite(G_aftet_Horizontal,'../������������Է���ͼƬ/�Ǳ�/���ܺ�Gͨ��ˮƽ����Ե�ͼ.png','png');
% 
% R=figure('color',[1 1 1]);
% scatter(XX_B_SP,YY_B_SP,18,'filled');
% xlabel('Bͨ����������ػҶ�ֵ');
% ylabel('��õ�����ˮƽ�������ػҶ�ֵ');
% title('����ͼ��Bͨ��ˮƽ����Ԫ������Ե�ͼ');
% axis([0 255,0 255]);
% set(gca,'XTick',0:15:255);
% set(gca,'YTick',0:15:255);
% frame = getframe(R);
% B_aftet_Horizontal=frame2im(frame);
% imwrite(B_aftet_Horizontal,'../������������Է���ͼƬ/lena/���ܺ�Bͨ��ˮƽ����Ե�ͼ.png','png');
% % imwrite(B_aftet_Horizontal,'../������������Է���ͼƬ/����/���ܺ�Bͨ��ˮƽ����Ե�ͼ.png','png');
% % imwrite(B_aftet_Horizontal,'../������������Է���ͼƬ/����/���ܺ�Bͨ��ˮƽ����Ե�ͼ.png','png');
% % imwrite(B_aftet_Horizontal,'../������������Է���ͼƬ/�ɻ�/���ܺ�Bͨ��ˮƽ����Ե�ͼ.png','png');
% % imwrite(B_aftet_Horizontal,'../������������Է���ͼƬ/4.1.05����/���ܺ�Bͨ��ˮƽ����Ե�ͼ.png','png');
% % imwrite(B_aftet_Horizontal,'../������������Է���ͼƬ/4.2.06С��/���ܺ�Bͨ��ˮƽ����Ե�ͼ.png','png');
% % imwrite(B_aftet_Horizontal,'../������������Է���ͼƬ/����/���ܺ�Bͨ��ˮƽ����Ե�ͼ.png','png');
% % imwrite(B_aftet_Horizontal,'../������������Է���ͼƬ/�Ǳ�/���ܺ�Bͨ��ˮƽ����Ե�ͼ.png','png');

%��ֱ
R=figure('color',[1 1 1]);
scatter(XX_R_CZ,YY_R_CZ,18,'filled');
xlabel('Gray value of random pixels in R channel');
ylabel('Gray value of pixel in the vertical direction adjacent to the point');
% title('����ͼ��Rͨ����ֱ����Ԫ������Ե�ͼ');
axis([0 255,0 255]);
set(gca,'XTick',0:15:255);
set(gca,'YTick',0:15:255);
frame = getframe(R);
R_aftet_Vertical=frame2im(frame);
% imwrite(R_aftet_Vertical,'../������������Է���ͼƬ/lena/���ܺ�Rͨ����ֱ����Ե�ͼ.png','png');
% imwrite(R_aftet_Vertical,'../������������Է���ͼƬ/����/���ܺ�Rͨ����ֱ����Ե�ͼ.png','png');
% imwrite(R_aftet_Vertical,'../������������Է���ͼƬ/����/���ܺ�Rͨ����ֱ����Ե�ͼ.png','png');
% imwrite(R_aftet_Vertical,'../������������Է���ͼƬ/�ɻ�/���ܺ�Rͨ����ֱ����Ե�ͼ.png','png');
% imwrite(R_aftet_Vertical,'../������������Է���ͼƬ/4.1.05����/���ܺ�Rͨ����ֱ����Ե�ͼ.png','png');
% imwrite(R_aftet_Vertical,'../������������Է���ͼƬ/4.2.06С��/���ܺ�Rͨ����ֱ����Ե�ͼ.png','png');
% imwrite(R_aftet_Vertical,'../������������Է���ͼƬ/����/���ܺ�Rͨ����ֱ����Ե�ͼ.png','png');
% imwrite(R_aftet_Vertical,'../������������Է���ͼƬ/�Ǳ�/���ܺ�Rͨ����ֱ����Ե�ͼ.png','png');

% R=figure('color',[1 1 1]);
% scatter(XX_G_CZ,YY_G_CZ,18,'filled');
% xlabel('Gͨ����������ػҶ�ֵ');
% ylabel('��õ����ڴ�ֱ�������ػҶ�ֵ');
% title('����ͼ��Gͨ����ֱ����Ԫ������Ե�ͼ');
% axis([0 255,0 255]);
% set(gca,'XTick',0:15:255);
% set(gca,'YTick',0:15:255);
% frame = getframe(R);
% G_aftet_Vertical=frame2im(frame);
% imwrite(G_aftet_Vertical,'../������������Է���ͼƬ/lena/���ܺ�Gͨ����ֱ����Ե�ͼ.png','png');
% % imwrite(G_aftet_Vertical,'../������������Է���ͼƬ/����/���ܺ�Gͨ����ֱ����Ե�ͼ.png','png');
% % imwrite(G_aftet_Vertical,'../������������Է���ͼƬ/����/���ܺ�Gͨ����ֱ����Ե�ͼ.png','png');
% % imwrite(G_aftet_Vertical,'../������������Է���ͼƬ/�ɻ�/���ܺ�Gͨ����ֱ����Ե�ͼ.png','png');
% % imwrite(G_aftet_Vertical,'../������������Է���ͼƬ/4.1.05����/���ܺ�Gͨ����ֱ����Ե�ͼ.png','png');
% % imwrite(G_aftet_Vertical,'../������������Է���ͼƬ/4.2.06С��/���ܺ�Gͨ����ֱ����Ե�ͼ.png','png');
% % imwrite(G_aftet_Vertical,'../������������Է���ͼƬ/����/���ܺ�Gͨ����ֱ����Ե�ͼ.png','png');
% % imwrite(G_aftet_Vertical,'../������������Է���ͼƬ/�Ǳ�/���ܺ�Gͨ����ֱ����Ե�ͼ.png','png');
% 
% R=figure('color',[1 1 1]);
% scatter(XX_B_CZ,YY_B_CZ,18,'filled');
% xlabel('Bͨ����������ػҶ�ֵ');
% ylabel('��õ����ڴ�ֱ�������ػҶ�ֵ');
% title('����ͼ��Bͨ����ֱ����Ԫ������Ե�ͼ');
% axis([0 255,0 255]);
% set(gca,'XTick',0:15:255);
% set(gca,'YTick',0:15:255);
% frame = getframe(R);
% B_aftet_Vertical=frame2im(frame);
% imwrite(B_aftet_Vertical,'../������������Է���ͼƬ/lena/���ܺ�Bͨ����ֱ����Ե�ͼ.png','png');
% % imwrite(B_aftet_Vertical,'../������������Է���ͼƬ/����/���ܺ�Bͨ����ֱ����Ե�ͼ.png','png');
% % imwrite(B_aftet_Vertical,'../������������Է���ͼƬ/����/���ܺ�Bͨ����ֱ����Ե�ͼ.png','png');
% % imwrite(B_aftet_Vertical,'../������������Է���ͼƬ/�ɻ�/���ܺ�Bͨ����ֱ����Ե�ͼ.png','png');
% % imwrite(B_aftet_Vertical,'../������������Է���ͼƬ/4.1.05����/���ܺ�Bͨ����ֱ����Ե�ͼ.png','png');
% % imwrite(B_aftet_Vertical,'../������������Է���ͼƬ/4.2.06С��/���ܺ�Bͨ����ֱ����Ե�ͼ.png','png');
% % imwrite(B_aftet_Vertical,'../������������Է���ͼƬ/����/���ܺ�Bͨ����ֱ����Ե�ͼ.png','png');
% % imwrite(B_aftet_Vertical,'../������������Է���ͼƬ/�Ǳ�/���ܺ�Bͨ����ֱ����Ե�ͼ.png','png');

%�Խ���
R=figure('color',[1 1 1]);
scatter(XX_R_DJX,YY_R_DJX,18,'filled');
xlabel('Gray value of random pixels in channel R');
ylabel('Gray value of pixel in diagonal direction adjacent to the point');
% title('����ͼ��Rͨ���Խ�������Ԫ������Ե�ͼ');
axis([0 255,0 255]);
set(gca,'XTick',0:15:255);
set(gca,'YTick',0:15:255);
frame = getframe(R);
R_aftet_Diagonal=frame2im(frame);
% imwrite(R_aftet_Diagonal,'../������������Է���ͼƬ/lena/���ܺ�Rͨ���Խ�������Ե�ͼ.png','png');
% imwrite(R_aftet_Diagonal,'../������������Է���ͼƬ/����/���ܺ�Rͨ���Խ�������Ե�ͼ.png','png');
% imwrite(R_aftet_Diagonal,'../������������Է���ͼƬ/����/���ܺ�Rͨ���Խ�������Ե�ͼ.png','png');
% imwrite(R_aftet_Diagonal,'../������������Է���ͼƬ/�ɻ�/���ܺ�Rͨ���Խ�������Ե�ͼ.png','png');
% imwrite(R_aftet_Diagonal,'../������������Է���ͼƬ/4.1.05����/���ܺ�Rͨ���Խ�������Ե�ͼ.png','png');
% imwrite(R_aftet_Diagonal,'../������������Է���ͼƬ/4.2.06С��/���ܺ�Rͨ���Խ�������Ե�ͼ.png','png');
% imwrite(R_aftet_Diagonal,'../������������Է���ͼƬ/����/���ܺ�Rͨ���Խ�������Ե�ͼ.png','png');
% imwrite(R_aftet_Diagonal,'../������������Է���ͼƬ/�Ǳ�/���ܺ�Rͨ���Խ�������Ե�ͼ.png','png');

% R=figure('color',[1 1 1]);
% scatter(XX_G_DJX,YY_G_DJX,18,'filled');
% xlabel('Gray value of random pixels in channel G');
% ylabel('Gray value of pixel in diagonal direction adjacent to the point');
% % title('����ͼ��Gͨ���Խ�������Ԫ������Ե�ͼ');
% axis([0 255,0 255]);
% set(gca,'XTick',0:15:255);
% set(gca,'YTick',0:15:255);
% frame = getframe(R);
% G_aftet_Diagonal=frame2im(frame);
% imwrite(G_aftet_Diagonal,'../������������Է���ͼƬ/lena/���ܺ�Gͨ���Խ�������Ե�ͼ.png','png');
% % imwrite(G_aftet_Diagonal,'../������������Է���ͼƬ/����/���ܺ�Gͨ���Խ�������Ե�ͼ.png','png');
% % imwrite(G_aftet_Diagonal,'../������������Է���ͼƬ/����/���ܺ�Gͨ���Խ�������Ե�ͼ.png','png');
% % imwrite(G_aftet_Diagonal,'../������������Է���ͼƬ/�ɻ�/���ܺ�Gͨ���Խ�������Ե�ͼ.png','png');
% % imwrite(G_aftet_Diagonal,'../������������Է���ͼƬ/4.1.05����/���ܺ�Gͨ���Խ�������Ե�ͼ.png','png');
% % imwrite(G_aftet_Diagonal,'../������������Է���ͼƬ/4.2.06С��/���ܺ�Gͨ���Խ�������Ե�ͼ.png','png');
% % imwrite(G_aftet_Diagonal,'../������������Է���ͼƬ/����/���ܺ�Gͨ���Խ�������Ե�ͼ.png','png');
% % imwrite(G_aftet_Diagonal,'../������������Է���ͼƬ/�Ǳ�/���ܺ�Gͨ���Խ�������Ե�ͼ.png','png');
% 
% % figure;scatter(XX_B_DJX,YY_B_DJX,18,'filled');xlabel('Bͨ����������ػҶ�ֵ');ylabel('��õ����ڶԽ��߷������ػҶ�ֵ');title('����ͼ��Bͨ���Խ�������Ԫ������Ե�ͼ');axis([0 255,0 255]);set(gca,'XTick',0:15:255);set(gca,'YTick',0:15:255);
% R=figure('color',[1 1 1]);
% scatter(XX_B_DJX,YY_B_DJX,18,'filled');
% xlabel('Gray value of random pixels in channel B');
% ylabel('Gray value of pixel in diagonal direction adjacent to the point');
% % title('����ͼ��Bͨ���Խ�������Ԫ������Ե�ͼ');
% axis([0 255,0 255]);
% set(gca,'XTick',0:15:255);
% set(gca,'YTick',0:15:255);
% frame = getframe(R);
% B_aftet_Diagonal=frame2im(frame);
% imwrite(B_aftet_Diagonal,'../������������Է���ͼƬ/lena/���ܺ�Bͨ���Խ�������Ե�ͼ.png','png');
% % imwrite(B_aftet_Diagonal,'../������������Է���ͼƬ/����/���ܺ�Bͨ���Խ�������Ե�ͼ.png','png');
% % imwrite(B_aftet_Diagonal,'../������������Է���ͼƬ/����/���ܺ�Bͨ���Խ�������Ե�ͼ.png','png');
% % imwrite(B_aftet_Diagonal,'../������������Է���ͼƬ/�ɻ�/���ܺ�Bͨ���Խ�������Ե�ͼ.png','png');
% % imwrite(B_aftet_Diagonal,'../������������Է���ͼƬ/4.1.05����/���ܺ�Bͨ���Խ�������Ե�ͼ.png','png');
% % imwrite(B_aftet_Diagonal,'../������������Է���ͼƬ/4.2.06С��/���ܺ�Bͨ���Խ�������Ե�ͼ.png','png');
% % imwrite(B_aftet_Diagonal,'../������������Է���ͼƬ/����/���ܺ�Bͨ���Խ�������Ե�ͼ.png','png');
% % imwrite(B_aftet_Diagonal,'../������������Է���ͼƬ/�Ǳ�/���ܺ�Bͨ���Խ�������Ե�ͼ.png','png');

%Rͨ��
Q_R=double(Q_R);
EX2_R=0;EY2_SP_R=0;DX2_R=0;DY2_SP_R=0;COVXY2_SP_R=0;    %ˮƽ
EY2_CZ_R=0;DY2_CZ_R=0;COVXY2_CZ_R=0;    %��ֱ
EY2_DJX_R=0;DY2_DJX_R=0;COVXY2_DJX_R=0;   %�Խ���
%Gͨ��
Q_G=double(Q_G);
EX2_G=0;EY2_SP_G=0;DX2_G=0;DY2_SP_G=0;COVXY2_SP_G=0;    %ˮƽ
EY2_CZ_G=0;DY2_CZ_G=0;COVXY2_CZ_G=0;    %��ֱ
EY2_DJX_G=0;DY2_DJX_G=0;COVXY2_DJX_G=0;   %�Խ���
%Bͨ��
Q_B=double(Q_B);
EX2_B=0;EY2_SP_B=0;DX2_B=0;DY2_SP_B=0;COVXY2_SP_B=0;    %ˮƽ
EY2_CZ_B=0;DY2_CZ_B=0;COVXY2_CZ_B=0;    %��ֱ
EY2_DJX_B=0;DY2_DJX_B=0;COVXY2_DJX_B=0;   %�Խ���
for i=1:NN
    %��һ�����ص��E��ˮƽ����ֱ���Խ���ʱ����ó��ĵ�һ�����ص��E��ͬ��ͳһ��EX2��ʾ
    EX2_R=EX2_R+Q_R(x1(i),y1(i));
    EX2_G=EX2_G+Q_G(x1(i),y1(i));
    EX2_B=EX2_B+Q_B(x1(i),y1(i));
    %�ڶ������ص��E��ˮƽ����ֱ���Խ��ߵ�E�ֱ��ӦEY2_SP��EY2_CZ��EY2_DJX
    %Rͨ��
    EY2_SP_R=EY2_SP_R+Q_R(x1(i),y1(i)+1);
    EY2_CZ_R=EY2_CZ_R+Q_R(x1(i)+1,y1(i));
    EY2_DJX_R=EY2_DJX_R+Q_R(x1(i)+1,y1(i)+1);
    %Gͨ��
    EY2_SP_G=EY2_SP_G+Q_G(x1(i),y1(i)+1);
    EY2_CZ_G=EY2_CZ_G+Q_G(x1(i)+1,y1(i));
    EY2_DJX_G=EY2_DJX_G+Q_G(x1(i)+1,y1(i)+1);
    %Bͨ��
    EY2_SP_B=EY2_SP_B+Q_B(x1(i),y1(i)+1);
    EY2_CZ_B=EY2_CZ_B+Q_B(x1(i)+1,y1(i));
    EY2_DJX_B=EY2_DJX_B+Q_B(x1(i)+1,y1(i)+1);
end
%ͳһ��ѭ����������ص����1000���ɼ����������
%Rͨ��
EX2_R=EX2_R/NN;
EY2_SP_R=EY2_SP_R/NN;
EY2_CZ_R=EY2_CZ_R/NN;
EY2_DJX_R=EY2_DJX_R/NN;
%Gͨ��
EX2_G=EX2_G/NN;
EY2_SP_G=EY2_SP_G/NN;
EY2_CZ_G=EY2_CZ_G/NN;
EY2_DJX_G=EY2_DJX_G/NN;
%Bͨ��
EX2_B=EX2_B/NN;
EY2_SP_B=EY2_SP_B/NN;
EY2_CZ_B=EY2_CZ_B/NN;
EY2_DJX_B=EY2_DJX_B/NN;

for i=1:NN
    %��һ�����ص��D��ˮƽ����ֱ���Խ���ʱ����ó���һ�����ص��D��ͬ��ͳһ��DX2��ʾ
    DX2_R=DX2_R+(Q_R(x1(i),y1(i))-EX2_R)^2;
    DX2_G=DX2_G+(Q_G(x1(i),y1(i))-EX2_G)^2;
    DX2_B=DX2_B+(Q_B(x1(i),y1(i))-EX2_B)^2;
    %�ڶ������ص��D��ˮƽ����ֱ���Խ��ߵ�D�ֱ��ӦDY2_SP��DY2_CZ��DY2_DJX
    %Rͨ��
    DY2_SP_R=DY2_SP_R+(Q_R(x1(i),y1(i)+1)-EY2_SP_R)^2;
    DY2_CZ_R=DY2_CZ_R+(Q_R(x1(i)+1,y1(i))-EY2_CZ_R)^2;
    DY2_DJX_R=DY2_DJX_R+(Q_R(x1(i)+1,y1(i)+1)-EY2_DJX_R)^2;
    %Gͨ��
    DY2_SP_G=DY2_SP_G+(Q_G(x1(i),y1(i)+1)-EY2_SP_G)^2;
    DY2_CZ_G=DY2_CZ_G+(Q_G(x1(i)+1,y1(i))-EY2_CZ_G)^2;
    DY2_DJX_G=DY2_DJX_G+(Q_G(x1(i)+1,y1(i)+1)-EY2_DJX_G)^2;
    %Bͨ��
    DY2_SP_B=DY2_SP_B+(Q_B(x1(i),y1(i)+1)-EY2_SP_B)^2;
    DY2_CZ_B=DY2_CZ_B+(Q_B(x1(i)+1,y1(i))-EY2_CZ_B)^2;
    DY2_DJX_B=DY2_DJX_B+(Q_B(x1(i)+1,y1(i)+1)-EY2_DJX_B)^2;
    %�����������ص���غ����ļ��㣬ˮƽ����ֱ���Խ���
    %Rͨ��
    COVXY2_SP_R=COVXY2_SP_R+(Q_R(x1(i),y1(i))-EX2_R)*(Q_R(x1(i),y1(i)+1)-EY2_SP_R);
    COVXY2_CZ_R=COVXY2_CZ_R+(Q_R(x1(i),y1(i))-EX2_R)*(Q_R(x1(i)+1,y1(i))-EY2_CZ_R);
    COVXY2_DJX_R=COVXY2_DJX_R+(Q_R(x1(i),y1(i))-EX2_R)*(Q_R(x1(i)+1,y1(i)+1)-EY2_DJX_R);
    %Gͨ��
    COVXY2_SP_G=COVXY2_SP_G+(Q_G(x1(i),y1(i))-EX2_G)*(Q_G(x1(i),y1(i)+1)-EY2_SP_G);
    COVXY2_CZ_G=COVXY2_CZ_G+(Q_G(x1(i),y1(i))-EX2_G)*(Q_G(x1(i)+1,y1(i))-EY2_CZ_G);
    COVXY2_DJX_G=COVXY2_DJX_G+(Q_G(x1(i),y1(i))-EX2_G)*(Q_G(x1(i)+1,y1(i)+1)-EY2_DJX_G);
    %Bͨ��
    COVXY2_SP_B=COVXY2_SP_B+(Q_B(x1(i),y1(i))-EX2_B)*(Q_B(x1(i),y1(i)+1)-EY2_SP_B);
    COVXY2_CZ_B=COVXY2_CZ_B+(Q_B(x1(i),y1(i))-EX2_B)*(Q_B(x1(i)+1,y1(i))-EY2_CZ_B);
    COVXY2_DJX_B=COVXY2_DJX_B+(Q_B(x1(i),y1(i))-EX2_B)*(Q_B(x1(i)+1,y1(i)+1)-EY2_DJX_B);
end
%ͳһ��ѭ����������ص����1000���ɼ����������
%Rͨ��
DX2_R=DX2_R/NN;
DY2_SP_R=DY2_SP_R/NN;
DY2_CZ_R=DY2_CZ_R/NN;
DY2_DJX_R=DY2_DJX_R/NN;
COVXY2_SP_R=COVXY2_SP_R/NN;
COVXY2_CZ_R=COVXY2_CZ_R/NN;
COVXY2_DJX_R=COVXY2_DJX_R/NN;
%Gͨ��
DX2_G=DX2_G/NN;
DY2_SP_G=DY2_SP_G/NN;
DY2_CZ_G=DY2_CZ_G/NN;
DY2_DJX_G=DY2_DJX_G/NN;
COVXY2_SP_G=COVXY2_SP_G/NN;
COVXY2_CZ_G=COVXY2_CZ_G/NN;
COVXY2_DJX_G=COVXY2_DJX_G/NN;
%Bͨ��
DX2_B=DX2_B/NN;
DY2_SP_B=DY2_SP_B/NN;
DY2_CZ_B=DY2_CZ_B/NN;
DY2_DJX_B=DY2_DJX_B/NN;
COVXY2_SP_B=COVXY2_SP_B/NN;
COVXY2_CZ_B=COVXY2_CZ_B/NN;
COVXY2_DJX_B=COVXY2_DJX_B/NN;
%ˮƽ����ֱ���Խ��ߵ������
%Rͨ��
RXY2_SP_R=COVXY2_SP_R/sqrt(DX2_R*DY2_SP_R);
RXY2_CZ_R=COVXY2_CZ_R/sqrt(DX2_R*DY2_CZ_R);
RXY2_DJX_R=COVXY2_DJX_R/sqrt(DX2_R*DY2_DJX_R);
%Gͨ��
RXY2_SP_G=COVXY2_SP_G/sqrt(DX2_G*DY2_SP_G);
RXY2_CZ_G=COVXY2_CZ_G/sqrt(DX2_G*DY2_CZ_G);
RXY2_DJX_G=COVXY2_DJX_G/sqrt(DX2_G*DY2_DJX_G);
%Bͨ��
RXY2_SP_B=COVXY2_SP_B/sqrt(DX2_B*DY2_SP_B);
RXY2_CZ_B=COVXY2_CZ_B/sqrt(DX2_B*DY2_CZ_B);
RXY2_DJX_B=COVXY2_DJX_B/sqrt(DX2_B*DY2_DJX_B);

disp('Rͨ������ԣ�');
disp(['ԭʼͼƬRͨ������ԣ�','  ˮƽ�����=',num2str(RXY1_SP_R),'    ��ֱ�����=',num2str(RXY1_CZ_R),'  �Խ��������=',num2str(RXY1_DJX_R)]);
disp(['����ͼƬRͨ������ԣ�','  ˮƽ�����=',num2str(RXY2_SP_R),'  ��ֱ�����=',num2str(RXY2_CZ_R),'  �Խ��������=',num2str(RXY2_DJX_R)]);
disp('Gͨ������ԣ�');
disp(['ԭʼͼƬGͨ������ԣ�','  ˮƽ�����=',num2str(RXY1_SP_G),'   ��ֱ�����=',num2str(RXY1_CZ_G),'  �Խ��������=',num2str(RXY1_DJX_G)]);
disp(['����ͼƬGͨ������ԣ�','  ˮƽ�����=',num2str(RXY2_SP_G),' ��ֱ�����=',num2str(RXY2_CZ_G),'  �Խ��������=',num2str(RXY2_DJX_G)]);
disp('Bͨ������ԣ�');
disp(['ԭʼͼƬBͨ������ԣ�','  ˮƽ�����=',num2str(RXY1_SP_B),'   ��ֱ�����=',num2str(RXY1_CZ_B),'  �Խ��������=',num2str(RXY1_DJX_B)]);
disp(['����ͼƬBͨ������ԣ�','  ˮƽ�����=',num2str(RXY2_SP_B),'  ��ֱ�����=',num2str(RXY2_CZ_B),'  �Խ��������=',num2str(RXY2_DJX_B)]);