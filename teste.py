from pathlib import Path
import os


caminho_atual = Path().resolve()

# Caminho absoluto para a segunda pasta
caminho_segunda_pasta = caminho_atual.parent.parent / "math_magic" 

# Caminho absoluto para o arquivo dentro da segunda pasta
caminho_arquivo = caminho_segunda_pasta

print(caminho_arquivo)

def listar_arquivos(pasta):
    for nome_arquivo in os.listdir(pasta):
        caminho_arquivo = os.path.join(pasta, nome_arquivo)
        if os.path.isfile(caminho_arquivo):
            print(nome_arquivo)

listar_arquivos(caminho_arquivo)