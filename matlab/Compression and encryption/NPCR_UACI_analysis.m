%% ����ϵͳNPCR��Number of pixels change rate��&UACI��unifed average changing intensity������
%   @author:���
%   @date:2020.04.17
clc;
clear;
%��ȡ����ԭͼһ�����ص��ļ���ͼ

image1=imread('./testImage/peppers/peppers_suoluetu_E_change1P.tiff');             %��ȡͼ����Ϣ
% image1=imread('../ԭʼ�����ܡ�����ͼƬ/����/�ı�һ�����ؼ��ܺ��peppers.png','png');             %��ȡͼ����Ϣ
% image1=imread('../ԭʼ�����ܡ�����ͼƬ/����/�ı�һ�����ؼ��ܺ��baboon.png','png');             %��ȡͼ����Ϣ
% image1=imread('../ԭʼ�����ܡ�����ͼƬ/�ɻ�/�ı�һ�����ؼ��ܺ��airplane.png','png');             %��ȡͼ����Ϣ
% image1=imread('../ԭʼ�����ܡ�����ͼƬ/����/�ı�һ�����ؼ��ܺ��house.png','png');             %��ȡͼ����Ϣ
% image1=imread('../ԭʼ�����ܡ�����ͼƬ/4.2.06С��/�ı�һ�����ؼ��ܺ��4.2.06.png','png');             %��ȡͼ����Ϣ

I1=image1;
I2=image1;
I3=image1;
%��ȡû�и���ԭͼ�ļ���ͼ
image2=imread('./testImage/peppers/peppers_suoluetu_E.tiff');              %��ȡͼ����Ϣ
% image2=imread('../ԭʼ�����ܡ�����ͼƬ/����/���ܺ��peppers.png','png');              %��ȡͼ����Ϣ
% image2=imread('../ԭʼ�����ܡ�����ͼƬ/����/���ܺ��baboon.png','png');              %��ȡͼ����Ϣ
% image2=imread('../ԭʼ�����ܡ�����ͼƬ/�ɻ�/���ܺ��airplane.png','png');              %��ȡͼ����Ϣ
% image2=imread('../ԭʼ�����ܡ�����ͼƬ/����/���ܺ��house.png','png');              %��ȡͼ����Ϣ
% image2=imread('../ԭʼ�����ܡ�����ͼƬ/4.2.06С��/���ܺ��4.2.06.png','png');              %��ȡͼ����Ϣ

J1=image2;
J2=image2;
J3=image2;
%��ʾͼƬ
figure;imshow(image2),title('ԭͼ��');
figure;imshow(image1),title('�ı��ͼ��');
%������ͬλ�ûҶ�ֵ��ȵĸ���
[M,N]=size(I1);
m=0;
n=0;
p=0;
u1=0;
u2=0;
u3=0;
for i=1:M
    for j=1:N
        u1=u1+abs(double(I1(i,j))-double(J1(i,j)))/255;
        u2=u2+abs(double(I2(i,j))-double(J2(i,j)))/255;
        u3=u3+abs(double(I3(i,j))-double(J3(i,j)))/255;
        if I1(i,j)~=J1(i,j)
            m=m+1;
        end
        if I2(i,j)~=J2(i,j)
            n=n+1;
        end
        if I3(i,j)~=J3(i,j)
            p=p+1;
        end
    end
end
ua=sum(abs(double(I1(:))-double(J1(:)))/255);%�򵥵�ʽ�ӣ�һ���͸㶨
%����NPCR
NPCR1=(m*100)/(M*N);
NPCR2=(n*100)/(M*N);
NPCR3=(p*100)/(M*N);
NPCR=sum(double(I1(:))~=double(J1(:)))*100/(M*N);%�򵥵ķ���
UACI1=(u1*100)/(M*N);
UACI2=(u2*100)/(M*N);
UACI3=(u3*100)/(M*N);
UACI=(ua*100)/(M*N);
disp(['Rͨ����NPCRֵΪ��',num2str(NPCR1)]);
disp(['Gͨ����NPCRֵΪ��',num2str(NPCR2)]);
disp(['Bͨ����NPCRֵΪ��',num2str(NPCR3)]);
% disp(['NPCRֵΪ��',num2str(NPCR1)]);
disp(['Rͨ����UACIֵΪ��',num2str(UACI1)]);%����һ
disp(['Gͨ����UACIֵΪ��',num2str(UACI2)]);%����һ
disp(['Bͨ����UACIֵΪ��',num2str(UACI3)]);%����һ
% disp(['UACIֵΪ��',num2str(UACI1)]);%������