clc;clear all

c1 = 1.49445; %��������
c2 = 1.49445;
w = 1;

maxgen = 200; %������д���
sizepop = 50; %��Ⱥ��С
nVar = 2;  %������  ������������δ֪��
Vmax = 10; %�ٶȱ�����Χ  ���ٶȲ���̫�󣬲�Ȼ����ȱʧ
Vmin = -10;
popmax = 100; %λ��������Χ
popmin = -100;

for i = 1:sizepop
   pop(i,:) = (popmax - popmin) * rands(1,nVar) + popmin; %��ʽ  ���������С �����+...
   V(i,:) = (Vmax - Vmin) * rands(1,nVar) + Vmin;
   fitness(i) = func(pop(i,:)); %��ʼ��Ⱥ��Ӧ��
end

[bestfitness,bestindex] = max(fitness);
gbest = pop(bestindex,:); %ȫ��
pbest = pop;
fitnesspbest = fitness;
fitnessgbest = bestfitness;

for i = 1 : maxgen
    for j = 1 : sizepop
       V(j,:) = w.*V(j,:) + c1 * rand * (pbest(j,:)) + c2 * rand * (gbest - pop(j,:)); %���¸����ٶ�
       V(j,find(V(j,:) > Vmax)) = Vmax; %�ж��ٶ�
       V(j,find(V(j,:) < Vmin)) = Vmin;
       
       pop(j,:) = pop(j,:) + V(j,:); %��ǰֵ���ٶ�
       pop(j,find(pop(j,:) > popmax)) = popmax;  %�ж�λ��
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
title('���Ÿ�����Ӧ��','fontsize',12);
xlabel('��������','fontsize',12);
ylabel('��Ӧ��','fontsize',12);

disp('����ֵ            ����');
disp([fitnessgbest,gbest]);