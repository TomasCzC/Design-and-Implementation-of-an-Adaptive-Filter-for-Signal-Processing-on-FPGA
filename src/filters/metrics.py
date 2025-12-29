import numpy as np
from src.filters.safety import safe_square

def moving_avg(x, win):
    x = np.asarray(x, dtype=float)

    if win <= 1 or len(x) < win:
        return x.copy()

    kernel = np.ones(win) / win
    y = np.convolve(x, kernel, mode="valid")

    pad = np.full(win - 1, y[0])
    return np.concatenate([pad, y])

def compute_metrics(
    *,
    x,          # measured input signal
    d,          # desired signal
    y,          # filter output
    e,          # error signal
    nt,
    s_ref=None  # clean reference (optional, ANC only)
):

    x = np.asarray(x, dtype=float)
    d = np.asarray(d, dtype=float)
    y = np.asarray(y, dtype=float)
    e = np.asarray(e, dtype=float)

    L = min(len(x), len(d), len(y), len(e))
    x = x[:L]
    d = d[:L]
    y = y[:L]
    e = e[:L]

    if s_ref is None:
        s_ref = d.copy()
    else:
        s_ref = np.asarray(s_ref, dtype=float)[:L]

    nt_eff = max(1, min(nt, L))

    mse_curve = safe_square(e)

    tail = min(2000, len(mse_curve))
    mse_ss = float(np.mean(mse_curve[-tail:]))

    v = x - s_ref
    J_min = float(np.mean(v[nt_eff - 1 :] ** 2)) + 1e-15

    emse = max(mse_ss - J_min, 0.0)
    misadj = emse / J_min if J_min > 0 else float("inf")

    Ps = float(np.mean(s_ref[nt_eff - 1 :] ** 2)) + 1e-15
    Pin = float(np.mean((x[nt_eff - 1 :] - s_ref[nt_eff - 1 :]) ** 2)) + 1e-15
    Pout = float(np.mean((y[nt_eff - 1 :] - s_ref[nt_eff - 1 :]) ** 2)) + 1e-15

    snr_in = 10.0 * np.log10(Ps / Pin)
    snr_out = 10.0 * np.log10(Ps / Pout)

    thr = 1.1 * mse_ss
    below = np.where(mse_curve <= thr)[0]
    n90 = int(below[0]) if len(below) > 0 else len(mse_curve)

    return {
        "mse": mse_ss,
        "emse": emse,
        "jmin": J_min,
        "misadj": misadj,
        "snr_in": snr_in,
        "snr_out": snr_out,
        "dsnr": snr_out - snr_in,
        "n90": n90,
    }
