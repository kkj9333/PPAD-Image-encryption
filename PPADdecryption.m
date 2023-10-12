function P = PPADdecryption(C,initialkey,R)
%PPADdecryption 此处显示有关此函数的摘要

%Step1
useRoundkey=false;
initialkey=double(initialkey);
if(useRoundkey)
Roundkeyarray=roundkeygenerate(initialkey,R);
end
[r,c,se]=size(C);

%Step2 这里根据情况选择直接用初始密钥或者轮密钥
isjishu=mod(r*c,2);
X=getX(initialkey,r*c/2+isjishu);
Xarray=zeros(R,4,r*c/2+isjishu);
if(useRoundkey)
    %r=1初始密钥不使用
    for rr=2:R+1
        X=getX(Roundkeyarray(rr,:),r*c/2+isjishu);
        %X=getX(reshape(Roundkeyarray(rr,:),length(Roundkeyarray(rr,:))),r*c);
        Xarray(rr-1,:,:)=X;
    end
end

%reshape
Ma=reshape(floor(mod([X(1,1:r*c/2) X(2,1:r*c/2+isjishu)]*power(10,6),256)),[r,c]);
Mb=reshape(floor(mod([X(3,1:r*c/2) X(4,1:r*c/2+isjishu)]*power(10,6),256)),[r,c]);
%解密迭代R轮
P=double(C);%解密过程中必须先用双浮点数

for i=R:-1:1
    C=P;
    if useRoundkey
        
    X=reshape(Xarray(i,:,:),[sizeX,r*c/2+isjishu]);%这里直接使用4了
Ma=reshape(floor(mod([X(1,1:r*c/2) X(2,1:r*c/2+isjishu)]*power(10,6),256)),[r,c]);
Mb=reshape(floor(mod([X(3,1:r*c/2) X(4,1:r*c/2+isjishu)]*power(10,6),256)),[r,c]);
    end
    P=antiAlgorithm(C,Ma,Mb);
%figure(3);
%imshow(C,[]);
end
P=uint8(P);
end


