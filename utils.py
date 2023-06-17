import pandas as pd

dados_json = {
    "chave1": "valor1",
    "chave2": "valor2",
    "chave3": "valor3"
}

def write_file(response,share_path=None):
    df = pd.DataFrame.from_dict(response,orient="index").T
    print(df.head())
    share_path = f'{share_path}/pontos.csv'
    #df.to_json(share_path)
    df.to_csv(share_path, index_label='chave', header=['valor'])

