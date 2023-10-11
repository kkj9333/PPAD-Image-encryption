function x = logistic_CML(e,u,x0,L)
%LOGISTIC_CML 此处显示有关此函数的摘要
%输入参数 混沌系数e,u,初始序列x0,序列长L,序列数num=xo长度
%   此处显示详细说明
num=length(x0);
x=zeros(num,L);%
x(1,1)=(1-e)*(u*x0(1)*(1-x0(1)))+(e/2)*(u*x0(num)*(1-x0(num))+u*x0(2)*(1-x0(2)));
for i=2:num-1
    x(i,1)=(1-e)*(u*x0(i)*(1-x0(i)))+(e/2)*(u*x0(i-1)*(1-x0(i-1))+u*x0(i+1)*(1-x0(i+1)));
end
x(num,1)=(1-e)*(u*x0(num)*(1-x0(num)))+(e/2)*(u*x0(num-1)*(1-x0(num-1))+u*x0(1)*(1-x0(1)));

% logistic_CML

for n=1:L-1
    
     x(1,n+1)=(1-e)*(u*x(1,n)*(1-x(1,n)))+(e/2)*(u*x(num,n)*(1-x(num,n))+u*x(2,n)*(1-x(2,n))); 
     for i=2:num-1
%    x(n+1,i)=(1-e)*f(x(n,i))+(1-u)*(e/2)*(f(x(n,i+1))+f(x(n,L)))+u*e/2*(f(n,j)+f(n,k)); 
          x(i,n+1)=(1-e)*(u*x(i,n)*(1-x(i,n)))+(e/2)*(u*x(i-1,n)*(1-x(i-1,n))+u*x(i+1,n)*(1-x(i+1,n))); 
     end
     x(num,n+1)=(1-e)*(u*x(num,n)*(1-x(num,n)))+(e/2)*(u*x(1,n)*(1-x(1,n))+u*x(num-1,n)*(1-x(num-1,n)));%混沌序列
end
end

