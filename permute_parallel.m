function  f_circ  = permute_parallel( f,p1,p2 )  %f为图像矩阵 r*c p1 rx1 p2 cx1

[f,~]=sortrows([p2 f'],1);  %经过sortrows后，第一列P1已经是有序的了，即原来P1已经不存在了
f(:,1)=[];
f=f';

[f,~]=sortrows([p1 f],1);
f(:,1)=[];      
f_circ=f;
end
