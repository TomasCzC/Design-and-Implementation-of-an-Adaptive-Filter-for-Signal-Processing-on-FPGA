import numpy as np

SAFE_MAX = 1e12
SAFE_SQ_MAX = 1e300
SAFE_MIN_POS = 1e-15
DIVERGENCE_WARN_THRESHOLD = SAFE_MAX * 0.1

def clamp_array(a, maxval=SAFE_MAX):
    a = np.asarray(a, dtype=float)
    a = np.nan_to_num(a, posinf=maxval, neginf=-maxval, nan=0.0)
    return np.clip(a, -maxval, maxval)

def safe_square(a):
    a = np.asarray(a, dtype=float)
    a = np.nan_to_num(a, nan=0.0, posinf=SAFE_MAX, neginf=-SAFE_MAX)
    sq = np.square(a)
    return np.clip(sq, 0.0, SAFE_SQ_MAX)

def safe_db_from_square(arr):
    arr = np.asarray(arr, dtype=float)
    arr = np.nan_to_num(arr, nan=0.0, posinf=SAFE_SQ_MAX, neginf=0.0)
    arr = np.maximum(arr, SAFE_MIN_POS)
    return 10.0 * np.log10(arr)

def safe_log10_of_square(a):
    sq = safe_square(a)
    return safe_db_from_square(sq)

def is_diverged(*arrays):
    for arr in arrays:
        if arr is None:
            continue
        a = np.asarray(arr, dtype=float)
        if not np.all(np.isfinite(a)):
            return True
        if np.max(np.abs(a)) >= SAFE_MAX:
            return True
    return False

