function cp=local_str_tensor(matrix)
STimage=str_tensor_map(matrix);
[row,column]=size(matrix);
cp=zeros(row,column);
window_wide=3;
spread=(window_wide-1)/2;
matrix_en=abs(padarray(STimage,[spread spread],'symmetric'));   

for i=1:row
    for j=1:column
        window=abs(matrix_en(i:1:(i+2*spread),j:1:(j+2*spread)));
        cp(i,j)=sum(window(:));
    end
end

