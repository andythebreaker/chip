import math
import numpy as np

max_of_int32 = 2147483647
min_of_int32 = -2147483648

points_f = np.linspace(min_of_int32, max_of_int32, num=1000000)
points = np.round(points_f).astype(int)

for x in points:
    print(f"#10;x={x};")
