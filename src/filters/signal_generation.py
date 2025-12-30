import numpy as np

def make_signals(fs, f0, T, noise_mean, noise_std, seed):
    N = int(fs * T)
    # Používáme float64 pro maximální přesnost vzorků
    t = np.linspace(0, T, N, endpoint=False, dtype=np.float64)

    d = np.sin(2 * np.pi * f0 * t)

    # KLÍČOVÁ OPRAVA: Pokud je šum nastaven na 0, x je přímá kopie d.
    # Žádné přičítání pole "noise", které by mohlo obsahovat numerické zbytky.
    if abs(noise_std) < 1e-15 and abs(noise_mean) < 1e-15:
        x = d.copy()
    else:
        if seed is not None:
            np.random.seed(int(seed))
        noise = np.random.normal(noise_mean, noise_std, size=N)
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
