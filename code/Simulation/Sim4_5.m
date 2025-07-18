clc;clear;
%----------------Simulation 4 and 5--------------------%
num = 3;
A = cell(1,num);
p = 0.85;p0 = 0.04;
A_arr = A;
n = 800;
m = [500,550,600];%Sim4
%m = [300,500,800];%Sim5
s = [0.75,0.7,0.8];
for r = 1:num
    A{r} = zeros(m(r),n);
    A_arr{r} = zeros(m(r),n);
    S = fix(s(r)*m(r));
    tem1 = 0;
    for I = 1:9        
        K = I+1;        
        tem2 = zeros(K,1);
        M = zeros(m(r),K);
        M_arr = M;
        for i = 1:S
            j = randperm(K,1);
            tem = rand(1);
            if tem < p 
                M(i,j)=1;
                tem2(j)=tem2(j)+1;                
                K2=setdiff(1:K,j);
                for j = K2
                    tem=rand(1);
                    if tem < p0
                        M(i,j)=1;
                    end
                end
            end
        end
        
        % 
        tem3 = 0;
        for k = 1 : K
            M_arr(tem3+1:tem3+tem2(k),k)=1;            
            K2=setdiff(1:K,k);
            for i = 1 : tem2(k)
                for j = K2
                    tem = rand(1);
                    if tem < p0
                        M(tem3+i,j) = 1;
                    end
                end
            end
            tem3 = tem3 + tem2(k);
        end
        A{r}(:,tem1+1:tem1+K)=M;
        A_arr{r}(:,tem1+1:tem1+K) = M_arr;
        tem1 = tem1+K;
    end
    for j = tem1 + 1 :n
        s_num = randperm(4,1)-1;
        s_backgroud = randperm(m(r),s_num);
        A{r}(s_backgroud,j) = 1;
        A_arr{r}(s_backgroud,j) = 1;
    end
        
end
%%
exclusion = [];
tem4 = 0;
for k = 2 : 10
    max_value = 1;
    max_geneset0 = EntCDP_matlab(A_arr,k,exclusion);
    m0=find(max_geneset0(:,k+1)==max(max_geneset0(:,k+1)));
    max_geneset = max_geneset0(m0,:);

    if sum(max_geneset(k+2:k+2+num)<0.05)==num+1
        disp(['Identified module (k = ',num2str(k),'): ' num2str(max_geneset(1:k))])
    end
    exclusion = 1:tem4+k;
    tem4 = tem4 + k;
end

