import numpy as np

def fft_mag(x, fs):
    if len(x) == 0:
        return np.array([]), np.array([])

    N = len(x)
    X = np.fft.rfft(x.astype(np.float64)) / N 
    f = np.fft.rfftfreq(N, d=1.0 / fs)

    X = np.abs(X)
    return f, X