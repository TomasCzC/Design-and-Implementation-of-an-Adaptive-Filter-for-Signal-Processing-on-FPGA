import numpy as np
from .safety import SAFE_MAX

def fft_mag(x, fs):
    x = np.nan_to_num(x, nan=0.0, posinf=SAFE_MAX, neginf=-SAFE_MAX)
    if x.size == 0:
        return np.array([]), np.array([])

    N = len(x)
    f = np.fft.rfftfreq(N, 1.0 / fs)
    X = np.fft.rfft(x) / max(1, N)
    X = np.nan_to_num(X)
    return f, np.abs(X) + 1e-15
