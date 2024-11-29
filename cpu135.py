import random
import os
import subprocess
import requests

# Caminhos dos arquivos
sequencia_file_path = '6_135.txt'  # Arquivo com as sequências
output_sh_path = '6_135.sh'        # Arquivo .sh a ser gerado
historico_path = 'historico.txt'  # Arquivo de histórico
out_file_path = 'KEYFOUNDKEYFOUND.txt'      # Arquivo onde a chave privada será salva

# Telegram API Configurações
telegram_bot_token = "7895014105:AAGdTXhxMq-TxpoYNfwSuLDeS4ifDyHdlGk"
telegram_chat_id = "5645463254"

# Função para gerar um range completo
def gerar_range(sequencia):
    range_inicial = f"{sequencia}000000000000000000000000000000"
    range_final = f"{sequencia}ffffffffffffffffffffffffffffff"
    return f"{range_inicial}:{range_final}"

# Função para enviar mensagem ao Telegram
def enviar_telegram(mensagem, arquivo=None):
    url = f"https://api.telegram.org/bot{telegram_bot_token}/sendMessage"
    data = {"chat_id": telegram_chat_id, "text": mensagem}

    # Enviar mensagem com arquivo (opcional)
    if arquivo and os.path.exists(arquivo):
        url = f"https://api.telegram.org/bot{telegram_bot_token}/sendDocument"
        with open(arquivo, 'rb') as file:
            files = {'document': file}
            response = requests.post(url, data=data, files=files)
    else:
        response = requests.post(url, data=data)

    if response.status_code == 200:
        print("Mensagem enviada ao Telegram com sucesso.")
    else:
        print("Falha ao enviar mensagem ao Telegram:", response.text)

# Número fixo de sequências a serem utilizadas
quantidade_linhas = 1

# Ler o arquivo de sequências
with open(sequencia_file_path, 'r') as f:
    linhas = [linha.strip() for linha in f.readlines()]

# Verificar se há sequências suficientes
if quantidade_linhas > len(linhas):
    print("Erro: O arquivo 6_135.txt não possui sequências suficientes.")
    exit()

# Selecionar 10 sequências de forma randômica
sequencias_escolhidas = random.sample(linhas, quantidade_linhas)

# Abrir arquivos para escrita
with open(output_sh_path, 'w') as sh_file, open(historico_path, 'a') as historico_file:
    # Adicionar cabeçalho ao arquivo .sh
    sh_file.write("#!/bin/bash\n\n")
    sh_file.write("# Configurar manipulador de sinal para Ctrl+C\n")
    sh_file.write("trap 'echo \"Encerrando processos...\"; pkill -f keyhunt; exit 0' SIGINT\n\n")
    sh_file.write("cd $(dirname \"$0\")\n\n")
    sh_file.write("echo \"Iniciando script 6_135.sh com proteção para Ctrl+C.\"\n\n")

    # Gerar comandos para cada sequência escolhida
    for i, sequencia in enumerate(sequencias_escolhidas, start=1):
        range_completo = gerar_range(sequencia)

        # Adicionar o range ao histórico
        historico_file.write(f"{range_completo}\n")

        # Gerar comandos no formato especificado
        sh_file.write(f"echo 'Iniciando processo {i} com range {range_completo}'\n")
        sh_file.write(f"timeout 900s ./keyhunt -m bsgs -f tests/135.txt -n 0x100000000000 -R -s 10 -k 1568 -t 24 -6 l compress -e -S {out_file_path} -r {range_completo} \n")
        sh_file.write("sleep 900\n")
        sh_file.write("pkill -f keyhunt\n\n")
        
        # Adicionar verificação do arquivo de saída
        sh_file.write(f"if [ -s {out_file_path} ]; then\n")
        sh_file.write(f"    echo 'Chave privada encontrada! Enviando notificação para Telegram.'\n")
        sh_file.write(f"    python3 -c \"import requests; requests.post('https://api.telegram.org/bot{telegram_bot_token}/sendDocument', data={{'chat_id': '{telegram_chat_id}'}}, files={{'document': open('{out_file_path}', 'rb')}})\"\n")
        sh_file.write(f"    mv {out_file_path} {out_file_path}.backup\n")  # Backup da saída
        sh_file.write("fi\n\n")

    # Reiniciar o ciclo chamando cpu135.py
    sh_file.write("echo 'Reiniciando o processo executando cpu135.py.'\n")
    sh_file.write("python3 cpu135.py\n")

# Atualizar arquivo de sequências
sequencias_restantes = [linha for linha in linhas if linha not in sequencias_escolhidas]
with open(sequencia_file_path, 'w') as f:
    f.writelines(f"{linha}\n" for linha in sequencias_restantes)

print(f"Arquivo .sh gerado em: {output_sh_path}")
print(f"Histórico atualizado em: {historico_path}")
print(f"Sequências restantes salvas em: {sequencia_file_path}")

# Tornar o arquivo .sh executável
os.chmod(output_sh_path, 0o775)

# Executar o arquivo .sh automaticamente
try:
    print(f"Executando {output_sh_path} automaticamente...")
    subprocess.run([f"./{output_sh_path}"], check=True)
except KeyboardInterrupt:
    print("\nExecução interrompida pelo usuário.")
except subprocess.CalledProcessError as e:
    print(f"\nErro ao executar o script: {e}")
