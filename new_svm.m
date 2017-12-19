close all
clc
clear all
%% 
% F1  = load ('temp_M6.txt');
% F2  = load ('temp_test_nobody.txt');
% 
F1  = load ('AAA_onebody_move_w20.txt');
F2  = load ('AAA_nobdy_w20.txt');
F = [F1;F2];
amp1 = F1(:,1:2)';
ph1 = F1(:,3:4)';

amp2 = F2(:,1:2)';
ph2 = F2(:,3:4)';
%% 
% ------------------------------------------------------------ %
% 定义核函数及相关参数
nu = 1;            % nu -> (0,1] 在支持向量数与错分样本数之间进行折衷
ker = struct('type','linear');
% -------------- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - %
% 构造两类训练样本
n = 116;
% randn('state',6);
x1(1,:) = amp1(1,1:n);
x1(2,:) = ph1(1,1:n);
y1 = ones(1,n);

x2(1,:) = amp2(1,1:n);
x2(2,:) = ph2(1,1:n);
y2 = -ones(1,n);
% plot()
  figure;
  plot(x1(1,:),x1(2,:),'b*',x2(1,:),x2(2,:),'g.');
%  axis([-1 8 -3 8]);
%   title('C-SVC')
 hold on;

X = [x1,x2];        % 训练样本,d×n的矩阵,n为样本个数,d为样本维数
Y = [y1,y2];        % 训练目标,1×n的矩阵,n为样本个数,值为+1或-1

% ------------------------------------------------------------%
% 训练支持向量机

tic
svm = svmTrain('svc_c',X,Y,ker,nu);
t_train = toc

% svm  支持向量机(结构体变量)
% the following fields:
%   type - 支持向量机类型  {'svc_c','svc_nu','svm_one_class','svr_epsilon','svr_nu'}
%   ker - 核参数
%   x - 训练样本,d×n的矩阵,n为样本个数,d为样本维数
%   y - 训练目标,1×n的矩阵,n为样本个数,值为+1或-1
%   a - 拉格朗日乘子,1×n的矩阵

% ------------------------------------------------------------ %
% 寻找支持向量
 
a = svm.a;
epsilon =1e-5;                     % 如果小于此值则认为是0
i_sv = find(abs(a)>epsilon);        % 支持向量下标
plot(X(1,i_sv),X(2,i_sv),'ro');
% plot(X(1,:),X(2,:),'ro');
  legend('Static','Dynamic','Support Vector')

% ------------------------------------------------------------ %
% 测试输出

[x1,x2] = meshgrid(-.01:0.1:0.5,-.01:0.1:0.5);
[rows,cols] = size(x1);
nt = rows*cols;                  % 测试样本数
Xt = [reshape(x1,1,nt);reshape(x2,1,nt)]  ;

tic
Yd = svmSim(svm,Xt);           % 测试输出
t_sim = toc

% Yd = reshape(Yd,rows,cols);
% contour(x1,x2,Yd,[0 0]);       % 分类面
% hold off;
% axis([-2 5 -2 5])