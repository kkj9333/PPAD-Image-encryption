function C = Algorithm(P,Ma,Mb)
%ALGORITHM1 输入 明文图像P(rxcxse)矩阵； 
%输出中间加密图像T(rxc)
%   此处显示详细说明    
%如果MaMbVaVb没有进行过初始化 先进行整数化
% S=
%P=[1,2,3,4,5;6,7,8,9,10;11,12,13,14,15;16,17,18,19,20;];%4*5
%Ma=[0x16,0x33,0x53,0x7A,0x99,0xAB,0xC4,0xD2,0x61,0x4F,...
%     0x06,0x23,0x63,0x4A,0x89,0x6B,0x34,0x97,0x15,0x9D];
%Mb=[0x76,0x23,0xB3,0x8A,0x19,0x1B,0x04,0x52,0x61,0x42,...
 %   0x16,0x3C,0x53,0x7B,0x99,0xAB,0xC4,0xD2,0x61,0x4F];
%Va=[0xAC,0xBB,0x06,0xF4];
%Vb=[0xBD,0xCE,0x6F,0x26];
%Ma=double(Ma)./1000000;Mb=double(Mb)./1000000;Va=double(Va)./1000000;Vb=double(Vb)./1000000;

[r,c,se]=size(P);
T=zeros(r,c,se);
P1=zeros(r,c,se);
P2=zeros(r,c,se);
C=zeros(r,c,se);
%h(i) rx1
h=Ma(:,1);
hh2=Ma(:,2);
%g(j) 1xc
g=Mb(1,:);
gg2=Mb(2,:);
P2=P;
for sei=1:se
    P2(:,:,sei)=permute_parallel(P(:,:,sei),hh2,gg2');
end
P=P2;
%开始并列操作 这里暂时先用for代替
for i =1:r
    for sei=1:se
    %P(i,:,sei)=mysort(P(i,:,sei),Ma(i,:));
    P(i,:,sei)=circshift(P(i,:,sei),h(i),2); %进行向you移位
    %行前向扩散
    P1(i,1,sei)=mod(double(P(i,1,sei))+Ma(i,1),256);
    for t=2:c
        P1(i,t,sei)=mod(double(P(i,t,sei))+P1(i,t-1,sei)+Ma(i,t),256);
    end
    P1(i,:,sei)=fliplr(P1(i,:,sei));
    T(i,1,sei)=mod(P1(i,1,sei)+Mb(i,1),256);
    for t=2:c
        T(i,t,sei)=mod(P1(i,t,sei)+T(i,t-1,sei)+Mb(i,t),256);
    end
    T(i,:,sei)=fliplr(T(i,:,sei));
    end
end
P=T;
%开始并列操作 这里暂时先用for代替
for j =1:c
    
    for sei=1:se
    %P(:,j,sei)=transpose(mysort(P(:,j,sei),Mb(:,j)));
    P(:,j,sei)=circshift(P(:,j,sei),g(j)); %把置乱后的这一列进行向下移位
    %列前向扩散
    P2(1,j,sei)=mod(double(P(1,j,sei))+Mb(1,j),256);
    for t=2:r
        P2(t,j,sei)=mod(double(P(t,j,sei))+P2(t-1,j,sei)+Mb(t,j),256);
    end
    P2(:,j,sei)=fliplr(P2(:,j,sei));
    C(1,j,sei)=mod(P2(1,j,sei)+Ma(1,j),256);
    for t=2:r
        C(t,j,sei)=mod(P2(t,j,sei)+C(t-1,j,sei)+Ma(t,j),256);
    end
    C(:,j,sei)=fliplr(C(:,j,sei));
    end
end


end



