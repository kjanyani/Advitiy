load SGP_120k;
%Please refer to the document 'Calculating Sun vector in ECI Frame.pdf'
today = datenum('21-Mar-2018 21:45:0'); % ** SGP, IGRF data have been created for this date **
equinox = datenum('20-Mar-2018 21:45:0'); % date of equinox

T = SGP_120k(1,:);
N = length(T);

Si_120k = zeros(4,N);
%differenceSi = zeros(4,N);
% for i=1:N
%     beta = 0;   %what is this? document this block.??
%     time1 = today - equinox + T(i) / 86400;
%     lambda = (2*pi*time1) / 365.256363; %Thetha of document is lambda here
%     epsilon = 23.5 * pi / 180;
% 
%     sin_delta = cos(epsilon)*sin(beta) + sin(epsilon)*cos(beta)*sin(lambda);
%     delta = asin(sin_delta);
% 
%     cos_alpha = cos(lambda) * cos(beta) / cos(delta);
%     alpha = acos(cos_alpha);
%     if (delta >= 0)
%         alpha = alpha;
%     else
%         alpha = (2*pi - 2*alpha) + alpha;
%     end
% 
%     x = cos(delta)*cos(alpha);
%     y = cos(delta)*sin(alpha);
%     z = sin(delta);
% 
%     v_Sun_i = [x; y; z];
% 
%     Si_120k(1,i) = T(i);
%     Si_120k(2:4,i) = v_Sun_i;
%     
%     if mod(i,100000) == 0 
%         fprintf('done %i\n',i/10)
%     end
% 
% end
for i=1:N
    time = today - equinox + T(i) / 86400; %The time passed from equinox till each point in orbit in days
    theta = (2*pi*time) / 365.256363; %Angle between intermediate frame (s) and (epsilon) frame about common z-axis
    epsilon = 23.5 * pi / 180; %Angle between rotation axis and orbital plane normal
    x=cos(theta);%components as got from document reffered
    y=sin(theta)*cos(epsilon);
    z=sin(theta)*sin(epsilon);
    v_Sun = [x; y; z]; %sun vector in ECI Frame
    Si_120k(1,i) = T(i); %first component is time
    Si_120k(2:4,i) = v_Sun;

end

fprintf('Done')
%save Si_120k.mat Si_120k1
