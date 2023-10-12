function C = antiAlgorithm1(P,Ma,Mb)
%ALGORITHM1 输入 加密图像P(rxc)矩阵；序列Ma(rxc),Mb(rxc),Va(1xr),Vb(1xr) 
%输出明文图像T(rxc)
%如果MaMbVaVb没有进行过初始化 先进行整数化

[r,c,se]=size(P);
T=zeros(r,c,se);
P1=zeros(r,c,se);
C=zeros(r,c,se);
%h(i) rx1
h=Ma(:,1);
hh2=Ma(:,2);
%g(j) 1xc
g=Mb(1,:);
gg2=Mb(2,:);
%开始并列操作 这里暂时先用for代替
for j =c:-1:1
    for sei=1:se
	% 数组反转
    P(:,j,sei)=fliplr(P(:,j,sei));
    for t=r:-1:2
        %计算出 P1(2-r,j)
        P1(t,j,sei)=mod(P(t,j,sei)-P(t-1,j,sei)-Ma(t,j)+512,256);
    end
    P1(1,j,sei)=mod(P(1,j,sei)-Ma(1,j)+512,256);
    P1(:,j,sei)=fliplr(P1(:,j,sei));
    
    for t=r:-1:2
        T(t,j,sei)=mod(P1(t,j,sei)-P1(t-1,j,sei)-Mb(t,j)+512,256);
    end
    T(1,j,sei)=mod(P1(1,j,sei)-Mb(1,j)+512,256);
    T(:,j,sei)=circshift(T(:,j,sei),-g(j));  %向左移位
    %T(:,j,sei)=transpose(antimysort(T(:,j,sei),Mb(:,j)));
    %列前向扩散
    end
end
P=T;
%开始并行操作 这里暂时先用for代替
for i =r:-1:1
    for sei=1:se
    P(i,:,sei)=fliplr(P(i,:,sei));
    for t=c:-1:2
        P1(i,t,sei)=mod(P(i,t,sei)-P(i,t-1,sei)-Mb(i,t)+512,256);
    end
    P1(i,1,sei)=mod(P(i,1,sei)-Mb(i,1)+512,256);
    P1(i,:,sei)=fliplr(P1(i,:,sei));
    for t=c:-1:2
        T(i,t,sei)=mod(P1(i,t,sei)-P1(i,t-1,sei)-Ma(i,t)+512,256);
    end
    T(i,1,sei)=mod(P1(i,1,sei)-Ma(i,1)+512,256);
    
    T(i,:,sei)=circshift(T(i,:,sei),-h(i),2);  %向左移位
    %T(i,:,sei)=antimysort(T(i,:,sei),Ma(i,:));

    end

end

%逆置乱
for sei=1:se
    C(:,:,sei)=decry_permute_parallel(T(:,:,sei),hh2,gg2');
end


end

