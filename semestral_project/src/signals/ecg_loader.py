import wfdb
import numpy as np

def load_ecg(hea_path):
    record = wfdb.rdrecord(hea_path.replace(".hea", ""))
    x = record.p_signal[:, 0].astype(float)
    fs = float(record.fs)
    return x, fs
