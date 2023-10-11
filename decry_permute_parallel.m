function  decry_f_circ  = decry_permute_parallel( f_circ,p1,p2)  %fÎªÍ¼Ïñ¾ØÕó r*c p1 1xr p2 1xc
[m,n]=size(f_circ);
[~,num2]=sort(p1);    
[~,num1]=sort(p2); 
decry_f_circ1=zeros(size(f_circ));
decry_f_circ=zeros(size(f_circ));
for i=1:m
           decry_f_circ1(num2(i),:)  =f_circ(i,:);
end
  
for i=1:n
          decry_f_circ(:,num1(i))=decry_f_circ1(:,i);
end
end
