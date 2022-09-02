clc;clear all

c1 = 1.49445; %参数设置
c2 = 1.49445;
w = 1;

maxgen = 200; %最大运行代数
sizepop = 50; %种群大小
nVar = 2;  %变量数  几个输入量或未知量
Vmax = 10; %速度变量范围  ，速度不能太大，不然精度缺失
Vmin = -10;
popmax = 100; %位置搜索范围
popmin = -100;

for i = 1:sizepop
   pop(i,:) = (popmax - popmin) * rands(1,nVar) + popmin; %公式  生成最大最小 随机数+...
   V(i,:) = (Vmax - Vmin) * rands(1,nVar) + Vmin;
   fitness(i) = func(pop(i,:)); %初始种群适应度
end

[bestfitness,bestindex] = max(fitness);
gbest = pop(bestindex,:); %全局
pbest = pop;
fitnesspbest = fitness;
fitnessgbest = bestfitness;

for i = 1 : maxgen
    for j = 1 : sizepop
       V(j,:) = w.*V(j,:) + c1 * rand * (pbest(j,:)) + c2 * rand * (gbest - pop(j,:)); %更新个体速度
       V(j,find(V(j,:) > Vmax)) = Vmax; %判断速度
       V(j,find(V(j,:) < Vmin)) = Vmin;
       
       pop(j,:) = pop(j,:) + V(j,:); %当前值加速度
       pop(j,find(pop(j,:) > popmax)) = popmax;  %判断位置
       pop(j,find(pop(j,:) < popmin)) = popmin;
       
       fitness(j) = func(pop(j,:));
    end
    
    for j = 1 : sizepop
        if fitness(j) < fitnesspbest(j)
            pbest(j,:) = pop(j,:);
            fitnesspbest(j) = fitness(j);
        end
        
        if fitness(j) < fitnessgbest
            gbest = pop(j,:);
            finessgbest = fitness(j);
        end
    end
  yy(i) = fitnessgbest;
end

plot(yy)
title('最优个体适应度','fontsize',12);
xlabel('进化代数','fontsize',12);
ylabel('适应度','fontsize',12);

disp('函数值            变量');
disp([fitnessgbest,gbest]);