%% Read .csv simulation files
clearvars
close all
clc

currDir = "../INV_X4/simulations/";
yRange = [1 1.8];

t_F = csvread(currDir + "t_F.csv", 1, 0);
t_R = csvread(currDir + "t_R.csv", 1, 0);
tp_L = csvread(currDir + "tp_L.csv", 1, 0);
tp_H = csvread(currDir + "tp_H.csv", 1, 0);
t_F_s = csvread(currDir + "t_F_schematic.csv", 1, 0);
t_R_s = csvread(currDir + "t_R_schematic.csv", 1, 0);
tp_L_s = csvread(currDir + "tp_L_schematic.csv", 1, 0);
tp_H_s = csvread(currDir + "tp_H_schematic.csv", 1, 0);

%% Plot graphs
inTime = 4; %40 ps

figure
plot(t_F(:,2*inTime-1).*1e15,t_F(:,2*inTime).*1e12,'-*',...
    t_F_s(:,2*inTime-1).*1e15,t_F_s(:,2*inTime).*1e12,'-*')
ylabel('Output 70%-30% falling time [ps]')
xlabel('Load Capacitance [fF]')
grid on
legend('From layout (w parasitics)','From schematic (w/o parasitics)')

figure
plot(t_R(:,2*inTime-1).*1e15,t_R(:,2*inTime).*1e12,'-*',...
    t_R_s(:,2*inTime-1).*1e15,t_R_s(:,2*inTime).*1e12,'-*')
ylabel('Output 70%-30% rising time [ps]')
xlabel('Load Capacitance [fF]')
grid on
legend('From layout (w parasitics)','From schematic (w/o parasitics)')

figure
plot(tp_L(:,2*inTime-1).*1e15,tp_L(:,2*inTime).*1e12,'-*',...
    tp_L_s(:,2*inTime-1).*1e15,tp_L_s(:,2*inTime).*1e12,'-*')
ylabel('Output falling 50%-50% propagation delay [ps]')
xlabel('Load Capacitance [fF]')
grid on
legend('From layout (w parasitics)','From schematic (w/o parasitics)')

figure
plot(tp_H(:,2*inTime-1).*1e15,tp_H(:,2*inTime).*1e12,'-*',...
    tp_H_s(:,2*inTime-1).*1e15,tp_H_s(:,2*inTime).*1e12,'-*')
ylabel('Output rising 50%-50% propagation delay [ps]')
xlabel('Load Capacitance [fF]')
grid on
legend('From layout (w parasitics)','From schematic (w/o parasitics)')

%% Compute differences
t_F_diff = t_F(:,2*inTime)./t_F_s(:,2*inTime);
t_R_diff = t_R(:,2*inTime)./t_R_s(:,2*inTime);
tp_L_diff = tp_L(:,2*inTime)./tp_L_s(:,2*inTime);
tp_H_diff = tp_H(:,2*inTime)./tp_H_s(:,2*inTime);

figure
plot(t_F(:,2*inTime-1).*1e15,t_F_diff,'-*')
grid on
xlabel('Load Capacitance [fF]')
ylabel('Normalized output 70%-30% falling time')
ylim(yRange)
exportPdf(gcf, currDir + "t_F_diff")

figure
plot(t_R(:,2*inTime-1).*1e15,t_R_diff,'-*')
grid on
xlabel('Load Capacitance [fF]')
ylabel('Normalized output 70%-30% rising time')
ylim(yRange)
exportPdf(gcf, currDir + "t_R_diff")

figure
plot(tp_L(:,2*inTime-1).*1e15,tp_L_diff,'-*')
grid on
xlabel('Load Capacitance [fF]')
ylabel('Normalized output falling 50%-50% propagation delay')
ylim(yRange)
exportPdf(gcf, currDir + "tp_L_diff")

figure
plot(tp_H(:,2*inTime-1).*1e15,tp_H_diff,'-*')
grid on
xlabel('Load Capacitance [fF]')
ylabel('Normalized output rising 50%-50% propagation delay')
ylim(yRange)
exportPdf(gcf, currDir + "tp_H_diff")