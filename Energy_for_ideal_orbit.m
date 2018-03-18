%To simulate energy generated in ideal attitude for some orbits
%RUN contants v15 pow and Si_120k,light_120k,SGP_120k before running this
%code
load('light_120k');
load('Si_120k');
load('SGP_120k');
%for conviniece area and normal vectors are redefined

v_S=[v_S1',v_S2',v_S3',v_S4',v_S5',v_S6'];
Area=[Area_SP_S1,Area_SP_S2,Area_SP_S3,Area_SP_S4,Area_SP_S5,Area_SP_S6];
cosangle=[0,0,0,0,0,0]; %vector to store dot product between normal to solar vector
interval=0.1; %time in seconds
Energy=0.00; %variable to store Energy
%P=zeros(1,size(SGP_120k,2));
%totalpower=zeros(6,54000);
totalpower=zeros(54000, 6);
Energyplot=zeros(1,54000);
r_angle_v=zeros(1,54000);
%for i=1:size(SGP_120k,2)
sun_orbitframe = zeros(4,54000);
Power_side=zeros(54000,6);
SIFake_120k=zeros(4,70001);
for i=1:54000
    r=SGP_120k(2:4,i);
    v=SGP_120k(5:7,i);
    unitr=r/norm(r);
    unitv=v/norm(v);
    r_angle_v(i)= dot(unitr, unitv);
    z=-unitr;
    y=cross(unitv,unitr);
    y=y/norm(y);
    x=cross(y,z);
    DCM_IO=[x,y,z]'; %Rotation matrix to convert inertial frame vector to orbit frame vector
    sunvector_I=Si_120k(2:4,i);
    sun_orbitframe(2:4,i)=DCM_IO*sunvector_I;
    sunvector_O=DCM_IO*sunvector_I;
    for side=1:6
        cosangle(side)=dot(sunvector_O,v_S(:,side));
%           if (side == 4)
%             sunside_vector(i)=dot(sunvector_O,v_S(:,side));
%           elseif (side == 3)
%             antisunside_vector(i)=dot(sunvector_O,v_S(:,side));  
%             %cosangle(side)=1;        
        if (cosangle(side)<0)
            cosangle(side)=0;
        else    
        end
        %Power_side(i,side)=efficiany_solar_cell*Area(side)*Solar_Constant*cosangle(side)*light_120k(2,i);
        Power_side(i,side)=Solar_Constant*cosangle(side)*light_120k(2,i);
        Energy=Energy+(Power_side(i,side)*interval);
        Energyplot(i)=Energy;
        totalpower(i, side)=totalpower(i, side)+Power_side(i,side);
    end 
    
end
Energy;
fprintf('Energy_for_ideal_orbit done \n')
%Code hereafter is just to plot power on each side
figure
plot(Power_side);
title('Power vs Time for One Orbit');
legend('Leading','Lagging','AntiSunside','Sunside','Nadir','Zenith')
xlabel('Time (0.1s)');
ylabel('Power(W)')