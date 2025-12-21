from dataclasses import dataclass
from typing import Optional

@dataclass
class SignalMeta:
    def __init__(
        self,
        signal_type,
        fs=None,
        time_unit="s",
        amplitude_unit="a.u.",
        is_complex=False,
        modulation=None,
        snr_db=None,
        dataset=None
    ):
        self.signal_type = signal_type      # "synthetic" | "ecg" | "radio"
        self.fs = fs
        self.time_unit = time_unit
        self.amplitude_unit = amplitude_unit
        self.is_complex = is_complex
        self.modulation = modulation
        self.snr_db = snr_db
        self.dataset = dataset

def synthetic_meta(fs: float, duration: float):
    return SignalMeta(
        signal_type="synthetic",
        fs=fs,
        # duration=duration,#
        time_unit="s",
        amplitude_unit="a.u.",
        is_complex=False
    )

def ecg_meta(fs: float):
    return SignalMeta(
        signal_type="ecg",
        fs=fs,
        time_unit="s",
        amplitude_unit="mV",
        is_complex=False
    )

def radio_meta(fs: float, modulation: str, snr_db: float, is_complex=True):
    return SignalMeta(
        signal_type="radio",
        fs=fs,
        time_unit="s",
        amplitude_unit="a.u.",
        is_complex=is_complex,
        modulation=modulation,
        snr_db=snr_db
    )
