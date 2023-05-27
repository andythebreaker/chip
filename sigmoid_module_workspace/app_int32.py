import numpy as np
import matplotlib.pyplot as plt

max_of_int32=2147483647
min_of_int32=-2147483648

const_1 = 0.01129
const_2 = 0.06248 
const_3 = 0.02943
const_4 = 0.13404 
const_5 = 0.07177
const_6 = 0.25602
const_7 = 0.14973
const_8 = 0.41285 
const_9 = 0.23105
const_10 = 0.49653 
const_11 = 0.23105
const_12 = 0.50346
const_13 = 0.14973
const_14 = 0.58714 
const_15 = 0.07177
const_16 = 0.74097 
const_17 = 0.02943
const_18 = 0.86595
const_19 = 0.01129
const_20 = 0.93751

x = np.empty(1000000, dtype=np.float128)
x = np.linspace(min_of_int32, max_of_int32, num=1000000)

ctrl=(max_of_int32//2)//5

y = np.zeros_like(x)
for i in range(len(x)):
    tmp=x[i]
    if tmp <= -5*ctrl:
        y[i] = min_of_int32
    elif tmp >= -5*ctrl and tmp <= -4*ctrl:
        y[i] = const_1*tmp + const_2*ctrl
    elif tmp >= -4*ctrl and tmp <= -3*ctrl:
        y[i] = const_3*tmp + const_4*ctrl
    elif tmp >= -3*ctrl and tmp <= -2*ctrl:
        y[i] = const_5*tmp + const_6*ctrl
    elif tmp >= -2*ctrl and tmp <= -1*ctrl:
        y[i] = const_7*tmp + const_8*ctrl
    elif tmp >= -1*ctrl and tmp <= 0*ctrl:
        y[i] = const_9*tmp + const_10*ctrl
    elif tmp >= 0*ctrl and tmp <= 1*ctrl:
        y[i] = const_11*tmp + const_12*ctrl
    elif tmp >= 1*ctrl and tmp <= 2*ctrl:
        y[i] = const_13*tmp + const_14*ctrl
    elif tmp >= 2*ctrl and tmp <= 3*ctrl:
        y[i] = const_15*tmp + const_16*ctrl
    elif tmp >= 3*ctrl and tmp <= 4*ctrl:
        y[i] = const_17*tmp + const_18*ctrl
    elif tmp >= 4*ctrl and tmp <= 5*ctrl:
        y[i] = const_19*tmp + const_20*ctrl
    else:
        y[i] = max_of_int32

# Plotting the input and output
plt.plot(x, y)
plt.xlabel('Input (x)')
plt.ylabel('Output (y)')
plt.title('Input vs. Output')
plt.grid(True)
plt.show()
