function [B,gene_type]=MutationMatrix2(M)

N=length(M);
tep=1;all_gene{1}='abc';
for k=1:N
    [tep,all_gene]=allgene(M{k},tep,all_gene);
    %l=length(unique(all_gene))
end

gene_type=unique(all_gene);
gene_type=gene_type(:);

%xlswrite('.\gene_     .xlsx',gene_type);
for k=1:N
    B{k}=Matrix(M{k},gene_type);
end

