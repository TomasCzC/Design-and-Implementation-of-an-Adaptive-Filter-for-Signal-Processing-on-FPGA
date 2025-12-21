import numpy as np

def make_signals(fs, f0, T, noise_mean, noise_std, anc=False, seed=None):
    """
    Generate synthetic signal.
    Returns:
        x : measured signal (noisy)
        d : clean reference signal
    """
    if seed is not None:
        np.random.seed(seed)

    # number of samples
    N = int(fs * T)
    t = np.arange(N) / fs

    # clean signal
    d = np.sin(2 * np.pi * f0 * t)

    # noise
    noise = noise_mean + noise_std * np.random.randn(N)

    # measured signal
    x = d + noise

    return x, d


def hist_input(x, nt):
    x = np.asarray(x, dtype=float)
    N = len(x)

    if nt < 1 or nt > N:
        raise ValueError("nt must satisfy 1 ≤ nt ≤ len(x)")

    M = N - nt + 1
    X = np.zeros((M, nt), dtype=float)

    for i in range(M):
        X[i, :] = x[i : i + nt][::-1]

    return X
