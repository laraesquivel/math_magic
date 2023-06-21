from flask import Flask, request, make_response, jsonify
from urllib.parse import quote, unquote
import math_analysis
import os
from pathlib import Path
from utils import write_file,check_results

caminho_atual = Path().resolve()

# Caminho absoluto para a segunda pasta
SHARE_PATH = caminho_atual.parent.parent / "math_magic"


app = Flask(__name__)

@app.route("/")
def home():
    return "Math Magic Godot 3.5"

@app.route("/getPoints",methods=['GET','POST'])
def getPoints():
   data = request.get_json()
   expression = data['expression']
   dominio_min = data['dominio_min']
   dominio_max = data['dominio_max']

   dominio = (dominio_min,dominio_max)

   regex = math_analysis.RegCorrection(expression)
   regex.adicionar_parenteses()
   regex.adicionar_asterisco()
   anti_c = regex.anti_constante()
   if anti_c:
       response={"status":500,"result":None}
       return make_response(jsonify(response))
   #regex.detectar_funcao_modular()
   x = regex.detectar_variavel()
   if x is None:
       x="x"
   print(x)
   print(regex.expressao)

   math_ana = math_analysis.Math_Analys(regex.expressao,x,dominio)
   result = math_ana.get_points()
   response = {"result":result}
   #write_file(response,str(SHARE_PATH))
   return make_response(jsonify(response))



@app.route("/getPoints2/<expression>/<dominio_max>/<dominio_min>",methods=['GET'])
def getPoints2(expression,dominio_max,dominio_min):
    try:
        print(f'{expression},{dominio_max},{dominio_min}')
        dominio = (int(dominio_min),int(dominio_max))

        regex = math_analysis.RegCorrection(expression)
        regex.adicionar_parenteses()
        regex.adicionar_asterisco()
        '''
        anti_c = regex.anti_constante()
        print("Ok")
        if anti_c:
            response={"status":500,"result":None,"anti":True}
            return '',500 '''
        #regex.detectar_funcao_modular()
        x = regex.detectar_variavel()
        print("ok2")
        if x is None:
            x="x"
        #print(x)
        #print(regex.expressao)

        math_ana = math_analysis.Math_Analys(regex.expressao,x,dominio)
        result = math_ana.get_points()
        print("ok pre bool")
        boolean_check = check_results(result)
        if boolean_check:
            print("ok3")
            #write_file(response,str(SHARE_PATH))
            print(result)
            return make_response(result,200)
        else:
            return '',500
    except:
        print("ok4")
        response={"status":500,"result":None}
        return '',500
