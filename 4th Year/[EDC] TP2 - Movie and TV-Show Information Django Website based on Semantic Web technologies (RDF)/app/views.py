from django.shortcuts import render
from django.http import HttpResponseNotFound
from lxml import etree
from django.http import HttpResponse
import app.utils as utils
import random
import re
from SPARQLWrapper import SPARQLWrapper, JSON

session = SPARQLWrapper("http://localhost:7200/repositories/moviedb")
session.setReturnFormat(JSON)
update = SPARQLWrapper("http://localhost:7200/repositories/moviedb/statements")
update.setReturnFormat(JSON)
update.method = 'POST'

update.setQuery("""
    # Inference person worked on genre
    PREFIX predicate: <http://moviesDB.com/predicate>
    PREFIX doc: <http://moviesDB.com/entity/doc>
    insert {
        ?person predicate:worked ?genre
    }
    where {
        ?mov predicate:cast ?anon .
        ?anon predicate:actor ?person .
        
        ?mov predicate:genres ?genre .
    }
""")
update.query().convert()

dbpedia = SPARQLWrapper("https://dbpedia.org/sparql")
dbpedia.setReturnFormat(JSON)

placeholder_poster = "https://www.theprintworks.com/wp-content/themes/psBella/assets/img/film-poster-placeholder.png"

def home(request):
    return render(request, 'index.html', {'recentList': latestList("order by desc(?year)", 10),
                                          'mostVotesList': latestList("order by desc(?imdb_votes)", 7),
                                          'bestRatingSeries': latestList("order by desc(?imdb_rating)", 12, type='Series'),
                                          'bestRatingMovies': latestList("order by desc(?imdb_rating)", 12, type='Movie')})

# feed
def news(request):

    rssfeed = utils.get_feed('https://www.traileraddict.com/rss')

    list = []

    for trailer in rssfeed.xpath('//item'):
        img = re.search(" +src=\"(.*?)\"", trailer.xpath('description')[0].text).group(1)
        list.append({
            "title": trailer.xpath('category')[0].text,
            "link": trailer.xpath('link')[0].text,
            "date": trailer.xpath('pubDate')[0].text[:-6],
            "img": img
        })

    return render(request, 'news.html', context={"trailers": list})

def stats(request):

    session.setQuery("""
        PREFIX predicate: <http://moviesDB.com/predicate>
        SELECT ?name (count(?genre) as ?count)
        WHERE
        {
          ?mov predicate:genres ?genre .
          ?genre predicate:name ?name
        }
        GROUP BY ?name
    """)
    resg = parse_query_results(session.query().convert())

    genres = {
        'labels': [r['name'] for r in resg],
        'data': [int(r['count']) for r in resg]
    }

    session.setQuery("""
        PREFIX predicate: <http://moviesDB.com/predicate>
        SELECT ?year (count(?year) as ?count)
        WHERE
        {
          ?mov predicate:year ?year .
        }
        GROUP BY ?year
    """)
    resy = parse_query_results(session.query().convert())

    years = {
        'labels': sorted([int(r['year']) for r in resy]),
        'data': [int(r['count']) for r in resy]
    }

    return render(request, 'stats.html', context={'genres': genres, 'years': years})

def listAux(request, id=None, type=None):

    if request is None:
        POST = {type: id}
        GET = {type: id}
    else:
        POST = request.POST
        GET = request.GET

    filter = None
    objects = ['?title', '?type', '?year']
    person = None
    genre = None
    country = None
    language = None
    if "Search" in POST:
        filter = ("title", POST["Search"])
        objects[0] = "'"+escape(filter[1])+"'"
    elif "type" in GET:
        filter = ("type", GET["type"])
        objects[1] = "'"+escape(filter[1])+"'"
    elif "year" in GET:
        filter = ("year", GET["year"])
        objects[2] = "'"+escape(filter[1])+"'"
    elif "person" in GET:
        filter = ("person", GET["person"])
        person = filter[1]
    elif "genre" in GET:
        filter = ("genre", GET["genre"])
        genre = filter[1]
    elif "country" in GET:
        filter = ("country", GET["country"])
        country = filter[1]
    elif "language" in GET:
        filter = ("language", GET["language"])
        language = filter[1]

    input = """
        PREFIX predicate: <http://moviesDB.com/predicate>
        select ?uri ?id ?title ?type ?year ?poster ?imdb_rating ?imdb_votes
        where {
            ?uri predicate:docid ?id .
            ?uri predicate:title ?title .
            ?uri predicate:type """ + objects[1] + """ .
            ?uri predicate:year """ + objects[2] + """ .
            ?uri predicate:poster ?poster .
            ?uri predicate:imdb_rating ?imdb_rating .
            ?uri predicate:imdb_votes ?imdb_votes .
            filter(lcase(?title)=lcase(""" + objects[0] + """))
        }
        """
    session.setQuery(input)
    docs = parse_query_results(session.query().convert())

    list = []
    for movie in docs:
        session.setQuery(genre_list_query(movie['id']))
        genres = [{'name': d['value'], 'uri': d['uri']} for d in parse_query_results(session.query().convert())]

        ask = True
        if genre:
            session.setQuery("""
                PREFIX predicate:<http://moviesDB.com/predicate>
                ask {
                    ?uri predicate:docid '""" + movie['id'] + """' .
                    ?genre predicate:name '""" + genre + """' .
                    ?uri predicate:genres ?genre.
                }
            """)
            ask = (session.query().convert())['boolean']
        else:
            filt = None
            prop = None
            if person:
                filt = person
                prop = 'people'
            elif country:
                filt = country
                prop = 'countries'
            elif language:
                filt = language
                prop = 'languages'

            if filt:
                if prop == 'people':
                    session.setQuery("""
                        PREFIX predicate: <http://moviesDB.com/predicate>
                        ask {
                            ?uri predicate:docid '""" + movie['id'] + """' .
                            ?person predicate:name '""" + filt + """' .
                            { ?uri predicate:editors ?person . }
                            union { ?uri predicate:directors ?person . }
                            union { ?uri predicate:producers ?person . }
                            union { ?uri predicate:writers ?person . }
                            union { ?uri predicate:composers ?person . }
                            union {
                                ?uri predicate:cast ?anon .
                                ?anon predicate:actor ?person .
                            }
                        }
                    """)
                else:
                    session.setQuery("""
                        PREFIX predicate: <http://moviesDB.com/predicate>
                        ask {
                            ?uri predicate:docid '""" + movie['id'] + """' .
                            ?uri predicate:""" + prop + """ '""" + filt + """' .
                        }
                    """)
                ask = (session.query().convert())['boolean']
        if ask:
            list.append({
                'docid': movie['id'],
                'uri': movie['uri'],
                'title': movie['title'],
                'type': movie['type'] if 'type' not in GET else filter[1],
                'year': movie['year'] if 'year' not in GET else filter[1],
                'genres': genres,
                'poster': movie['poster'] if movie['poster']!='N/A' else placeholder_poster,
                'imdb_rating': movie['imdb_rating'],
                'imdb_votes': movie['imdb_votes'],
            })

    return list, filter

def list(request):
    list, filter = listAux(request)
    if filter == None:
        return render(request, 'list.html', context={'items': list, 'filter': filter})
    else:
        return render(request, 'list_single.html', context={'items': list, 'filter': filter})

def latestList(fstr, size, type=None):
    input = """
            PREFIX predicate: <http://moviesDB.com/predicate>
            select ?uri ?id ?title """ + ('?type' if type == None else '') + """ ?year ?poster ?imdb_rating ?imdb_votes
            where {
                ?uri predicate:docid ?id .
                ?uri predicate:title ?title .
                ?uri predicate:type """ + ('?type' if type == None else '"'+type+'"') + """ .
                ?uri predicate:year ?year .
                ?uri predicate:poster ?poster .
                ?uri predicate:imdb_rating ?imdb_rating .
                ?uri predicate:imdb_votes ?imdb_votes .
            } """ + fstr + """
            """
    session.setQuery(input)
    docs = parse_query_results(session.query().convert())

    list = []
    count = 0
    for movie in docs:
        if count >= size:
            break

        session.setQuery(genre_list_query(movie['id']))
        ret = parse_query_results(session.query().convert())
        genres = [{'name': d['value'], 'uri': d['uri']} for d in ret]

        if movie['imdb_votes'] == 'N/A' and fstr == "order by desc(?imdb_votes)":
            continue

        count += 1

        list.append({
            'docid': movie['id'],
            'uri': movie['uri'],
            'title': movie['title'],
            'type': (movie['type'] if type == None else type),
            'year': movie['year'],
            'genres': genres,
            'poster': movie['poster'] if movie['poster']!='N/A' else placeholder_poster,
            'imdb_rating': movie['imdb_rating'],
            'imdb_votes': movie['imdb_votes'],
            })
    return list

def get_id(uri):
    return uri.split("person")[1]

def single(request, id):

    session.setQuery("""
        PREFIX predicate: <http://moviesDB.com/predicate>
        select ?uri ?title ?type ?year ?poster ?imdb_rating ?imdb_votes ?awards ?metascore ?plot
        where {
            ?uri predicate:docid '""" + id + """' .
            ?uri predicate:title ?title .
            ?uri predicate:type ?type .
            ?uri predicate:year ?year .
            ?uri predicate:poster ?poster .
            ?uri predicate:imdb_rating ?imdb_rating .
            ?uri predicate:imdb_votes ?imdb_votes .
            ?uri predicate:awards ?awards .
            ?uri predicate:metascore ?metascore .
            ?uri predicate:plot ?plot .
        }
    """)
    metadata = parse_query_results(session.query().convert())[0]

    session.setQuery(genre_list_query(id))
    genres = [{'name': d['value'], 'uri': d['uri']} for d in parse_query_results(session.query().convert())]
    session.setQuery(simple_list_query(id, 'keywords'))
    keywords = [d['value'] for d in parse_query_results(session.query().convert())]
    session.setQuery(simple_list_query(id, 'editors', name=True))
    editors = [{'name': d['value'], 'uri': d['uri'], 'uid':get_id(d['uri'])} for d in parse_query_results(session.query().convert())]
    session.setQuery(simple_list_query(id, 'languages', name=False))
    languages = [d['value'] for d in parse_query_results(session.query().convert())]
    session.setQuery(simple_list_query(id, 'composers', name=True))
    composers = [{'name': d['value'], 'uri': d['uri'], 'uid':get_id(d['uri'])} for d in parse_query_results(session.query().convert())]
    session.setQuery(simple_list_query(id, 'writers', name=True))
    writers = [{'name': d['value'], 'uri': d['uri'], 'uid':get_id(d['uri'])} for d in parse_query_results(session.query().convert())]
    session.setQuery(simple_list_query(id, 'directors', name=True))
    directors =[{'name': d['value'], 'uri': d['uri'], 'uid':get_id(d['uri'])} for d in parse_query_results(session.query().convert())]
    session.setQuery(simple_list_query(id, 'producers', name=True))
    producers = [{'name': d['value'], 'uri': d['uri'], 'uid':get_id(d['uri'])} for d in parse_query_results(session.query().convert())]
    session.setQuery(simple_list_query(id, 'countries'))
    countries = [d['value'] for d in parse_query_results(session.query().convert())]

    session.setQuery(nested_list_query(id, 'runningtimes', ['country', 'runningtime']))
    runtimes = [{'country': d['country'], 'runtime': d['runningtime']} for d in parse_query_results(session.query().convert())]
    session.setQuery(actor_list_query(id))
    cast = [{'actor': d['actor'], 'role': d['role'], 'uri': d['uri'], 'uid':get_id(d['uri'])} for d in parse_query_results(session.query().convert())]
    session.setQuery(nested_list_query(id, 'releasedates', ['country', 'releasedate']))
    releases = [{'country': d['country'], 'date': d['releasedate']} for d in parse_query_results(session.query().convert())]
    session.setQuery(nested_list_query(id, 'reviews', ['id', 'name', 'stars', 'comment']))
    reviews = [{'id': d['id'], 'name': d['name'], 'stars': d['stars'], 'comment': d['comment']} for d in parse_query_results(session.query().convert())]

    movie = {
        'mid': id,
        'uri': metadata['uri'],
        'title': metadata['title'],
        'type': metadata['type'],
        'year': metadata['year'],
        'poster': metadata['poster'] if metadata['poster']!='N/A' else placeholder_poster,
        'imdb_rating': metadata['imdb_rating'],
        'imdb_votes': metadata['imdb_votes'],
        'awards': metadata['awards'],
        'metascore': metadata['metascore'],
        'runtime': runtimes,
        'plot': metadata['plot'],
        'genres': genres,
        'keywords': keywords,
        'editors': editors,
        'languages': languages,
        'composers': composers,
        'writers': writers,
        'directors': directors,
        'producers': producers,
        'countries': countries,
        'cast': cast,
        'release_dates': releases,
        'reviews_num': len(reviews),
        'reviews': reviews
    }

    auxReq = request
    if not auxReq.GET._mutable:
        auxReq.GET._mutable = True

    relatedMovies = []
    if movie['cast']:
        auxReq.GET['person'] = movie['cast'][random.randint(0, len(movie['cast'])-1)]['actor']
        relatedMovies = listAux(auxReq)
        del auxReq.GET['person']
    if relatedMovies == [] or len(relatedMovies[0]) <= 1:
        if (movie['genres'] == []):
            relatedMovies = []
        else:
            auxReq.GET['genre'] = movie['genres'][random.randint(0, len(movie['genres']) - 1)]['name']
            relatedMovies = listAux(auxReq)
            del auxReq.GET['genre']
    del auxReq

    if (relatedMovies != []):
        movie['related_movies'] = relatedMovies[0]
        movie['relation'] = relatedMovies[1][1]
    movie['latest'] = latestList("order by desc(?year)", 10)

    if ("movie" in request.path and movie['type'] == "Movie") or ("serie" in request.path and movie['type'] == "Series"):
        return render(request, 'single.html', context=movie)
    else:
        if ("movie" in request.path):
            return HttpResponseNotFound("That ID is from a serie, not a movie!!")
        else:
            return HttpResponseNotFound("That ID is from a movie, not a serie!!")

def review(request, mid, rid):
    session.setQuery(nested_list_query(mid, 'reviews', ['id', 'name', 'stars', 'comment']))
    reviews = [{'id': d['id'], 'name': d['name'], 'stars': d['stars'], 'comment': d['comment']} for d in parse_query_results(session.query().convert())]
    nrev = len(reviews)
    if request.method == 'POST':
        if rid in [r['id'] for r in reviews]:  # exists -> update (delete first)
            id = rid
            update.setQuery("""
                # Delete Review
                PREFIX predicate: <http://moviesDB.com/predicate>
                PREFIX doc: <http://moviesDB.com/entity/doc>
                delete {
                    ?mov predicate:reviews ?rev.
                    ?rev ?p ?v
                }
                WHERE {
                    ?mov predicate:docid '""" + str(mid) + """' .
                    ?mov predicate:reviews ?rev .
                    ?rev predicate:id """ + str(id) + """ .
                    ?rev ?p ?v .
                }
            """)
            update.query().convert()
        else:  # new review
            id = nrev

        input = """
            PREFIX predicate: <http://moviesDB.com/predicate>
            PREFIX doc: <http://moviesDB.com/entity/doc>
            insert {
                ?mov predicate:reviews [
                    predicate:id """ + str(id) + """;
                    predicate:name '""" + escape(request.POST['name']) + """';
                    predicate:stars """ + escape(request.POST['stars']) + """;
                    predicate:comment '""" + escape(request.POST['review']) + """'
                ]
            }
            WHERE {
                ?mov predicate:docid '""" + str(mid) + """'.
            }
        """
        update.setQuery(input)
        update.query().convert()

    if request.method == 'DELETE':
        input = """
            # Delete Review
            PREFIX predicate: <http://moviesDB.com/predicate>
            PREFIX doc: <http://moviesDB.com/entity/doc>
            delete {
                ?mov predicate:reviews ?rev.
                ?rev ?p ?v
            }
            WHERE {
                ?mov predicate:docid '""" + str(mid) + """' .
                ?mov predicate:reviews ?rev .
                ?rev predicate:id """ + str(rid) + """ .
                ?rev ?p ?v .
            }
        """
        update.setQuery(input)
        update.query().convert()

    return HttpResponse(status=200)

def person(request, pid):
    input = """
        PREFIX person: <http://moviesDB.com/entity/person>
        PREFIX predicate: <http://moviesDB.com/predicate>
        SELECT DISTINCT ?name ?genre ?gname
        WHERE { 
            person:""" + pid + """ predicate:name ?name.
            OPTIONAL { person:""" + pid + """ predicate:worked ?genre.
            ?genre predicate:name ?gname }
        } 
        LIMIT 100
    """

    try:
        session.setQuery(input)
        res = parse_query_results(session.query().convert())
        genres = [{'uri': d['genre'], 'name': d['gname']} for d in res if 'genre' in d]
        og_name = parse_query_results(session.query().convert())[0]['name']
        name = " ".join(reversed(og_name.split(", ")))
    except:
        return HttpResponseNotFound("No such person exists!")

    input = """
        PREFIX foaf: <http://xmlns.com/foaf/0.1/>
        PREFIX dbo: <http://dbpedia.org/ontology/>
        PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
        SELECT DISTINCT ?abstract ?Person_1
        WHERE { ?Person_1 a dbo:Person .
                ?Person_1 foaf:name ?name .
                ?Person_1 dbo:abstract ?abstract .
                FILTER ( ?name = '""" + name + """'@en )
                FILTER (lang(?abstract) = 'en') }
        LIMIT 1
    """

    try:
        dbpedia.setQuery(input)
        abstract = parse_query_results(dbpedia.query().convert())[0]['abstract']
    except:
        abstract = None



    return render(request, 'person.html', context={
        'title': name,
        'uri': 'http://moviesDB.com/entity/person' + pid,
        'plot': abstract,
        'genres': genres,
        'movies': listAux(None, id=og_name, type="person")[0]
    })

def escape(string):
    return string.translate(str.maketrans({
        "\"": '\\"',
        "'": "\\'"
    }))

def simple_list_query(id, prop, name=False):
    return """
        PREFIX predicate: <http://moviesDB.com/predicate>
        select """ + ('?uri' if name else '') + """ ?value
        where {
            ?mov predicate:docid '""" + id + """' .
            ?mov predicate:""" + prop + """ """ + ('?uri' if name else '?value') + """ .
            """ + ('?uri predicate:name ?value' if name else '') + """
        }
    """

def nested_list_query(id, prop, nested_list):
    return """
        PREFIX predicate: <http://moviesDB.com/predicate>
        select """ + "".join(s for s in ["?{} ".format(ne) for ne in nested_list]) + """
        where {
            ?mov predicate:docid '""" + id + """' .
            ?mov predicate:""" + prop + """ ?anon .
            """ + "".join(s for s in ["?anon predicate:{} ?{} .\n".format(ne,ne) for ne in nested_list]) + """
        }
    """

def genre_list_query(id):
    return """
        PREFIX predicate: <http://moviesDB.com/predicate>
        select ?uri ?value
        where {
            ?mov predicate:docid '""" + id + """' .
            ?mov predicate:genres ?uri .
            ?uri predicate:name ?value
        }
    """

def actor_list_query(id):
    return """
        PREFIX predicate: <http://moviesDB.com/predicate>
        select ?uri ?actor ?role
        where {
            ?mov predicate:docid '""" + id + """' .
            ?mov predicate:cast ?anon .
            ?anon predicate:actor ?uri .
            ?uri predicate:name ?actor .
            ?anon predicate:role ?role .
        }
    """

def parse_query_results(result):
    binds = result['results']['bindings']
    ret = []
    for b in binds:
        dic = {}
        for key, val in b.items():
            dic[key] = val['value']
        ret.append(dic)
    return ret

def handler404(request, exception):
    return render(request, "error404.html", status=404)


def handler500(request):
    return render(request, "error500.html", status=500)
