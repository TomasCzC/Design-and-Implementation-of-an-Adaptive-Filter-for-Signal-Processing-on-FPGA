import numpy as np
import matplotlib.pyplot as plt

fs = 100000
f = 5
T = 1
t = np.arange(0, T, 1/fs)
s = np.sin(2*np.pi*f*t) #Signál
n = np.random.normal(0, 0.1, len(t)) #Šum (Noise)
x = s + n

plt.plot(t, x)
plt.xlabel("čas [s]")
plt.ylabel("Ampl")
plt.title("Sinus + šum")
#plt.plot(t, y)
plt.legend()
plt.show()
