import numpy as np
import matplotlib.pyplot as plt

max_of_int32=2147483647
ctrl=(max_of_int32//2)//5

# Data
intervals = [[-5*ctrl, -4*ctrl], [-4*ctrl, -3*ctrl], [-3*ctrl, -2*ctrl], [-2*ctrl, -1*ctrl], [-1*ctrl, 0*ctrl], [0*ctrl, 1*ctrl], [1*ctrl, 2*ctrl], [2*ctrl, 3*ctrl], [3*ctrl, 4*ctrl], [4*ctrl, 5*ctrl]]
polynomials = [lambda x: 0.01129*x + 0.06248*ctrl, 
               lambda x: 0.02943*x + 0.13404*ctrl, 
               lambda x: 0.07177*x + 0.25602*ctrl,
               lambda x: 0.14973*x + 0.41285*ctrl, 
               lambda x: 0.23105*x + 0.49653*ctrl, 
               lambda x: 0.23105*x + 0.50346*ctrl,
               lambda x: 0.14973*x + 0.58714*ctrl, 
               lambda x: 0.07177*x + 0.74097*ctrl, 
               lambda x: 0.02943*x + 0.86595*ctrl,
               lambda x: 0.01129*x + 0.93751*ctrl]

# Plotting
fig, ax = plt.subplots()
ax.set_xlabel('x')
ax.set_ylabel('y')

for interval, polynomial in zip(intervals, polynomials):
    x = np.linspace(interval[0], interval[1], 100)
    y = polynomial(x)
    ax.plot(x, y, label=f'[{interval[0]}, {interval[1]}]: $P_1(x)$')

ax.legend()
plt.show()