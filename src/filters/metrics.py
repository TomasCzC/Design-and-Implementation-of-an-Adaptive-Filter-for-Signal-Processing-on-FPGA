import numpy as np
from src.filters.safety import safe_square


def moving_avg(v, win):
    v = np.asarray(v, dtype=float)

    if win <= 1 or len(v) < win:
        return v.copy()

    c = np.cumsum(np.insert(v, 0, 0.0))
    y = (c[win:] - c[:-win]) / float(win)

    pad = np.full(win - 1, y[0])
    return np.concatenate([pad, y])


def compute_metrics(s, x, y, e, nt, anc=False):
    e = np.asarray(e, dtype=float)
    mse_curve = safe_square(e)

    tail = min(2000, len(mse_curve))
    mse_end = float(np.mean(mse_curve[-tail:]))

    if anc:
        d_primary, s_clean = s
        v = d_primary - s_clean
    else:
        v = x - s

    sigma_v2 = float(np.mean(v[nt - 1 :] ** 2)) + 1e-15
    J_min = sigma_v2

    emse = max(mse_end - J_min, 0.0)
    misadj = emse / J_min if J_min > 0 else float("inf")

    s_ref = s[1][nt - 1 :] if anc else s[nt - 1 :]
    Ps = float(np.mean(s_ref**2)) + 1e-15
    Pin = float(np.mean((x[nt - 1 :] - s_ref) ** 2)) + 1e-15
    Pout = float(np.mean((y - s_ref) ** 2)) + 1e-15

    snr_in = 10.0 * np.log10(Ps / Pin)
    snr_out = 10.0 * np.log10(Ps / Pout)

    thr = 0.1 * mse_curve[0]
    n90 = int(np.argmax(mse_curve <= thr)) if np.any(mse_curve <= thr) else len(mse_curve)

    return {
        "mse": mse_end,
        "emse": emse,
        "jmin": J_min,
        "misadj": misadj,
        "snr_in": snr_in,
        "snr_out": snr_out,
        "dsnr": snr_out - snr_in,
        "n90": n90,
    }
