#coding=utf-8

# Código fonte do projeto AP2 (2018), desenvolvido no âmbito da UC de Laboratórios de Informática
# Projeto: http://code.ua.pt/projects/labi2018-ap2-g3

# Grupo #3
# NMEC: 88802  NOME: Rodrigo Rosmaninho  TURMA: P5
# NMEC: 72783  NOME: Eurico Dias         TURMA: P5

from datetime import datetime
import csv, socket, json, sys, time
import net, colors, security

tcp_s = None

warn_temp = False
warn_humid = False
warn_wind = False

time_warntemp = 0
time_warnhumid = 0
time_warnwind = 0

#########################################################################################################################

# Função isValidJSON : Aceita uma string e verifica se esta é JSON válido
def isValidJSON(json_data):
    try:
        json.loads(json_data)
        return True
    except:
        return False

#########################################################################################################################

# Função readJSON : Aceita uma string em JSON e devolve um dicionário
def readJSON(json_data):
    if isValidJSON(json_data):
        return json.loads(json_data)
    else:
        print(colors.fail("Os dados enviados pelo servidor não constituem um objeto JSON válido!"))

#########################################################################################################################    

# Função hasError : Deteta se o objeto JSON enviado pelo servidor é uma mensagem de erro
def hasError(data):
    return ("type" in data and data['type'] == "ERROR") or "ERROR" in json.dumps(data)

#########################################################################################################################

# Função handleFatalError : Avisa o utilizador do erro e reinicia a lógica do programa
def handleFatalError():
    print(colors.fail("Ocorreu um erro fatal na troca de parametros criptográficos com o servidor.\nOs dados enviados pelo servidor estavam corrompidos.\nO programa irá reiniciar automaticamente.\n"))
    time.sleep(1)
    main()
    sys.exit(2)

#########################################################################################################################

# Escerve informação para o terminal das condições meteorlógicas e recomenda adereços/roupa apropriada
def getInfo(temp, hum, wind):
    global warn_temp, warn_humid, warn_wind
    global time_warntemp, time_warnhumid, time_warnwind

    if time.time() - time_warntemp > 300:  # 5 minutos
        warn_temp = False
    if time.time() - time_warnhumid > 300:
        warn_humid = False
    if time.time() - time_warnwind > 300:
        warn_humid = False


    if warn_temp is False:
        
        warn_temp = True
        time_warntemp = time.time()

        if temp > 35:
            print(colors.fail("Temperatura extremamente alta. Por favor, leve roupa fresca, hidrate-se e abrigue-se do sol."))
        elif temp > 27:
            print(colors.warn("Temperatura elevada. Recomanda-se uma t-shirt e colocar protetor solar."))
        elif temp > 22:
            print(colors.okblue("Temperatura algo elevada. Leve roupa mais fresca."))
        elif temp > 16:
            print(colors.okgreen("Temperatura amena! Leve roupa de acordo com a sua sensação da temperatura."))
        elif temp > 2:
            print(colors.warning("Temperatura baixa. Por favor, leve roupa mais quente."))
        else:
            print(colors.fail("Temperatura extremamente baixa. Use gorro e bastantes peças de roupa."))
    if warn_humid is False:
        if hum >= 80:
            warn_humid = True
            time_warnhumid = time.time()
            
            print(colors.warning("Probabilidade elevada de aguaceiros (humidade). Não se esqueça do guarda-chuva."))
            
    if warn_wind is False:
        
        warn_wind = True
        time_warnwind = time.time()

        if wind >= 70:
            print(colors.fail("Vento muito forte. Considere abrigar-se das rajadas. Se sair, leve casasco."))
        elif wind >= 25:
            print(colors.warning("Vento forte. Considere vestir um casaco antes de sair de casa."))
        elif wind >= 10:
            print("Brisa aveirense. Leve uma camisola ou um casaco, apenas se não estiver calor.")
        else:
            print(colors.okgreen("Vento dentro do normal!"))

#########################################################################################################################

# Função initialExchange : Envia "CONNECT <valor_inicial>" para o server e devolve token e B
def initialExchange(initial_value):
    net.tcpSend("CONNECT " + initial_value, False)
    data = net.tcpRead()
    
    if not isValidJSON(data):
        handleFatalError()
        	
    data = readJSON(data)

    if hasError(data):
        # Fazer print do erro enviado pelo server e reiniciar o programa
        print(colors.fail(data['type'] + ": " + data['content']))
        main()
        sys.exit(3)
    
    return (data['TOKEN'], data['B'])

#########################################################################################################################

# Função main : Lógica principal
def main():
    global tcp_s

    server_addr = ("xcoa.av.it.pt", 8080)
    tcp_s = net.tcpConnect(server_addr)

    values = security.DHInitialValues()
    initial_value = str(values).strip('()').replace(" ", "") # transformar (A, p, g) para string válida "A,p,g"

    # Tentar efetuar a troca de parametros inicial
    # Se a resposta do servidor estiver corrompida durante esta fase inicial então não será possivel continuar a comunicação,
    # Visto que o servidor estará à espera da mensagem READ encriptada mas o cliente não saberá calcular a chave do AES devido a ter recebido o parametro B de forma corrompida
    try:
        token, B = initialExchange(initial_value)
        secret = security.DHGetSecret(values[1], B)

        # Enviar "READ <token>" ao server
        net.tcpSend(security.encrypt(secret, "READ " + str(token)), True)
    
    except KeyboardInterrupt:
        tcp_s.close()
        sys.exit(0)
    except:
        handleFatalError()


    wrote_header = False
    started_receiving = False
    
    # Receber e tratar das respostas do server indefinitivamente
    while 1:
        data = net.tcpRead()
        
        if isValidJSON(data):
            # Se for JSON válido então os dados enviados não foram encriptados. Logo, deve ser uma mensagem de erro
            data = readJSON(data)
        else:
            # Se não for JSON válido então os dados devem estar encriptados, como se estava à espera
            try:
                data = readJSON(security.decrypt(secret, data))
            
            except KeyboardInterrupt:
                tcp_s.close()
                sys.exit(0)
            except:
                print(colors.warning("DECODE ERROR : A última mensagem do servidor estava corrompida."))
                # Se ainda não tinha sido recebida a mensagem {type : 'OK'}, executar a lógica de erro fatal
                if not started_receiving:
                    handleFatalError()
                else:
                    continue

    
        if ("type" in data.keys()) and (data['type'] == "OK"):
            # Foi recebida mensagem "{type : 'OK'}"
            started_receiving = True
            print(colors.okgreen("Conexão ao servidor bem sucedida!\n") + "Serão recolhidos novos valores a cada "  + colors.bold("10 segundos") + ".\nEstes serão registados em " + colors.bold("data.csv"))
            file = open("data.csv", "w+")
            print("\n" + colors.bold(" Temperatura") + " |  " + colors.bold("Humidade") + "  |   " + colors.bold("Vento"))
            print("-------------|------------|-----------")
                
        elif hasError(data):
            # Fazer print à mensagem de erro vinda do servidor
            try:
                print(colors.fail(data['type'] + ": " + data['content']))
            except KeyboardInterrupt:
                tcp_s.close()
                sys.exit(0)
            except ValueError:
                print(colors.warning("ERROR: A última mensagem do servidor era um erro mas pelo menos uma key estava corrompida."))

        else:
            try: 
                temp = data['TEMPERATURE']
                hum = data['HUMIDITY']
                wind = data['WIND']
            except KeyboardInterrupt:
                tcp_s.close()
                sys.exit(0)
             
            except ValueError:
                print(colors.warning("ERROR: A última mensagem do servidor não continha os valores esperados."))
                continue

            print((colors.okblue("   %8.5f  ") + "|" + colors.okblue("  %8.5f  ") + "|" + colors.okblue("  %8.5f")) % (temp, hum, wind))

            getInfo(temp, hum, wind)
            
            if not wrote_header:
                fields = [key for key in data.keys()]
                fields.insert(0, 'TIME')

                fw = csv.DictWriter(file, fieldnames=fields)
                
                fw.writeheader()
                wrote_header = True
                
            data.update({'TIME' : datetime.now()})
                
            fw.writerow(data)
            file.flush() # escreve as alterações feitas no buffer

    tcp_s.close()

#########################################################################################################################

# Impedir que unit tests corram esta linha
if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
       tcp_s.close()
       sys.exit(0) 