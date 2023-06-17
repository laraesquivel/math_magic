from flask import Flask, request, make_response, jsonify
from urllib.parse import quote, unquote
import math_analysis
import os
from pathlib import Path
from utils import write_file

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
   print(f'{expression},{dominio_max},{dominio_min}')
   dominio = (int(dominio_min),int(dominio_max))

   regex = math_analysis.RegCorrection(expression)
   regex.adicionar_parenteses()
   regex.adicionar_asterisco()
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
   return str(response)
