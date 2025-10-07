import numpy as np
import matplotlib.pyplot as plt
import padasip as pa

fs = 100000
f = 5
T = 1
t = np.arange(0, T, 1/fs)
s = np.sin(2*np.pi*f*t) #Signál (a zároveň referenční signál)
n = np.random.normal(0, 0.1, len(t)) #Šum (Noise)
x = s + n

n_koef = 32
mu = 0.05
lms_filter = pa.filters.FilterLMS(n_koef, mu)

y = np.zeros_like(t)
e = np.zeros_like(t)

for i in range(n_koef, len(t)):
    x_vec = x[i - n_koef + 1:i + 1]
    y[i] = lms_filter.predict(x_vec)
    e[i] = s[i] - y[i]
    lms_filter.adapt(x_vec, e[i])

plt.figure(figsize=(10, 6))
plt.subplot(3, 1, 1)
plt.plot(t, x)
plt.xlabel("čas [s]")
plt.ylabel("Amplituda")
plt.title("Sinus + šum")
plt.subplot(3, 1, 2)
plt.plot(t, y)
plt.xlabel("čas [s]")
plt.ylabel("Amplituda")
plt.title("Výstup filtru")
plt.subplot(3, 1, 3)
plt.plot(t, e)
plt.title("Signál chybové funkce")
plt.tight_layout()
plt.show()
