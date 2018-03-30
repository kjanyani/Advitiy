%code to plot orbit along with sunvector
load('SGP_120k')
load('Si_120k')
magnification=10e+06; % Just to make the sunvector (Direction) Visible in the plot

%plot3(magnification*Si_120k(2,:),magnification*Si_120k(3,:),magnification*Si_120k(4,:))

plot3(SGP_120k(2,:),SGP_120k(3,:),SGP_120k(4,:)) %Plotting the orbit
hold on
quiver3(0,0,0,magnification*Si_120k(2,1),magnification*Si_120k(3,1),magnification*Si_120k(4,1)) %plotting the vector
hold off