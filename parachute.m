clear
close all
clc

##################################################################
ID = 300; % Inner diameter of parachute hole in mm
OD = 1850; % Outer diameter of parachute in mm
Sheets = 9; % How many sheets the parachute is sewed out of
PercentHalveSphere = 1; % Percentage of a complete halve sphere
##################################################################

thetaEnd = (PercentHalveSphere * 90);
thetaEndRad = deg2rad(thetaEnd);
radius = ((OD - ID) / 2) / (cos((pi/2)-thetaEndRad));
alpha_2 = 360 / (2 * Sheets);
alpha_2Rad = deg2rad(alpha_2);


theta_irad = 0;
SheetMatrix = [];
for theta_i = 0:thetaEnd
  
theta_irad = deg2rad(theta_i);
lr = radius * theta_irad; % Length of fabric measured from center to edge of parachute (origin at start of fabric)
lp_2 = ((ID / 2) + radius * cos((pi/2)-theta_irad)) * alpha_2Rad; % Circular length of fabric, half length i.v.m. symmetry

DataPoint = [lr;lp_2;-lp_2];
SheetMatrix = [SheetMatrix,DataPoint];
endfor

figure
hold on
plot(SheetMatrix(1,:),SheetMatrix(2,:),'b-','linewidth',1)
plot(SheetMatrix(1,:),SheetMatrix(3,:),'b-','linewidth',1)
theta = linspace(-alpha_2Rad,alpha_2Rad,100);
edge = [radius * thetaEndRad, radius * thetaEndRad;(((ID / 2) + radius * cos((pi/2)-thetaEndRad)) * -alpha_2Rad), (((ID / 2) + radius * cos((pi/2)-thetaEndRad)) * alpha_2Rad)];

rconeEdge = 0; % If the leading edge of the parachute isn't perpendicular with the vertical axis, the fabric must form a radius to accomodate the cone-shape it follows with its tangent face
ratioEdge = 0;
LongestEdge = (radius * thetaEndRad) / cos(alpha_2Rad);
if thetaEnd == 90
  plot(edge(1,:),edge(2,:),'b-','linewidth',1)
end
if thetaEnd < 90
  rconeEdge = (OD / 2) * (1)/(cos((pi/2)-thetaEndRad)*sin((pi/2)-thetaEndRad));
  ratioEdge = 0.85*(radius * thetaEndRad) / rconeEdge;
  plot(-rconeEdge + (radius * thetaEndRad) + rconeEdge*cos(theta*ratioEdge),0 + rconeEdge*sin(theta*ratioEdge),'b-','linewidth',1)
end
if thetaEnd > 90
  rconeEdge = (OD / 2) * (1)/(cos((pi/2)-thetaEndRad)*sin((pi/2)-thetaEndRad))
  ratioEdge = 0.55*(radius * thetaEndRad) / rconeEdge;
  plot(-rconeEdge + (radius * thetaEndRad) + rconeEdge*cos(theta*ratioEdge),0 + rconeEdge*sin(theta*ratioEdge),'b-','linewidth',1)
end

plot(-(ID/2.11) + (ID/2)*cos(theta), 0 + (ID/2)*sin(theta),'b-','linewidth',1) % Parachute hole is always projected on the fabric
axis equal
grid on
hold off

ID
OD
Sheets
PercentHalveSphere
% Paper documentation was lost before this commit, excuse the poor commentation.
% This script was quickly made and improvements were abandoned after the plots were proven functional,
% there's probably a lot of room for improvement in various areas of the code