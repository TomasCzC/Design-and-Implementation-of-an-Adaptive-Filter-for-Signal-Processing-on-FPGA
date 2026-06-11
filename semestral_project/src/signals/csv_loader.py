import numpy as np

def load_csv_signal(path: str):
    """
    Loads a CSV signal.
    Expected formats:
      - single column: amplitude
      - two columns: time, amplitude
      - three columns: I, Q, (optional time)
    """
    data = np.loadtxt(path, delimiter=",")

    if data.ndim == 1:
        sig = data.astype(float)
        fs = None

    elif data.shape[1] == 2:
        t = data[:, 0]
        sig = data[:, 1]
        dt = np.mean(np.diff(t))
        fs = 1.0 / dt if dt > 0 else None

    elif data.shape[1] >= 3:
        I = data[:, 0]
        Q = data[:, 1]
        sig = I + 1j * Q
        fs = None

    else:
        raise ValueError("Unsupported CSV format")

    return sig, fs
