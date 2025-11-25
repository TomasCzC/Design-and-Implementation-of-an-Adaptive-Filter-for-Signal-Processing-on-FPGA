import numpy as np
from .safety import safe_square, SAFE_MAX

def moving_avg(v, win):
    v = np.asarray(v, float)
    if win <= 1 or len(v) < win:
        return np.nan_to_num(v, nan=0.0, posinf=SAFE_MAX, neginf=-SAFE_MAX)

    finite = v[np.isfinite(v)]
    fill = float(np.median(finite)) if finite.size else 0.0
    v = np.where(np.isfinite(v), v, fill)

    c = np.cumsum(np.insert(v, 0, 0.0))
    y = (c[win:] - c[:-win]) / float(win)
    pad = np.full(win - 1, y[0] if y.size else fill)
    return np.concatenate([pad, y])


def compute_metrics(s, x, y, e, nt, anc=False):
    e = np.nan_to_num(e)

    if anc:
        d_full, s_clean = s
        s_ref = s_clean[nt - 1:]
        x_in = d_full[nt - 1:]
        v = d_full - s_clean
        sigma_v2 = float(np.mean(v[nt - 1:]**2)) + 1e-15
    else:
        s_clean = s
        s_ref = s_clean[nt - 1:]
        x_in = x[nt - 1:]
        v = x - s_clean
        sigma_v2 = float(np.mean(v[nt - 1:]**2)) + 1e-15

    mse_curve = safe_square(e)
    tail = min(2000, len(mse_curve))
    mse_end = float(np.mean(mse_curve[-tail:])) + 1e-15

    emse = max(mse_end - sigma_v2, 0.0)
    misadj = emse / sigma_v2 if sigma_v2 > 0 else float("inf")

    Ps = float(np.mean(s_ref**2)) + 1e-15
    Pin = float(np.mean((x_in - s_ref)**2)) + 1e-15
    Pout = float(np.mean((y - s_ref)**2)) + 1e-15

    snr_in = 10 * np.log10(Ps / Pin)
    snr_out = 10 * np.log10(Ps / Pout)

    thr = 0.1 * mse_curve[0]
    n90 = int(np.argmax(mse_curve <= thr)) if np.any(mse_curve <= thr) else len(mse_curve)

    return dict(
        mse=mse_end,
        emse=emse,
        jmin=sigma_v2,
        misadj=misadj,
        snr_in=snr_in,
        snr_out=snr_out,
        dsnr=snr_out - snr_in,
        n90=n90
    )
