function roundkeyarrays = roundkeygenerate(initialkey,R)
%ROUNDKEYGENERTE 输入初始密钥（240 bit长，有30个) 总轮数 输出轮密钥数组 R+1 *240bit
%   此处显示详细说明
roundkeyarrays=zeros([R+1,30]);
for i=1:30
    roundkeyarrays(1,i)=initialkey(i);
end
for r=2:R+1
    for x=1:5
        roundkeyarrays(r,x)=bitxor(roundkeyarrays(r-1,x),hx([roundkeyarrays(r-1,26),roundkeyarrays(r-1,27),...
            roundkeyarrays(r-1,28),roundkeyarrays(r-1,29),roundkeyarrays(r-1,30)],r));
    end
    for x=6:30
        roundkeyarrays(r,x)=bitxor(roundkeyarrays(r-1,x),roundkeyarrays(r-1,x-5));
    end
end

end

