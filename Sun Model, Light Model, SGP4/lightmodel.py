#to understand the names of variable please refer to lightmodel
import math as mt
import numpy as np
from datetime import *
import matplotlib.pyplot as plt
Rearth = 6378164 #Radius of Earth in meters
AU = 159597870610 #Distance between sun and earth in meters
Rsun = 695500000 #Radius of the Sun in meters
sgp_output=np.genfromtxt('sgp_output.csv', delimiter=",")
si_output=np.genfromtxt('si_output.csv', delimiter=",")
T = sgp_output[0,:] #storing first element as time
positionvectorarray = sgp_output[1:4,:]  #Storing the position vector of satellite given by sgp4 model
N = len(T)
light_output =np.empty([2,N])
umbra = AU*Rearth / (Rsun - Rearth) #distance from centre of the earth to the vertex of the umbra cone
penumbra = AU*Rearth / (Rsun + Rearth) #distance from centre of the earth to the vertex of the penumbra cone
alpha = mt.asin(Rearth / umbra) #Half the aperture of the cone made by umbra
beta = mt.asin(Rearth / penumbra) #Half the aperture of the cone made by penumbra
for i in range(N):
    position_satellite = positionvectorarray[:,i] 
    sunvector = si_output[1:4,i]
    angle_sat = mt.acos(np.dot(position_satellite, sunvector) /np.linalg.norm(position_satellite) )
    parameter_umbra = mt.acos((np.dot((position_satellite + umbra*sunvector), sunvector)) / np.linalg.norm(position_satellite + umbra*sunvector))
    parameter_penumbra =mt.acos((np.dot((position_satellite - penumbra*sunvector), -sunvector)) / np.linalg.norm(position_satellite - penumbra*sunvector))
    flag = 1; #Boolean to store whether satellite is in light or dark. 1 implies satellite is in light.
    if (angle_sat >= np.pi/2 + alpha) & (parameter_umbra <= alpha):
        flag = 0
    if (angle_sat >=np.pi/2 + beta) & (parameter_umbra > alpha) & (parameter_penumbra <= beta):
        flag = 0.5
    light_output[0,i] = T[i] 
    light_output[1,i] = flag  
np.savetxt("light_output.csv", light_output, delimiter=',')
plt.plot(light_output[1,:])
plt.show()