Steps to use SGP4 to generate orbit data
Open getorbitdata.py
Insert the first line of TLE on line 5 and second line of TLE on line 6
Insert the initial time for which simulation has to be run on line 8
Insert the timedelay between two datapoints for simulation in seconds on line 9
Insert the total time for which you need datapoints in seconds on line 10
Run the code

Output specifications:
getorbitdata.py saves a csv file which contains the matrix elements for the position and velocity in ECI Frame.
The first line contains the time from the start of simulation for each datapoint.
the 1:4th elements consist of the position
the 5:7th elements consist of the velocity


Steps to use sunmodel to get sunvector
run getorbitdata.py as mentioned above
open sunmodel.py
Insert the initial time for which simulation has to be run on line 4
Insert the closest equinox date on line 5 (You may have to google this up)
Run the code

Output specification
sunmodel.py saves a csv file which contains the vector elements of sun vector in ECI Frame
The first line contains the time from the start of simulation for each datapoint.
the 1:4th elements consist of the sun vector


Steps to use lightmodel to get light flag
run getorbitdata.py and sunmodel.py as mentioned above.
Run the lightmodel.py

Output Specifications:
lightmodel.py saves a csv file which contains the time and light flag
The first line contains the time from the start of simulation for each datapoint.
the 1th element consists of the light flag
