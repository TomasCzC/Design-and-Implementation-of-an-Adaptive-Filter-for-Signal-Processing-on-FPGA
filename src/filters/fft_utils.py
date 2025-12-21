import numpy as np
from src.filters.safety import clamp_array


def fft_mag(x, fs):
    x = clamp_array(x)

    if len(x) == 0:
        return np.array([]), np.array([])

    N = len(x)
    X = np.fft.rfft(x) / max(1, N)
    f = np.fft.rfftfreq(N, d=1.0 / fs)

    X = np.nan_to_num(np.abs(X), nan=0.0, posinf=0.0, neginf=0.0)
    return f, X
