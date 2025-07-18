function [tep,all_gene]=allgene(M,tep,all_gene)

[m,n]=size(M);%gene=M(:,5:end);

for i=1:m
    for j=5:n
        if isempty(M{i,j})==0
            all_gene{tep}=M{i,j};
            tep=tep+1;
        else
            break;
        end  
    end
end
