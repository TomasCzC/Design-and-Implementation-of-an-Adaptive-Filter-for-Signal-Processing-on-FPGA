from dataclasses import dataclass

import numpy as np
from src.filters.filter_runner import run_padasip_filter, enforce_runtime_stability
from src.filters.signal_generation import hist_input
from src.filters.metrics import compute_metrics

@dataclass
class DatasetConfig:
    mode: str                  # "ANC" | "RELATIVE" | "ID"
    reference_type: str         # "sinus" | "delayed" | "none"
    ref_freq: float | None
    ref_amp: float | None
    ref_phase: float | None
    delay: int | None
    segment_start: float | None
    segment_duration: float | None
    smooth_mse: bool

class DatasetController:
    def __init__(self, fs: float):
        self.fs = fs
        self.config = None

    def configure(self, config):
        self._validate_config(config)
        self.config = config

    def _validate_config(self, config):
        if config.mode not in ("ANC", "System ID", "Relative"):
            raise ValueError(f"Unknown dataset mode: {config.mode}")

        if config.mode == "ANC":
            if config.reference_type in (None, "None"):
                raise ValueError("ANC requires a reference signal")

        if config.segment_duration is not None:
            if config.segment_duration < 0:
                raise ValueError("Segment duration must be >= 0")

        if config.delay is not None and config.delay < 0:
            raise ValueError("Delay must be non-negative")

    def prepare(self, x_raw: np.ndarray):
        if self.config is None:
            raise RuntimeError("DatasetController not configured")

        # --------- SEGMENT SELECTION ----------
        x = self._select_segment(x_raw)

        # --------- MODE HANDLING ----------
        if self.config.mode == "System ID":
            return self._system_id(x)

        if self.config.mode == "Relative":
            return self._relative_estimation(x)

        if self.config.mode == "ANC":
            return self._anc(x)

        raise ValueError(f"Unknown dataset mode: {self.config.mode}")

    def _system_id(self, x):
        # System identification: input == desired
        return x, x.copy(), False

    def _relative_estimation(self, x):
        # Relative clean signal estimation
        return x, x.copy(), False

    def _anc(self, x):
        ref = self._build_reference(x)
        return ref, x, True

    def _select_segment(self, x):
        if not self.config.segment_duration:
            return x

        start = int(self.config.segment_start * self.fs)
        length = int(self.config.segment_duration * self.fs)

        end = min(start + length, len(x))
        return x[start:end]

    def _build_reference(self, x):
        N = len(x)
        t = np.arange(N) / self.fs

        if self.config.reference_type == "Sinusoidal":
            return (
                self.config.ref_amp
                * np.sin(
                    2 * np.pi * self.config.ref_freq * t
                    + self.config.ref_phase
                )
            )

        if self.config.reference_type == "Multi":
            ref = np.zeros(N)
            for k in (1, 2, 3):
                ref += np.sin(2 * np.pi * self.config.ref_freq * k * t)
            return ref / (np.max(np.abs(ref)) + 1e-12)

        if self.config.reference_type == "Delayed":
            d = int(self.config.delay)
            if d <= 0 or d >= N:
                raise ValueError("Invalid delay for reference signal")

            ref = np.zeros(N)
            ref[d:] = x[:-d]
            return ref

        raise ValueError(f"Unknown reference type: {self.config.reference_type}")