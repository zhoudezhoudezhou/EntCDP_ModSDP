function H=entropy_simp(x)

p=x/sum(x);
if p == 1
    H = 1;
else
    if sum(find(p==0))==0
        H=-sum(p.*log2(p));
    else
        p1=p;
        p1(find(p1==0))=[];
        H=-sum(p1.*log2(p1));
    end
end