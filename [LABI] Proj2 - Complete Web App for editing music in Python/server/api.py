#coding=utf-8

# Código fonte do projeto P2 (2018), desenvolvido no âmbito da UC de Laboratórios de Informática
# Projeto: http://code.ua.pt/projects/labi2018-p2-g1

# Grupo #1
# NMEC: 88802  NOME: Rodrigo Rosmaninho  TURMA: P5
# NMEC: 72783  NOME: Eurico Dias         TURMA: P5
# NMEC: 89140  NOME: João Trindade       TURMA: P5
# NMEC: 88734  NOME: Pedro Valério       TURMA: P5

import db, Sound, genImage
from Crypto.Hash import MD5
import sys, os, cherrypy, json, subprocess
import marshal, wave
from PIL import Image
from cherrypy.lib.static import serve_file, serve_fileobj
from io import BytesIO

cherrypy.config.update({'server.socket_port': 10001,})
PATH = os.path.abspath(os.path.dirname("../..")) # raiz do repositório

admins = "[\"equipa\", \"r.rosmaninho\", \"dias.eurico\", \"pedrovalerio\", \"jatt\"]"

# Configurações para servir todos os ficheiros estáticos na pasta 'web' (html, css, js, imagens, etc...)
conf = {
  "/web":   { 
        "tools.staticdir.on": True,
        "tools.staticdir.dir": os.path.join(PATH, "web") 
    }
}

#######################################
# /list?type=songs -> Quando invocado, devolve um objeto JSON com a lista de todas as músicas já criadas.
# /list?type=samples -> Quando invocado, devolve um objeto JSON com a lista de todos os excertos existentes.

class List(object):
    @cherrypy.expose
    def index(self, type, order=None, asc_desc=1):
        user = "r.rosmaninho"
        

        # Lista de músicas
        if type == "songs":
            #return open("../web/js/example_song_list.json").read()
            return db.getSongsOrdered(order, asc_desc)

        # Lista de samples
        elif type == "samples":
            #return open("../web/js/example_sample_list.json").read()
            return db.getSamplesOrdered(order, asc_desc)
            #return db.getSamples()

        elif type == "effects":
            return db.getEffects()

        # Lista de votos para cada utilizador
        elif type == "votes":
            #return open("../web/js/example_votes_list.json").read()
            return db.getVotesUser(user)

######################################
# /get?id=identificador -> Permite obter um excerto ou uma música com base num identificador fornecido

class Get(object):
    @cherrypy.expose
    def index(self, id):
        return serve_file(os.path.join(PATH, id), "application/x-download", "attachment")

######################################
# /getImage?id=identificador -> Permite obter uma imagem da pauta com base num identificador fornecido

class GetImage(object):
    @cherrypy.expose
    def index(self, id):
        image = genImage.makeScore(id)
        buffer = BytesIO()
        image.save(buffer, "png")
        buffer.seek(0)
        return serve_fileobj(buffer, "application/x-download", "attachment", name="pauta.png")
        # Baseado em parte em https://stackoverflow.com/questions/33916409/python-pil-save-image-in-memory-and-upload?rq=1

######################################
# /getKarma?user=email -> Permite obter o karma de um utilizador

class GetKarma(object):
    @cherrypy.expose
    def index(self, user):
        bodge = db.getUserNumVotes(user)
        print("DEBUG2: " + str(bodge))
        return json.dumps(bodge)

######################################
# /avatar?id=identificador -> Permite obter um excerto ou uma música com base num identificador fornecido

class Avatar(object):
    @cherrypy.expose
    def index(self, id):
        var = str(db.getAvatar(id)['avatar'])
        return serve_file(os.path.join(PATH, var), "application/x-download", "attachment")

######################################
# /Admins -> Devolve a lista de utilizadores admins

class Admins(object):
    @cherrypy.expose
    def index(self):
        return admins

######################################
# /report?id=id_da_song/sample -> Reporta song ou sample

class Report(object):
    @cherrypy.expose
    def index(self, id):
        user = "r.rosmaninho"
        
        return db.setReport(user, id)

######################################
# /put -> Permite enviar a pauta de uma nova música para que esta seja criada. (Método POST)

class Put(object):
    @cherrypy.expose
    def index(self):
        user = "r.rosmaninho"
        
        cl = cherrypy.request.headers['Content-Length']
        rawbody = cherrypy.request.body.read(int(cl))
        pauta = json.loads(rawbody)

        prune = Prune()
        pauta=prune.prune_songgen(pauta)

        for samp in pauta["samples"]:
            db.setUses(samp)

        # Robustez
        bpm_final = int(pauta["bpm"])
        if bpm_final < 60 or bpm_final > 350:
            bpm_final = 120

        nome = pauta['name']
        del pauta['name']
        #return pauta
        hashid=Sound.init(pauta)
        Dsonggen={"songhid": hashid, "bpm": bpm_final, "samples": pauta["samples"], "effects": pauta["effects"], "music": pauta["music"]}
        Dsong={"authorid": user, "songhid": hashid, "name": nome, "path": "songs/"+hashid+".wav"}
        db.setSonggen(json.dumps(Dsonggen))
        db.setSong(json.dumps(Dsong))

        raise cherrypy.HTTPRedirect("/songs")

######################################
# /newSample -> Permite fazer upload de uma nova sample. (Método POST)

class NewSample(object):
    @cherrypy.expose
    def index(self, sample_upload, nome):
        user = "r.rosmaninho"
        

        size = 0
        data = b""
        h=MD5.new()

        # Robustez
        try:
            tipo = sample_upload.filename.split(".")
            tipo = tipo[len(tipo) - 1]
        except Exception:
            print("FILE_ERROR")
            raise cherrypy.HTTPRedirect("/samples")

        if str.lower(tipo) == "wav" :
            while True:
                block = sample_upload.file.read(4096)
                if not block:
                    break
                data = data + block
                h.update(block)
                size += len(block)

            name=h.hexdigest()
            name=name[0:16]
            file = os.path.join(PATH + "/samples/" + name + ".wav")
            with open(file, 'wb') as fout:
                fout.write(data)

            # Se o ficheiro é Stereo
            if(wave.open(file, "rb").getnchannels() == 2):
                # Passar de Stereo para Mono usando comando bash e ffmpeg
                subprocess.Popen("ffmpeg -i " + file + " -map_channel 0.0.0 " + file + " -y", shell=True, stdout=subprocess.PIPE)

            uid = db.getUserId(user)
            db.setSample(json.dumps({"authorid" : str(uid), "samplehid" : name, "name" : nome, "path" : "samples/" + name + ".wav"}))

        else:
            print("FILE_ERROR")

        raise cherrypy.HTTPRedirect("/samples")


######################################
# /newAvatar -> Permite fazer upload de um novo avatar. (Método POST)

class NewAvatar(object):
    @cherrypy.expose
    def index(self, avatar_upload):
        user = "r.rosmaninho"
        
        size = 0

        # Robustez
        try:
            tipo = avatar_upload.filename.split(".")
            tipo = tipo[len(tipo) - 1]
        except Exception:
            print("FILE_ERROR")
            raise cherrypy.HTTPRedirect("/samples")

        if str.lower(tipo) == "png" or str.lower(tipo) == "jpg" or str.lower(tipo) == "bnp"  :
            file = os.path.join(PATH + "/avatars/" + user + "." + tipo)
            with open(file, 'wb') as fout:
                while True:
                    block = avatar_upload.file.read(4096)
                    if not block:
                        break
                    fout.write(block)
                    size += len(block)
            
            db.setAvatar(user, "avatars/" + user + "." + tipo)

        else:
            print("FILE_ERROR")

        raise cherrypy.HTTPRedirect("/songs")
        

######################################

class GetVotes(object):
    @cherrypy.expose
    def index(self, id):
        var = db.getVotesByHashid(id)
        return json.dumps(var)

######################################
# /vote?id=identificador&user=uid&points=1 -> Permite a um utilizador a emissão de um voto numa música.
#  O campo id identifica a música, o campo user identifica o utilizador e o campo points especifica o número de pontos a atribuir (+1 ou -1).

class Vote(object):
    @cherrypy.expose
    def index(self, id, user, points, type):
        if type == "samples" or type == "songs":
            if points == str(1) or points == str(-1):
                return db.setVoteElement(type, id, user, points)
            elif points == str(0):
                return db.deleteVoteElement(type, id, user)

######################################
# /songgen?id=identificador -> Permite obter a pauta de uma determinada música através do seu identificador.
class SongGen(object):
    @cherrypy.expose
    def index(self, id):
        return db.getSonggen(id)

######################################
# /user -> Permite obter o utilizador universal (UU) da pessoa que está a utilizar o website

class User(object):
    @cherrypy.expose
    def index(self):
        user = "r.rosmaninho"
        
        json_data = json.dumps({"email": user, "name": user, "numvotes": 0, "avatar": "avatars/default.png"})
        db.setUser(json_data) # Tentar criar utilizador na DB. Se já existir é ignorado
        return user

######################################

class Root(object):
    def __init__(self):
        self.list = List()
        self.get = Get()
        self.getImage = GetImage()
        self.getKarma = GetKarma()
        self.avatar = Avatar()
        self.admins = Admins()
        self.report = Report()
        self.put = Put()
        self.newSample = NewSample()
        self.newAvatar = NewAvatar()
        self.getVotes = GetVotes()
        self.vote = Vote()
        self.songgen = SongGen()
        self.user = User()

    # Página mostrada por defeito é a web/index.html
    @cherrypy.expose
    def index(self):
        return open("../web/index.html").read()

    @cherrypy.expose
    def songs(self, order=None, asc_desc=0):
        return open("../web/songs.html").read()

    @cherrypy.expose
    def samples(self, order=None, asc_desc=0):
        return open("../web/samples.html").read()

    @cherrypy.expose
    def create(self, id=None):
        return open("../web/create.html").read()

# Iniciar servidor
if __name__ == "__main__":
    try:
        cherrypy.tree.mount(Root(), "/", config=conf)
        cherrypy.server.start()
    except KeyboardInterrupt:
        cherrypy.server.stop()
        sys.exit(1)
   


######################################
#               MÚSICA               #
######################################

class Prune(object):
    #formata a pauta de modo a que samples ou batidas nao utilizadas sejam ignoradas 
    def prune_songgen(self, pauta):
        newpauta=pauta
        lastfull=-1
        for i in range(len(pauta["music"])-1,-1,-1):
            if pauta["music"][i]!=[]:
                lastfull=i
                break
        
        # Se a pauta está vazia, terminar processo
        if lastfull == -1: 
            print("EMPTY_PAUTA")
            raise cherrypy.HTTPRedirect("/create")

        newpauta["music"]=pauta["music"][0:lastfull+1]

        used=False
        newSlist=[]
        newElist=[]
        newmusic=[]
        sampcount=0

        for i in range(0,len(pauta["samples"])):
            used=False
            for beat in range(0,len(newpauta["music"])):
                if i==0:
                    newmusic.append([])
                for s in newpauta["music"][beat]:
                    if s==i:
                        newmusic[beat].append(sampcount)
                        used=True
                        
            if used:
                newSlist.append(pauta["samples"][i])
                newElist.append(pauta["effects"][i])
                sampcount+=1

        newpauta["samples"]=newSlist
        newpauta["effects"]=newElist
        newpauta["music"]=newmusic

        return newpauta
