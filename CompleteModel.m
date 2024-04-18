% Ship movements simulator
%--------------------------------------------------------------------------
clc, clear, close all

% Simulation properties
endtime = 100;%s
Ref = [1;0;0];
InitialPos = [0;0;0];

% Forces input
TauE = [-0.15;0;0]; %Current speed
SpeedFactor = 0.07;

% PID Values (Choose values)
%run("PID_Current.m");
run("PID_NoCurrent.m");

% Ship properties
load("SR.mat");

% Motor properties
load("DC.mat");
T_matrix = [0 1 0; 1 0 1; 0.35 -0.065 -0.35];
M_matrix = [2.5 0 0; 0 2.50 0; 0 0 1];

T_coef_PS = [2E-09 3E-07 0.0003 0];%Functie RPM
T_coef_SB = [1e-09 2E-07 0.0004 0];%Functie RPM
T_bow = [-11.72 -13.257 7.8134 10.766 -1.0091 0.4332 0];%Functie input gain signal

D = 0.069;

%%
% Start simulation
%--------------------------------------------------------------------------
sim("CompleteModelSimulink.slx");

%% 
% Plot results
%--------------------------------------------------------------------------

% Figure on All motions
figure1 = figure('Name','Motions');
figure1.Position = [200 125 900 650];
tiledlayout(3,1)
nexttile
plot(ans.Acc_X);
hold on
plot(ans.Acc_Y)
plot(ans.Acc_Yaw)
hold off
title("Accelerations");
xlabel("time (s)");
ylabel("a (m/s2)");
grid on
legend("X","Y","Yaw");

nexttile
plot(ans.tout,ans.Speed);
title("Velocity")
xlabel("time (s)")
ylabel("v (m/s)")
grid on
legend("X","Y","Yaw")

nexttile
plot(ans.tout, ans.Distance);
title("Displacement")
xlabel("time (s)")
ylabel("s (m)")
grid on
legend("X","Y","Yaw")

%% 
% Figure on SB Motor
figure2 = figure('Name','DC Motor SB');
figure2.Position = [200 125 900 650];
tiledlayout(2,1)
nexttile
plot(ans.RPM_SB);
title("RPM-s")
xlabel("time (s)")
ylabel("RPM")
grid on
xlim([1,endtime])

nexttile
plot(ans.Ia_SB);
title("Armature Current")
xlabel("time (s)")
ylabel("A")
grid on

%% 
%Figure on PS Motor
figure3 = figure('Name','DC Motor PS');
figure3.Position = [200 125 900 650];
tiledlayout(2,1)
nexttile
plot(ans.RPM_PS);
title("RPM-s")
xlabel("time (s)")
ylabel("RPM")
grid on
xlim([1,endtime])

nexttile
plot(ans.Ia_PS);
title("Armature Current")
xlabel("time (s)")
ylabel("A")
grid on

%% 
%Figure on combined XY dispacement
Distance = ans.Distance;
figure4 = figure("Name","XY displacement");
figure4.Position = [200 125 900 650];
plot(Distance(:,1), Distance(:,2));
xlabel("X (m)");
ylabel("Y (m)");
grid on

%% 
% Figure on X data
figure5 = figure("Name","Global X");
figure5.Position = [200 125 900 650];
tiledlayout(3,1);
nexttile;
plot(ans.Acc_X);
xlabel("time (s)");
ylabel("Acceleration X (m/s2)");
grid on;

nexttile;
plot(ans.V_X);
xlabel("time (s)");
ylabel("Velocity X (m/s)");
grid on;

nexttile;
plot(ans.S_X);
xlabel("time (s)");
ylabel("traveled distance X (m)");
grid on;

%% 
% Figure on Y data
figure6 = figure("Name","Global Y");
figure6.Position = [200 125 900 650];
tiledlayout(3,1);
nexttile;
plot(ans.Acc_Y);
xlabel("time (s)");
ylabel("Acceleration Y (m/s2)");
grid on;

nexttile;
plot(ans.V_Y);
xlabel("time (s)");
ylabel("Velocity Y (m/s)");
grid on;

nexttile;
plot(ans.S_Y);
xlabel("time (s)");
ylabel("traveled distance Y (m)");
grid on;

%% 
% Figure on Yaw data
figure7 = figure("Name","Global Yaw");
figure7.Position = [200 125 900 650];
tiledlayout(3,1);
nexttile;
plot(ans.Acc_Yaw);
xlabel("time (s)");
ylabel("Acceleration Yaw (rad/s2)");
grid on;

nexttile;
plot(ans.V_Yaw);
xlabel("time (s)");
ylabel("Velocity Yaw (rad/s)");
grid on;

nexttile;
plot(ans.S_Yaw);
xlabel("time (s)");
ylabel("traveled distance Yaw (rad)");
grid on;

