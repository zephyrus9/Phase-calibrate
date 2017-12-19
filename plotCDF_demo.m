% plotCDF_demo
clc
clear all

meiren = 'data_nobody11.txt' ; 
youren = 'data_onebody11.txt';

csi_trace1 = read_bf_file('E:\数据资料\LABdata\4-25\AAA_nobdy.dat') ;
% csi_trace2 = read_bf_file('E:\数据资料\LABdata\4-25\AAA_onebody_stay.dat');
csi_trace2 = read_bf_file('E:\数据资料\LABdata\4-25\AAA_onebody_move.dat');

F1 = getFeatures(meiren, csi_trace1) ;
F2 = getFeatures(youren, csi_trace2) ;
F = [F1 ; F2] ; 

figure 
a = cdfplot(F(: , 7)) ;  hold on
set(a,'color', 'b', 'linewidth', 1.5)

% set(a, 'linestyle', '--','marker', 'o', 'color', 'r', 'linewidth', 1.5)
b = cdfplot(F(: , 8)) ;  hold on
set(b , 'color', 'r', 'linewidth', 1.5)

c = cdfplot(F(: , 9)) ; 
set(c , 'color', 'g', 'linewidth', 1.5)
figure 
a = cdfplot(F(: , 1)) ;  hold on
set(a,'color', 'b', 'linewidth', 1.5)

% set(a, 'linestyle', '--','marker', 'o', 'color', 'r', 'linewidth', 1.5)
b = cdfplot(F(: , 2)) ;  hold on
set(b , 'color', 'r', 'linewidth', 1.5)

c = cdfplot(F(: , 3)) ; 
set(c , 'color', 'g', 'linewidth', 1.5)

%%------------------------------------%%
figure 
a = cdfplot(F1(: , 8)) ;  hold on
set(a,'color', 'b', 'linewidth', 1.5)

% set(a, 'linestyle', '--','marker', 'o', 'color', 'r', 'linewidth', 1.5)
b = cdfplot(F2(: , 8)) ;  hold on
set(b , 'color', 'r', 'linewidth', 1.5)

c = cdfplot(F(: , 3)) ; 
set(c , 'color', 'g', 'linewidth', 1.5)
