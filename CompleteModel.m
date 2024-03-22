% Ship movements simulator
%--------------------------------------------------------------------------
clc, clear, close all

% Simulation properties
endtime = 60;%s
Ref = [0;0;0];

Tmech = 0.6;%Nm

% Ship properties
load("SR.mat");

% Motor properties
load("DC.mat");
T_matrix = [1 1 0; 0 0 1; -0.065 0.065 0.35];
M_matrix = [2.5 0 0; 0 2.50 0; 0 0 1];

T_coef_PS = [2E-09 3E-07 0.0003 0];%Functie RPM
T_coef_SB = [1e-09 2E-07 0.0004 0];%Functie RPM
T_bow = [-11.72 -13.257 7.8134 10.766 -1.0091 0.4332 0];%Functie input gain signal

% Forces input
TauE = [1;0;0];%Current forces


% Start simulation
%--------------------------------------------------------------------------
sim("CompleteModel.slx");

Distance = ans.Distance;

% Plot results
%--------------------------------------------------------------------------

figure1 = figure('Name','Motions');
tiledlayout(3,1)
nexttile
plot(ans.Acc);
title("Accelerations")
xlabel("time (s)")
ylabel("a (m/s2)")
grid on
legend("X","Y","Yaw")
xlim([1,endtime])

nexttile
plot(ans.tout,ans.Speed);
title("Velocity")
xlabel("time (s)")
ylabel("v (m/s)")
grid on
legend("X","Y","Yaw")
xlim([1,endtime])

nexttile
plot(ans.tout, ans.Distance);
title("Displacement")
xlabel("time (s)")
ylabel("s (m)")
grid on
legend("X","Y","Yaw")
xlim([1,endtime])


figure2 = figure('Name','Motor');
tiledlayout(2,1)
nexttile
plot(ans.Wm_SB);
title("Rotational speed")
xlabel("time (s)")
ylabel("Rad/s")
grid on
xlim([1,endtime])

nexttile
plot(ans.Ia_SB);
title("Armature Current")
xlabel("time (s)")
ylabel("A")
grid on
xlim([1,endtime])

figure3 = figure("Name","XY displacement");
plot(Distance(:,1), Distance(:,2));
xlabel("X (m)");
ylabel("Y (m)");
grid on