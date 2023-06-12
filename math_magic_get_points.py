import sympy
import re
from math_analysis import RegCorrection

exp = "|-2*a|"
a = RegCorrection(exp)


dominio = (-3,3)

x = sympy.symbols('a')


padrao = r"\|.*\|"
correspondencias = re.findall(padrao, exp)
print(correspondencias)

