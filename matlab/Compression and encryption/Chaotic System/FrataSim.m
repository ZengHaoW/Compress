%%�Ӻ������������׳�����Chenϵͳ
%����Adomian�ֽⷽ���������
%ʱ�䣺2020.5.15
%���ߣ����
function [t,y]=FrataSim(h,NN,z0,q)
y=zeros(4,NN);
t=zeros(1,NN);
tt=0;
for i=1:NN
    t(i)=tt;
    dy=SimpleFratral(z0,h,q);
    y(:,i)=dy;
    z0=dy;
    tt=tt+h;
end