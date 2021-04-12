function [map]=STO(matrix)
v=1;
EA=XFra_Diff(matrix,v);
GA=YFra_Diff(matrix,v);
FA=EA.*GA;
EEA=EA.*EA;
GGA=GA.*GA;
e1=0.5*((EEA+GGA)+sqrt((EEA-GGA).^2+4*FA.*FA)); 
e2=0.5*((EEA+GGA)-sqrt((EEA-GGA).^2+4*FA.*FA)); 
map=sqrt((e1+e2).^2+0.5*((e1-e2).^2));

function cp=XFra_Diff(matrix,v);
[row,column]=size(matrix);
cp=zeros(row,column);
window_wide=5;
spread=(window_wide-1)/2;
matrix_en=padarray(matrix,[spread spread],'symmetric');
for i=1:row
    for j=1:column
        cp(i,j)=matrix_en(i+2,j+2)+(-v)*matrix_en(i+1,j+2)+0.5*(-v)*(-v+1)*matrix_en(i,j+2);
    end
end

function cp=YFra_Diff(matrix,v);
[row,column]=size(matrix);
cp=zeros(row,column);
window_wide=5;
spread=(window_wide-1)/2;
matrix_en=padarray(matrix,[spread spread],'symmetric');
for i=1:row
    for j=1:column
        cp(i,j)=matrix_en(i+2,j+2)+(-v)*matrix_en(i+2,j)+0.5*(-v)*(-v+1)*matrix_en(i+2,j);
    end
end
