% Author: Zihen Chen
% Date: 2024.06.28
% Email:ziheng_ch@163.com
% Dept. of Information Engineering and Computer Science
% University of Trento
% ​via Sommarive 9, 38123 Povo-Trento, Italy

addpath('./SPD_utilites/')
clear
clc
% Example usage remains the same:
% P = [1,0,0; 0, 1, 0; 0, 0, 1]; % An example SPD matrix
% % Q = [4, 1, 0; 1, 4, 1; 0, 1, 3]; % Another example SPD matrix
% P = P*1.75;
U1= [0.3280,    0.7370,   -0.5910;
   -0.5910,   -0.3280,   -0.7370;
    0.7370,   -0.5910,   -0.3280];

U2 = [0.79592566,  0.57671269, -0.18413259;
     -0.10042245, -0.17416679, -0.97958219;
      0.59700726, -0.79816565,  0.08070892];

eigs1 = diag([0.1,1,60]);
eigs2 = diag([0.1,100,0.1]);

% eigs2 = diag([1,1,1]);


P = symmatrize(U1*eigs1*U1')*0.8;
% P=eye(3);
Q = symmatrize(U2*eigs2*U2')*1.5;

% P = symmatrize(U1*eigs1*U1')*0.5;
% % P=eye(3);
% Q = symmatrize(U2*eigs2*U2')*0.5;

checkSPDandPrintDet(P);
checkSPDandPrintDet(Q);

all_spd = plotGeodesicInterpolations(P, Q,10);

