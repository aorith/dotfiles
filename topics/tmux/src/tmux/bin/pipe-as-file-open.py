#!/usr/bin/env python3

import subprocess
import sys
import tempfile

args = sys.argv[1:]

with tempfile.NamedTemporaryFile() as f:
    while True:
        b = sys.stdin.buffer.read(4096)
        if len(b) == 0:
            break
        f.write(b)
    f.flush()
    sys.exit(subprocess.run(args + [f.name]).returncode)
