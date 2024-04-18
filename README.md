# Instructions on model use
## First
- Download all files (It requires Matlab2024a)

## Settings in the model
- endtime: Duration of the simulation
- Ref: Desired position given in x, y, Yaw
- InitialPos: Start position in x, y, Yaw
- Speedfactor: Percentage of the maxflowrate in the tank
- PID values: Uncomment the file for the desired senario. The no current PID works the best for all situation

## Results
The file generates the following results:
- Combined plot of all acceleration, velocities and positions
- Current and speed of the SB motor
- Current and speed of the PS motor
- Combined displacement of X and Y in XY plane
- Plot on X-data
- Plot on Y-data
- Plot on Yaw-data 
