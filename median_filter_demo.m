% median_filter_demo.m

clear all
% csi_trace1 = read_bf_file('E:\��������\LABdata\4-25\AAA_onebody_stay.dat');
% csi_trace1 = read_bf_file('E:\��������\LABdata\4-25\AAA_onebody_move.dat');
csi_trace1 = read_bf_file('E:\��������\LABdata\4-25\AAA_nobdy.dat') ;
% L = length(csi_trace1) ;
L =600 
B = 1 ; % ������ʼ��
for n = B : L
    csi_entry1{n} = csi_trace1{n} ;
    scale1{n} = get_scaled_csi(csi_entry1{n}) ;
    
    %% ��amp���й�һ������
    amp1(n,1:30) = abs(scale1{n}(1,1,1:30)) ;
%     amp_max = max(amp1(n,:));
%     amp_min = min(amp1(n,:));
%     amp_normalize1(n, : ) = (amp1(n,:)-amp_min)/(amp_max-amp_min);
end

amp  = median_filter(amp1(:, 1:30) , 30) ; 

