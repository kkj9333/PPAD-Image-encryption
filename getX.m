function X = getX(initialkey,L)
%GETX 此处显示有关此函数的摘要 initialkey是一个数组 240bit L表示序列长
%  用于计算混沌映射的参数，并根据这些参数调用混沌映射函数
e=(initialkey(1)+initialkey(2)+initialkey(3)+initialkey(4)+initialkey(5))/(255*5);
u=3.99+0.01*(initialkey(6)+initialkey(7)+initialkey(8)+initialkey(9)+initialkey(10))/(255*5);
X0(1)=(initialkey(11)+initialkey(12)+initialkey(13)+initialkey(14)+initialkey(15))/(255*5);
X0(2)=(initialkey(16)+initialkey(17)+initialkey(18)+initialkey(19)+initialkey(20))/(255*5);
X0(3)=(initialkey(21)+initialkey(22)+initialkey(23)+initialkey(24)+initialkey(25))/(255*5);
X0(4)=(initialkey(26)+initialkey(27)+initialkey(28)+initialkey(29)+initialkey(30))/(255*5);
X=logistic_CML(e,u,X0,L);
end

