function f=importcell_right(c)
f=[];
if size(c,1)==1
for k=1:length(c)
    if isempty(c{k})==1
        f{k}=c{k};
        continue
    end
    if length(class(c{k}{1}(1)))==4
        f{k}=c{k};
        continue
    end
    if (isempty(c{k})==0) && (length(class(c{k}{1}))==6)
        for i=1:size(c{k},1)
            for j=1:size(c{k},2)
                if sum(class(c{k}{i,j}(1))=='double')==6
                    f{k}{i,j}=c{k}{i,j}(1);
                else
                    f{k}{i,j}=c{k}{i,j}{1};
                end
            end            
        end
    else
        f{k}=c{k};   
    end
end
else
    if length(class(c{1}(1)))~=4
    for i=1:size(c,1)
        for j=1:size(c,2)
            if sum(class(c{i,j}(1))=='double')==6
                f{i,j}=c{i,j}(1);
            else
                f{i,j}=c{i,j}{1};
            end
        end
    end
    else
        f=c;
    end

end
