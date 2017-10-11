#! /usr/bin/env python
import os
import sys
from pprint import pprint

if len(sys.argv) < 2:
    print "Please specify the times file"
    sys.exit(1)

times_file=sys.argv[1]

with open(os.path.join(times_file), "r") as f:
    lines = f.read().splitlines()

results = []
prev = 0
for line in lines:
    key, val = line.split(": ")
    m, s = divmod((int(val) - prev), 60)
    results.append("{}: {}m{}s".format(key, m, s))
    prev = int(val)
    total = prev

pprint(results)
m, s = divmod(prev, 60)
h, m = divmod(m, 60)
print("TOTAL: {}h{}m{}s".format(h, m, s))
