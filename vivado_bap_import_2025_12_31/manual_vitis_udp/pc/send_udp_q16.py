import socket
import struct
import numpy as np

FPGA_IP = "192.168.1.50"
FPGA_PORT = 50000
PC_PORT = 50001

SCALE = 1 << 16
BLOCK = 64
N = 128

n = np.arange(N)
d = 0.7 * np.sin(2 * np.pi * 0.03 * n)
x = d + 0.15 * np.sin(2 * np.pi * 0.23 * n)

x_q16 = np.round(x * SCALE).astype(np.int32)
d_q16 = np.round(d * SCALE).astype(np.int32)

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.bind(("0.0.0.0", PC_PORT))
sock.settimeout(2.0)

for seq, start in enumerate(range(0, N, BLOCK)):
    xb = x_q16[start:start + BLOCK]
    db = d_q16[start:start + BLOCK]

    payload = bytearray()
    payload += b"FPGA"
    payload += struct.pack(">I", seq)
    payload += struct.pack(">H", len(xb))
    payload += struct.pack(">H", 1)

    for xv, dv in zip(xb, db):
        payload += struct.pack(">i", int(xv))
        payload += struct.pack(">i", int(dv))

    sock.sendto(payload, (FPGA_IP, FPGA_PORT))
    print(f"TX seq={seq}, samples={len(xb)}, bytes={len(payload)}")

    try:
        data, addr = sock.recvfrom(4096)

        magic = data[0:4]
        rx_seq = struct.unpack(">I", data[4:8])[0]
        count = struct.unpack(">H", data[8:10])[0]

        print(f"RX from {addr}, magic={magic}, seq={rx_seq}, count={count}, bytes={len(data)}")

        off = 12
        y = []
        e = []

        for _ in range(count):
            y_q16 = struct.unpack(">i", data[off:off + 4])[0]
            off += 4
            e_q16 = struct.unpack(">i", data[off:off + 4])[0]
            off += 4

            y.append(y_q16 / SCALE)
            e.append(e_q16 / SCALE)

        print("First y/e:", y[:3], e[:3])

    except socket.timeout:
        print("No UDP response")
