function retlist = antimysort(sortlist,indexlist)
%按序列antisort P(i,:)=sort(P(i,:),Ma(i,:));
%   先扩展为带序号矩阵然后xx
%ret shuold be 
L=length(sortlist);%sortlist必须和indexlist一样长
indexmat=zeros(L,2);
retlist=zeros(1,L);
for i=1:L
    indexmat(i,1)=indexlist(i);
    indexmat(i,2)=i;
end
indexmat=sortrows(indexmat);
%sortlist=circshift(sortlist,-h,2);  %向左移位
for i=1:L
    retlist(indexmat(i,2))=sortlist(i);
end
end

