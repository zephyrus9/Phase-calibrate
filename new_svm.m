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
% ����˺�������ز���
nu = 1;            % nu -> (0,1] ��֧������������������֮���������
ker = struct('type','linear');
% -------------- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - %
% ��������ѵ������
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

X = [x1,x2];        % ѵ������,d��n�ľ���,nΪ��������,dΪ����ά��
Y = [y1,y2];        % ѵ��Ŀ��,1��n�ľ���,nΪ��������,ֵΪ+1��-1

% ------------------------------------------------------------%
% ѵ��֧��������

tic
svm = svmTrain('svc_c',X,Y,ker,nu);
t_train = toc

% svm  ֧��������(�ṹ�����)
% the following fields:
%   type - ֧������������  {'svc_c','svc_nu','svm_one_class','svr_epsilon','svr_nu'}
%   ker - �˲���
%   x - ѵ������,d��n�ľ���,nΪ��������,dΪ����ά��
%   y - ѵ��Ŀ��,1��n�ľ���,nΪ��������,ֵΪ+1��-1
%   a - �������ճ���,1��n�ľ���

% ------------------------------------------------------------ %
% Ѱ��֧������
 
a = svm.a;
epsilon =1e-5;                     % ���С�ڴ�ֵ����Ϊ��0
i_sv = find(abs(a)>epsilon);        % ֧�������±�
plot(X(1,i_sv),X(2,i_sv),'ro');
% plot(X(1,:),X(2,:),'ro');
  legend('Static','Dynamic','Support Vector')

% ------------------------------------------------------------ %
% �������

[x1,x2] = meshgrid(-.01:0.1:0.5,-.01:0.1:0.5);
[rows,cols] = size(x1);
nt = rows*cols;                  % ����������
Xt = [reshape(x1,1,nt);reshape(x2,1,nt)]  ;

tic
Yd = svmSim(svm,Xt);           % �������
t_sim = toc

% Yd = reshape(Yd,rows,cols);
% contour(x1,x2,Yd,[0 0]);       % ������
% hold off;
% axis([-2 5 -2 5])