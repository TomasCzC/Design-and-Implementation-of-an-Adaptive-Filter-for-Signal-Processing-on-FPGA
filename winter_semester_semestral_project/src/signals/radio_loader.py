import h5py
import numpy as np


def load_radio_hdf5(
    path,
    class_id=None,
    index=0,
    fs=1.0,
):

    with h5py.File(path, "r") as f:
        X = f["X"]
        Y = f["Y"]

        if X.ndim != 3 or X.shape[2] != 2:
            raise ValueError("Unexpected X shape in radio dataset")

        if class_id is None:
            sample_idx = 0
        else:
            cls_mask = Y[:, class_id] == 1
            indices = np.where(cls_mask)[0]

            if len(indices) == 0:
                raise ValueError(f"No samples for class {class_id}")

            if index >= len(indices):
                raise IndexError("Sample index out of range")

            sample_idx = indices[index]

        iq = X[sample_idx]
        i = iq[:, 0]
        q = iq[:, 1]

        x = np.sqrt(i * i + q * q)

    return x.astype(np.float32), fs
