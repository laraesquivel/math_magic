from pathlib import Path
import os


def transform(a,b):
    x = (b*(-10)/36) + (20*a)/84
    print(x)
    return x

transform(420,0)