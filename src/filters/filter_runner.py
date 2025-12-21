import padasip as pa
import numpy as np


def enforce_runtime_stability(alg, params, limits):
    p = params.copy()

    if "mu" in p:
        lo, hi = limits[alg]["mu"]
        p["mu"] = float(np.clip(p["mu"], lo, hi))

    if alg == "NLMS":
        p["mu"] = min(p["mu"], 1.95)

    if alg == "AP":
        order = int(p.get("order", 3))
        p["order"] = max(1, order)
        p["mu"] = min(p["mu"], 1.0 / p["order"] - 1e-6)

    return p


def run_padasip_filter(name, d, X, params):
    n = X.shape[1]

    if name == "LMS":
        flt = pa.filters.FilterLMS(n, **params)
    elif name == "NLMS":
        flt = pa.filters.FilterNLMS(n, **params)
    elif name == "RLS":
        flt = pa.filters.FilterRLS(n, **params)
    elif name == "AP":
        flt = pa.filters.FilterAP(n, **params)
    elif name == "SSLMS":
        flt = pa.filters.FilterSSLMS(n, **params)
    elif name == "Llncosh":
        flt = pa.filters.FilterLlncosh(n, **params)
    elif name == "GMCC":
        flt = pa.filters.FilterGMCC(n, **params)
    elif name == "GNGD":
        flt = pa.filters.FilterGNGD(n, **params)
    else:
        raise ValueError(f"Unknown algorithm: {name}")

    y, e, w = flt.run(d, X)
    return y, e, w
