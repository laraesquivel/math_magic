import re
import sympy
import collections

text = "2x +sin0.98 + |-45"

class RegCorrection:
    def __init__(self,expressao):
        self.expressao = expressao
        self.PARENTESES_EXPRESSION =  r'(sin|cos|tg|log|ln)([a-zA-Z\d.]+)'
        self.PADRAO_ASTERISCO = r'(\d)([a-zA-Z])'
        #self.PADRAO_TRIGO = r'(sin|cos|tg)([\d.]+)'

    def adicionar_parenteses(self):
        #padrao = r'(sin|cos|tg|log|ln)([a-zA-Z\d]+)(?=\s)'
        resultado = re.sub(self.PARENTESES_EXPRESSION, r'\1(\2)', self.expressao)
        self.expressao = resultado

    def adicionar_asterisco(self):
        nova_expressao = re.sub(self.PADRAO_ASTERISCO, r'\1*\2', self.expressao)
        nova_expressao = re.sub(r'(\d)\s*-\s*', r'\1 - ', nova_expressao)
        self.expressao = nova_expressao
    
    def detectar_variavel(self):
        expression_without_digits = re.sub(r'\d', '', self.expressao)
        letters_only = re.findall(r'\b[a-zA-Z]\b', expression_without_digits)
        frequency = collections.Counter(letters_only)
        if len(frequency.most_common(1)) != 0:
            most_common_char = frequency.most_common(1)[0]
            most_common_char, count = most_common_char
            return most_common_char
        return None
    
    def anti_constante(self):
        padrao = r"^[a-zA-Z]+$"
        if re.match(padrao,self.expressao):
            return True
        else: 
            return False
    
    def separar_modulo(self,expressao):
        padrao = r"([+\-*/])?\s*\|([^|]+)\|"
        correspondencias = re.findall(padrao, expressao)
        return correspondencias

class Math_Analys:
    def __init__(self,expressao,x='x',dominio=(-3,3)):
        self.expressao = expressao
        self.dominio = dominio
        self.variavel_em_funcao = x

    def get_points(self):
        x = sympy.symbols(self.variavel_em_funcao)
        expression = sympy.parse_expr(self.expressao)
        x_values = list(range(self.dominio[0], self.dominio[1]+ 1, 1))
        y_values = [expression.subs(x, float(x_val)) for x_val in x_values]

       #points = []
        points = ''
        for x_val, y_val in zip(x_values, y_values):
           # print(f'x = {x_val}, y = {y_val}')
            #points.append({'x_val':x_val,'y_val':y_val})
            points = f'{points}{x_val}/{y_val},'
        return points
    



