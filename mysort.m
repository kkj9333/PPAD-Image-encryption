function retlist = mysort(sortlist,indexlist)
%按序列sort P(i,:)=sort(P(i,:),Ma(i,:));
%   先扩展为带序号矩阵然后再进行排序
L=length(sortlist);%sortlist必须和indexlist一样长
indexmat=zeros(L,2);
retlist=zeros(1,L);
for i=1:L
    indexmat(i,1)=indexlist(i);
    indexmat(i,2)=i;
end
indexmat=sortrows(indexmat);
for i=1:L
    retlist(i)=sortlist(indexmat(i,2));
end
    %retlist=circshift(retlist,h,2); %把置乱后的这一列进行向下移位
end

