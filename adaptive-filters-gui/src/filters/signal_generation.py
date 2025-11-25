import numpy as np

def make_signals(fs=2000.0, f0=100.0, T=0.8,
                 noise_mean=0.0, noise_std=0.1,
                 anc=False, seed=0):

    rng = np.random.default_rng(seed)
    t = np.arange(0.0, T, 1.0 / fs)
    s_clean = np.sin(2 * np.pi * f0 * t)

    if not anc:
        n = rng.normal(noise_mean, noise_std, size=t.size)
        x = s_clean + n
        return t, s_clean, x

    n1 = rng.normal(noise_mean, noise_std, size=t.size)
    b = np.array([1.0, 0.5, 0.25])
    x_ref = np.convolve(n1, b, mode="same")
    d_primary = s_clean + n1
    return t, (d_primary, s_clean), x_ref


def hist_input(x, nt):
    N = len(x)
    if nt < 1 or nt > N:
        raise ValueError("invalid taps: nt must be 1..len(x)")
    M = N - nt + 1
    X = np.zeros((M, nt))
    for i in range(M):
        X[i, :] = x[i:i + nt][::-1]
    return X
