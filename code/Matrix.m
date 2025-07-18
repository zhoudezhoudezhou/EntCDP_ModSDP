function A=Matrix(M,gene_type)
[m,n]=size(M);gene=M(:,5:end);
% class(gene)
% size(gene)
% class(gene_type)
% size(gene_type)
% M(1)
% class(gene(1,:))
% gene(1,1:100)
A=zeros(m,size(gene_type,1));
for i=1:m
    for j=1:size(gene_type,1)
        flag=strfind(gene(i,:),gene_type{j});
        for k=1:n-4
            if isempty(gene{i,k})==1
                break;
            end
            if(isempty(flag{k}))==0 && length(gene{i,k})==length(gene_type{j})                                                     
                A(i,j)=1;                                    
                break
            end
        end
    end
end 