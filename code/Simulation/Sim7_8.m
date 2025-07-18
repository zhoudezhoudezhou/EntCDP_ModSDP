clc;clear;
%----------------Simulation 7 and 8--------------------%
num = 5;
A = cell(1,num);
p = 0.85;p0 = 0.04;
A_arr = A;
n = 600;
%m = [300,350,400,450,500];%Sim7
m = [100,200,300,400,500];%Sim8
s = 0.85;
K = 6;
for r = 1:num
    A{r} = zeros(m(r),n);
    A_arr{r} = zeros(m(r),n);
    tem1 = 0;
    for I = 1:5
        S = fix((s-r*0.01*I)*m(r));                
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
        A{r}(:,tem1+1:tem1+K)=M;
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
tem4 = [];
tem5 =1 : 5;
for k = 1 : 5
    max_value = 1;
    max_geneset0 = EntCDP_matlab(A_arr,K,exclusion);
    m0=find(max_geneset0(:,K+1)==max(max_geneset0(:,K+1)));
    max_geneset = max_geneset0(m0,:);
    tem6=tem5(max_geneset(K)/K);
    if sum(max_geneset(K+2:K+2+num)<0.05)==num+1
        disp(['Order number of the identified module: ', num2str(tem6)])
    end
    tem4=[tem4;tem6];
    exclusion = [exclusion,(tem6-1)*K+1:tem6*K];
    tem5=setdiff(tem5,tem4);
end

