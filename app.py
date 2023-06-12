from flask import Flask, request, make_response, jsonify
from urllib.parse import quote, unquote
import math_analysis


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
   regex.detectar_funcao_modular()
   x = regex.detectar_variavel()
   if x is None:
       x="x"
   print(x)
   print(regex.expressao)

   math_ana = math_analysis.Math_Analys(regex.expressao,x,dominio)
   result = math_ana.get_points()
   return make_response(jsonify({"result":result}),200)


