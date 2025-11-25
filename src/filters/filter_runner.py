import numpy as np
import padasip as pa
from .safety import clamp_array, is_diverged

def enforce_runtime_stability(alg, params, LIMITS):
    p = params

    # generic mu clamp
    if "mu" in p:
        p["mu"] = float(np.clip(p["mu"], 1e-12, 1.0))

    # NLMS
    if alg == "NLMS":
        lo, hi = LIMITS["NLMS"]["mu"]
        p["mu"] = float(np.clip(p["mu"], lo, min(1.95, hi)))

    # AP
    if alg == "AP":
        order = max(1, int(p.get("order", 3)))
        p["order"] = order
        mu_max = 1.0 / order - 1e-6
        lo, hi = LIMITS["AP"]["mu"]
        p["mu"] = float(np.clip(p["mu"], lo, min(hi, mu_max)))

    # RLS
    if alg == "RLS":
        lo, hi = LIMITS["RLS"]["mu"]
        p["mu"] = float(np.clip(p["mu"], lo, hi))
        lo2, hi2 = LIMITS["RLS"]["eps"]
        p["eps"] = float(np.clip(p["eps"], lo2, hi2))

    return p


def run_padasip_filter(name, d, X, params):
    n = X.shape[1]
    p = params

    if name == "LMS":
        flt = pa.filters.FilterLMS(n, mu=p["mu"])
    elif name == "NLMS":
        flt = pa.filters.FilterNLMS(n, mu=p["mu"], eps=p["eps"])
    elif name == "RLS":
        flt = pa.filters.FilterRLS(n, mu=p["mu"], eps=p["eps"])
    elif name == "AP":
        flt = pa.filters.FilterAP(n, mu=p["mu"], order=p["order"], ifc=p["ifc"])
    elif name == "SSLMS":
        flt = pa.filters.FilterSSLMS(n, mu=p["mu"])
    elif name == "Llncosh":
        flt = pa.filters.FilterLlncosh(n, mu=p["mu"], lambd=p["lambd"])
    elif name == "GMCC":
        flt = pa.filters.FilterGMCC(n, mu=p["mu"], lambd=p["lambd"], alpha=p["alpha"])
    elif name == "GNGD":
        flt = pa.filters.FilterGNGD(n, mu=p["mu"], eps=p["eps"], ro=p["ro"])
    else:
        raise ValueError("Unknown algorithm")

    y, e, w = flt.run(d, X)

    y = clamp_array(y)
    e = clamp_array(e)

    if is_diverged(y, e):
        raise RuntimeError("Adaptive filter diverged")

    return y, e, w
