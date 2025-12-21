PARAMS = {
    "LMS": {
        "mu": 0.01,
    },
    "NLMS": {
        "mu": 0.8,
        "eps": 1e-3,
    },
    "RLS": {
        "mu": 0.99,
        "eps": 0.1,
    },
    "AP": {
        "mu": 0.05,
        "order": 3,
        "ifc": 1e-3,
    },
    "SSLMS": {
        "mu": 0.01,
    },
    "Llncosh": {
        "mu": 0.01,
        "lambd": 0.1,
    },
    "GMCC": {
        "mu": 0.01,
        "lambd": 0.05,
        "alpha": 2.0,
    },
    "GNGD": {
        "mu": 0.01,
        "eps": 0.1,
        "ro": 1e-4,
    },
}

LIMITS = {
    "LMS": {
        "mu": (1e-6, 1.0),
    },
    "NLMS": {
        "mu": (1e-6, 1.999),
        "eps": (1e-9, 1.0),
    },
    "RLS": {
        "mu": (0.90, 1.0),
        "eps": (1e-6, 10.0),
    },
    "AP": {
        "mu": (1e-6, 1.0),
        "order": (1, 64),
        "ifc": (1e-9, 1.0),
    },
    "SSLMS": {
        "mu": (1e-6, 0.2),
    },
    "Llncosh": {
        "mu": (1e-6, 0.5),
        "lambd": (1e-9, 1.0),
    },
    "GMCC": {
        "mu": (1e-6, 0.5),
        "lambd": (1e-9, 1.0),
        "alpha": (0.5, 5.0),
    },
    "GNGD": {
        "mu": (1e-6, 1.0),
        "eps": (1e-9, 1.0),
        "ro": (1e-9, 1.0),
    },
}

PRESETS = {
    "LMS": {
        "Default": {"mu": 0.01},
        "Conservative": {"mu": 0.003},
        "Fast": {"mu": 0.05},
    },
    "NLMS": {
        "Default": {"mu": 0.8, "eps": 1e-3},
        "Aggressive": {"mu": 1.5, "eps": 1e-3},
        "Robust": {"mu": 0.6, "eps": 1e-2},
    },
    "RLS": {
        "Default": {"mu": 0.99, "eps": 0.1},
        "Quick": {"mu": 0.995, "eps": 0.1},
        "VeryQuick": {"mu": 0.998, "eps": 0.1},
    },
    "AP": {
        "Default": {"mu": 0.05, "order": 3, "ifc": 1e-3},
        "Wideband": {"mu": 0.08, "order": 2, "ifc": 1e-3},
        "Narrowband": {"mu": 0.02, "order": 8, "ifc": 1e-3},
    },
    "SSLMS": {
        "Default": {"mu": 0.01},
        "Robust": {"mu": 0.005},
    },
    "Llncosh": {
        "Default": {"mu": 0.01, "lambd": 0.1},
    },
    "GMCC": {
        "Default": {"mu": 0.01, "lambd": 0.05, "alpha": 2.0},
    },
    "GNGD": {
        "Default": {"mu": 0.01, "eps": 0.1, "ro": 1e-4},
    },
}
