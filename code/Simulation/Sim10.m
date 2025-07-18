clc;clear;
%----------------Simulation 10--------------------%
num_A = 1;
A = cell(1,num_A);
p = 0.85;p0 = 0.04;
A_arr = A;
n = 800;
m = 500;
s_A_single = [0.7,0.6];%[0.75,0.6];[0.8,0.6];
s_A_double = [0,0.1];%0.1:0.02:0.3
K=5;
for r = 1:num_A
    A{r} = zeros(m(r),n);
    A_arr{r} = zeros(m(r),n);
    tem1 = 0;
    for I = 1:2
        S = fix(s_A_single(I)*m(r));
        S_double = S + fix(s_A_double*m(r));
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
        if s_A_double(I)>0
            for i = S+1:S_double
                j = randperm(K,2);
                tem = rand(1);
                if tem < p 
                    M(i,j)=1;
                    M_arr(i,j)=1;
                    tem2(j)=tem2(j)+1;                
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

%%%% B
num_B = 3;
B = cell(1,num_B);
p = 0.8;
B_arr = B;
n = 800;
m = [500,500,500];
s_B_double = 0.6;
K=5;
for t = 1:num_B
    B{t} = zeros(m(t),n);
    B_arr{t} = zeros(m(t),n);
    tem1 = 0;
    S_double = fix(s_B_double*m(t));
    for I = 1:2
        %S = fix(s_B_single(I)*m(r));        
        tem2 = zeros(K,1);
        M = zeros(m(t),K);
        M_arr = M;

        for i = 1:S_double
            j = randperm(K,2);
            tem = rand(1);
            if tem < p 
                M(i,j)=1;
                M_arr(i,j)=1;
                tem2(j)=tem2(j)+1;                
            end
        end
        B{t}(:,tem1+1:tem1+K)=M;
        B_arr{t}(:,tem1+1:tem1+K) = M_arr;
        tem1 = tem1+K;
    end
    for j = tem1 + 1 :n
        s_num = randperm(4,1)-1;
        s_backgroud = randperm(m(t),s_num);
        B{t}(s_backgroud,j) = 1;
        B_arr{t}(s_backgroud,j) = 1;
    end     
end
%%
exclusion = [];
max_geneset = ModSDP_matlab(A_arr,B_arr,k,exclusion);
 
if  sum(max_geneset(k+2:k+1+num_A)<0.05)==num_A && sum(max_geneset(k+2+num_A:k+1+num_A+num_B)>0.05)==num_B && sum(max_geneset(k+2+num_A+num_B)<0.05)==1
    disp(['Identified module of ModSDP: ', num2str(max_geneset(1:k))])
end




