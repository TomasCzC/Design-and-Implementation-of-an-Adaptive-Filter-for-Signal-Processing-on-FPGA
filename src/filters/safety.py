import numpy as np

SAFE_MAX = 1e12
SAFE_SQ_MAX = 1e300
SAFE_MIN_POS = 1e-15


def clamp_array(a, maxval=SAFE_MAX):
    a = np.asarray(a)

    if np.iscomplexobj(a):
        a = np.abs(a)

    a = a.astype(float)
    a = np.nan_to_num(a, nan=0.0, posinf=maxval, neginf=-maxval)
    if maxval is not None:
        a = np.clip(a, -maxval, maxval)
    return a

def safe_square(a):
    a = np.asarray(a)

    if np.iscomplexobj(a):
        a = np.abs(a)

    a = a.astype(float)
    a = np.nan_to_num(a, nan=0.0, posinf=SAFE_MAX, neginf=-SAFE_MAX)
    sq = a * a
    sq = np.clip(sq, 0.0, SAFE_SQ_MAX)
    return sq


def safe_log10_of_square(a):
    sq = safe_square(a)
    sq = np.maximum(sq, SAFE_MIN_POS)
    return 10.0 * np.log10(sq)
