import numpy as np
import matplotlib.pyplot as plt

# Data
intervals = [[-5, -4], [-4, -3], [-3, -2], [-2, -1], [-1, 0], [0, 1], [1, 2], [2, 3], [3, 4], [4, 5]]
polynomials = [lambda x: 0.01129*x + 0.06248, lambda x: 0.02943*x + 0.13404, lambda x: 0.07177*x + 0.25602,
               lambda x: 0.14973*x + 0.41285, lambda x: 0.23105*x + 0.49653, lambda x: 0.23105*x + 0.50346,
               lambda x: 0.14973*x + 0.58714, lambda x: 0.07177*x + 0.74097, lambda x: 0.02943*x + 0.86595,
               lambda x: 0.01129*x + 0.93751]

# Sigmoid function
def sigmoid(x):
    return 1 / (1 + np.exp(-x))

# Plotting
fig, ax = plt.subplots()
ax.set_xlabel('x')
ax.set_ylabel('y')

for interval, polynomial in zip(intervals, polynomials):
    x = np.linspace(interval[0], interval[1], 100)
    y = polynomial(x)
    ax.plot(x, y, label=f'[{interval[0]}, {interval[1]}]: $P_1(x)$')

# Plotting sigmoid function
x_sigmoid = np.linspace(-5, 5, 100)
y_sigmoid = sigmoid(x_sigmoid)
ax.plot(x_sigmoid, y_sigmoid, label='Sigmoid')

ax.legend()
plt.show()
