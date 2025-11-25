PARAMS = {
    "LMS":     dict(mu=0.01),
    "NLMS":    dict(mu=0.8,  eps=1e-3),
    "RLS":     dict(mu=0.99, eps=0.1),
    "AP":      dict(mu=0.05, order=3, ifc=1e-3),
    "SSLMS":   dict(mu=0.01),
    "Llncosh": dict(mu=0.01, lambd=0.1),
    "GMCC":    dict(mu=0.01, lambd=0.05, alpha=2.0),
    "GNGD":    dict(mu=0.01, eps=0.1, ro=1e-4),
}

LIMITS = {
    "LMS":     {"mu": (1e-6, 1.0)},
    "NLMS":    {"mu": (1e-6, 1.999), "eps": (1e-9, 1.0)},
    "RLS":     {"mu": (0.90, 1.0),   "eps": (1e-6, 10.0)},
    "AP":      {"mu": (1e-6, 1.0),   "order": (1, 64), "ifc": (1e-9, 1.0)},
    "SSLMS":   {"mu": (1e-6, 0.2)},
    "Llncosh": {"mu": (1e-6, 0.5),   "lambd": (1e-9, 1.0)},
    "GMCC":    {"mu": (1e-6, 0.5),   "lambd": (1e-9, 1.0), "alpha": (0.5, 5.0)},
    "GNGD":    {"mu": (1e-6, 1.0),   "eps": (1e-9, 1.0), "ro": (1e-9, 1.0)},
}

PRESETS = {
    "LMS": {
        "Default":   dict(mu=0.01),
        "Conservative": dict(mu=0.003),
        "Fast":      dict(mu=0.05),
    },
    "NLMS": {
        "Default":   dict(mu=0.8, eps=1e-3),
        "Aggressive":dict(mu=1.5, eps=1e-3),
        "Robust":    dict(mu=0.6, eps=1e-2),
        "ANC Quick": dict(mu=1.2, eps=1e-3),
    },
    "RLS": {
        "Default":   dict(mu=0.99, eps=0.1),
        "Quick":     dict(mu=0.995, eps=0.1),
        "Very Quick":dict(mu=0.998, eps=0.1),
        "Noisy":     dict(mu=0.98, eps=1.0),
    },
    "AP": {
        "Default":   dict(mu=0.05, order=3, ifc=1e-3),
        "Narrowband":dict(mu=0.02, order=8, ifc=1e-3),
        "Wideband":  dict(mu=0.08, order=2, ifc=1e-3),
    },
    "SSLMS": {
        "Default":   dict(mu=0.01),
        "Robust":    dict(mu=0.005),
        "Fast":      dict(mu=0.05),
    },
    "Llncosh": {
        "Default":   dict(mu=0.01, lambd=0.1),
        "Sharper":   dict(mu=0.02, lambd=0.2),
        "Softer":    dict(mu=0.005, lambd=0.05),
    },
    "GMCC": {
        "Default":   dict(mu=0.01, lambd=0.05, alpha=2.0),
        "Aggressive":dict(mu=0.03, lambd=0.1, alpha=2.0),
        "Robust":    dict(mu=0.008, lambd=0.08, alpha=3.0),
    },
    "GNGD": {
        "Default":   dict(mu=0.01, eps=0.1, ro=1e-4),
        "Adaptive":  dict(mu=0.05, eps=0.05, ro=5e-4),
        "Robust":    dict(mu=0.008, eps=0.2, ro=1e-4),
    },
}
