# src/signals/radio_loader.py

import h5py
import numpy as np


def load_radio_hdf5(
    path,
    class_id=None,
    index=0,
    fs=1.0,
):
    """
    Load ONE IQ signal from DeepSig / RML HDF5 dataset.

    Parameters
    ----------
    path : str
        Path to .hdf5 file
    class_id : int or None
        Class index (0..N-1). If None, take first sample.
    index : int
        Index inside selected class
    fs : float
        Sampling frequency (arbitrary, dataset-dependent)

    Returns
    -------
    x : np.ndarray (complex64)
        IQ signal, shape (1024,)
    fs : float
        Sampling frequency
    """

    with h5py.File(path, "r") as f:
        X = f["X"]
        Y = f["Y"]

        # sanity check
        if X.ndim != 3 or X.shape[2] != 2:
            raise ValueError("Unexpected X shape in radio dataset")

        # select sample index
        if class_id is None:
            sample_idx = 0
        else:
            # Y is one-hot → find rows where this class is active
            cls_mask = Y[:, class_id] == 1
            indices = np.where(cls_mask)[0]

            if len(indices) == 0:
                raise ValueError(f"No samples for class {class_id}")

            if index >= len(indices):
                raise IndexError("Sample index out of range")

            sample_idx = indices[index]

        # load only ONE sample
        iq = X[sample_idx]              # (1024, 2)
        i = iq[:, 0]
        q = iq[:, 1]

        x = i + 1j * q

    return x.astype(np.complex64), fs
