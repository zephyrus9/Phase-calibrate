% SVD降噪
clc
clear
% close all
% csi_trace1 = read_bf_file('E:\数据资料\LABdata\A206\AP1_A206_M6.dat');
% csi_trace1 = read_bf_file('E:\数据资料\LABdata\4-25\AAA_nobdy.dat');
csi_trace1 = read_bf_file('E:\数据资料\LABdata\4-25\AAA_onebody_move.dat');
% csi_trace1 = read_bf_file('E:\数据资料\LABdata\4-25\AAA_onebody_stay.dat');

% csi_trace1 = read_bf_file('E:\数据资料\LABdata\A204-6-19\5G_3.dat');
% K = length(csi_trace1) 
K = 300
% 第一根天线
for n = 1 : K
    csi_entry1{n} = csi_trace1{n};
    scale{n} = get_scaled_csi(csi_entry1{n});  % 取出前K个3*3*30的数据包给scale1
end
for m = 1: K
    amp1(m,1:30) = abs(scale{m}(1,1,1:30)) ;
    %% 对amp进行归一化部分
    amp_max = max(amp1(m,:));
    amp_min = min(amp1(m,:));
    amp_normalize1(m,1:30) = (amp1(m,:)-amp_min)/(amp_max-amp_min);
end
fig = figure;
 y = amp1(:, 1 : 30) ; 
%   y = amp_normalize1(:, 1:30) ; 

 subplot(121)

 plot(amp1(:, 15), 'b')

% SVD降噪
m = 8;
for i = 1 : 30
    x_de1(: , i) = SVD_Denoise_Mean(y(:, i), m);
%     x_de2 = SVD_Denoise_Median(y(:, i), m);
%     x_de3 = SVD_Denoise_Manual(y(:, i), m);
end

% ---------------Hampel filter---------------%
DX = 1; % Window Half size
T = 3;  % Threshold
Threshold   = 0.1;  % AdaptiveThreshold
X = 1 : DX : K ; % Pseudo Time
for i = 1 : size(amp1,2)
    [YY(:,i),I,Y0_nobody(:,i),LB(:,i),UB(:,i)] = hampel(X,amp1(:,i),DX,T,'Adaptive',Threshold);
end


figure(fig),
% hold on
subplot(122)

plot(x_de1(:, 1), 'r')
% figure
% plot(y, 'b'), hold on 
% plot(x_de1, 'r', 'linewidth', 1.2)
% % plot(x_de2, 'r')
% % plot(x_de3, 'c')
% legend({'原始信号', 'SVD\_Denoise\_Mean'})
% legend({'原始信号', 'SVD\_Denoise\_Mean', 'SVD\_Denoise\_Median', 'SVD\_Denoise\_Manual'})