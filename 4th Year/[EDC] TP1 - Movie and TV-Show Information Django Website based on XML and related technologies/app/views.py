from django.shortcuts import render
from django.http import HttpResponseNotFound
from lxml import etree
from app.BaseXClient import BaseXClient
from moviedb.settings import BASE_DIR
from django.http import HttpResponse
import app.utils as utils
import os
import random
import re

session = BaseXClient.Session('localhost', 1984, 'admin', 'admin')

#Delete XMLs with Adult genre or VideoGame type
input = """
for $m in collection("smallset")//doc
where contains($m/genres, "Adult") or $m/type = "VideoGame"
return delete node $m
"""
query = session.query(input)
query.execute()

#Replace all movies, tvMovies and DirectToVideo types with Movie
input = """
for $m in collection("smallset")//doc/type
where $m = "movie" or $m = "TelevisionMovie" or $m = "DirectToVideo"
return replace node $m/text() with "Movie"
"""
query = session.query(input)
query.execute()

#Replace all tvSeries with Series
input = """
for $m in collection("smallset")//doc/type
where $m = "TelevisionSeries"
return replace node $m/text() with "Series"
"""
query = session.query(input)
query.execute()

placeholder_poster = "https://www.theprintworks.com/wp-content/themes/psBella/assets/img/film-poster-placeholder.png"

def home(request):
    return render(request, 'index.html', {'recentList': latestList("order by $m/year descending", 10),
                                          'mostVotesList': latestList("where $m/imdb_rating != 'N/A' order by xs:decimal(replace($m/imdb_votes, ',', '')) descending", 7),
                                          'bestRatingSeries': latestList("where $m/imdb_rating != 'N/A' and $m/type = 'Series' order by $m/imdb_rating descending", 12),
                                          'bestRatingMovies': latestList("where $m/imdb_rating != 'N/A' and $m/type = 'Movie' order by $m/imdb_rating descending", 12)})

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

    input = """
    <root> 
      <genres> {
        for $m in distinct-values(collection("smallset")//genre)
        let $count := count(collection("smallset")//doc/genres[genre=$m])
        order by $count
        return 
           <count value="{$m}">{$count}</count>
        }
      </genres>
      <years> {
        for $m in distinct-values(collection("smallset")//year)
        let $count := count(collection("smallset")//doc[year=$m])
        order by $m
        return 
           <count value="{$m}">{$count}</count>
        }
      </years>
    </root>
    """
    query = session.query(input)
    doc = etree.fromstring(query.execute())

    genres = {
        'labels': [str(g.xpath("@value")[0]) for g in doc.xpath("genres/count")],
        'data': [int(g.text) for g in doc.xpath("genres/count")]
    }

    years = {
        'labels': [y.xpath("@value")[0] for y in doc.xpath("years/count")],
        'data': [int(y.text) for y in doc.xpath("years/count")]
    }

    return render(request, 'stats.html', context={'genres': genres, 'years': years})

def listAux(request):
    filter = None
    fstr = ""
    if "person" in request.GET:
        filter = ("person", request.GET["person"])
        fstr = "where contains($m, '" + filter[1] + "')"
    elif "genre" in request.GET:
        filter = ("genre", request.GET["genre"])
        fstr = "where contains($m/genres, '" + filter[1] + "')"
    elif "year" in request.GET:
        filter = ("year", request.GET["year"])
        fstr = "where $m/year = " + filter[1]
    elif "country" in request.GET:
        filter = ("country", request.GET["country"])
        fstr = "where contains($m/countries, '" + filter[1] + "')"
    elif "language" in request.GET:
        filter = ("language", request.GET["language"])
        fstr = "where contains($m/languages, '" + filter[1] + "')"
    elif "type" in request.GET:
        filter = ("type", request.GET["type"])
        fstr = "where $m/type = '" + filter[1] + "'"
    elif "Search" in request.POST:
        filter = ("title", request.POST["Search"])
        fstr = "where contains(lower-case($m/title), lower-case('" + filter[1] + "'))"

    input = """
        <root> {
        for $m in collection("smallset")//doc
        """ + fstr + """
        return 
            <elem>
                {$m/docid}
                {$m/title}
                {$m/type}
                {$m/year}
                {$m/genres}
                {$m/poster}
                {$m/imdb_rating}
                {$m/imdb_votes}
            </elem>  
        }
        </root>
        """
    query = session.query(input)
    doc = etree.fromstring(query.execute())

    loop = utils.get_async_loop()
    api_data = dict()

    l = []
    for elem in doc.xpath("//elem"):
        if not elem.xpath("imdb_rating"):
            l.append((elem.xpath("title")[0], elem.xpath("year")[0], elem.xpath("docid")[0]))

    l = loop.run_until_complete(utils.get_bulk_data(l))

    for title, root, docid in l:
        api_data.setdefault(docid, root)

    list = []
    for movie in doc.xpath("//elem"):
        title = movie.xpath("title")[0].text
        docid = movie.xpath("docid")[0].text
        poster = None
        imdb_rating = None
        imdb_votes = None

        # need update
        if docid in api_data:
            api_doc = api_data[docid][0] if api_data[docid] is not None else None

            if api_doc is not None:
                api_dict = handle_api_doc(api_doc, docid)
                poster = api_dict["poster"]
                imdb_rating = api_dict["imdb_rating"]
                imdb_votes = api_dict["imdb_votes"]

        else:
            poster = movie.xpath("poster")[0].text
            imdb_rating = movie.xpath("imdb_rating")[0].text
            imdb_votes = movie.xpath("imdb_votes")[0].text

        list.append({
            'docid': docid,
            'title': title,
            'type': movie.xpath("type")[0].text,
            'year': movie.xpath("year")[0].text,
            'genres': [g.text for g in movie.xpath(".//genre")],
            'poster': poster if poster is not None and poster != "N/A" else placeholder_poster,
            'imdb_rating': imdb_rating if imdb_rating is not None else "N/A",
            'imdb_votes': imdb_votes if imdb_votes is not None else "N/A",
        })

    return list, filter

def list(request):
    list, filter = listAux(request)
    if filter == None:
        return render(request, 'list.html', context={'items': list, 'filter': filter})
    else:
        return render(request, 'list_single.html', context={'items': list, 'filter': filter})

def latestList(fstr, size):
    input = """
                <root> {
                for $m in collection("smallset")//doc
                """ + fstr + """
                return 
                    <elem>
                        {$m/docid}
                        {$m/title}
                        {$m/type}
                        {$m/year}
                        {$m/genres}
                        {$m/poster}
                        {$m/imdb_rating}
                        {$m/imdb_votes}
                    </elem>  
                }
                </root>
                """
    query = session.query(input)
    doc = etree.fromstring(query.execute())

    loop = utils.get_async_loop()
    api_data = dict()

    l = []
    for elem in doc.xpath("//elem"):
        if not elem.xpath("imdb_rating"):
            l.append((elem.xpath("title")[0], elem.xpath("year")[0], elem.xpath("docid")[0]))

    l = loop.run_until_complete(utils.get_bulk_data(l))

    for title, root, docid in l:
        api_data.setdefault(docid, root)

    latestList = []
    for element in doc.xpath("//elem[position()<"+str(size+1)+"]"):
        title = element.xpath("title")[0].text
        docid = element.xpath("docid")[0].text

        poster = placeholder_poster
        imdb_rating = None
        imdb_votes = None

        # need update
        if docid in api_data:
            api_doc = api_data[docid][0] if api_data[docid] is not None else None

            if api_doc is not None:
                api_dict = handle_api_doc(api_doc, docid)
                poster = api_dict["poster"]
                imdb_rating = api_dict["imdb_rating"]
                imdb_votes = api_dict["imdb_votes"]
        else:
            poster = element.xpath("poster")[0].text
            imdb_rating = element.xpath("imdb_rating")[0].text
            imdb_votes = element.xpath("imdb_votes")[0].text

        latestList.append({
            'docid': element.xpath("docid")[0].text,
            'title': title,
            'type': element.xpath("type")[0].text,
            'year': element.xpath("year")[0].text,
            'genres': [g.text for g in element.xpath(".//genre")],
            'poster': poster if poster != "N/A" else placeholder_poster,
            'imdb_rating': imdb_rating if imdb_rating is not None else "N/A",
            'imdb_votes': imdb_votes if imdb_votes is not None else "N/A",
        })
    return latestList

def single(request, id):

    movie_xsd=etree.parse(os.path.join(BASE_DIR, "app/movie_schema.xsd"))

    input = "for $m in collection('smallset')//doc\nwhere $m/docid = " + id + "\nreturn $m"
    query = session.query(input)
    doc = etree.fromstring(query.execute())
    # validation
    schema = etree.XMLSchema(movie_xsd)
    if not schema.validate(doc):
        # fail validation
        return handler500(request)

    title = doc.xpath("title")[0].text
    year = doc.xpath("year")[0].text

    poster = None
    imdb_rating = None
    imdb_votes = None
    awards = None
    metascore = None

    if doc.xpath("imdb_rating"):
        poster = doc.xpath("poster")[0].text
        imdb_rating = doc.xpath("imdb_rating")[0].text
        imdb_votes = doc.xpath("imdb_votes")[0].text
        awards = doc.xpath("awards")[0].text
        metascore = doc.xpath("metascore")[0].text
    else:
        api_dict = handle_api_data(title, year, id)

        poster=api_dict["poster"]
        imdb_rating=api_dict["imdb_rating"]
        imdb_votes=api_dict["imdb_votes"]
        awards=api_dict["awards"]
        metascore=api_dict["metascore"]

    try:
        runtime = doc.xpath("//runningtime[@country='default']")[0].text
    except:
        runtime = doc.xpath("//runningtime")
        if runtime:
            runtime = runtime[0].text

    try:
        xslt = etree.parse("app/reviews.xsl")
        transform = etree.XSLT(xslt)
        reviews = etree.tostring(transform(doc), encoding='unicode', method='xml')
    except:
        reviews = ""

    movie = {
        'mid': id,
        'title': title,
        'type': doc.xpath("type")[0].text,
        'year': year,
        'poster': poster if poster != "N/A" else placeholder_poster,
        'imdb_rating': imdb_rating if imdb_rating is not None else "N/A",
        'imdb_votes': imdb_votes if imdb_votes is not None else "N/A",
        'awards': awards if awards is not None else "N/A",
        'metascore': metascore if metascore is not None else "N/A",
        'runtime': runtime,
        'plot': doc.xpath("plot")[0].text,
        'genres': [g.text for g in doc.xpath("//genre")],
        'keywords': [k.text for k in doc.xpath("//keyword")],
        'editors': [e.text for e in doc.xpath('//editor')],
        'languages': [l.text for l in doc.xpath('//language')],
        'composers': [c.text for c in doc.xpath('//composer')],
        'writers': [w.text for w in doc.xpath('//writer')],
        'directors': [d.text for d in doc.xpath('//director')],
        'producers': [p.text for p in doc.xpath('//producer')],
        'countries': [p.text for p in doc.xpath('//country')],
        'cast': [{ 'actor': c.xpath('actor')[0].text, 'role': c.xpath("role")[0].text } for c in doc.xpath('cast/credit')],
        'release_dates': [{ 'country': str(r.xpath('@country')[0]), 'date': r.text } for r in doc.xpath('//releasedate')],
        'reviews_num': len(doc.xpath("//review")),
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
            auxReq.GET['genre'] = movie['genres'][random.randint(0, len(movie['genres']) - 1)]
            relatedMovies = listAux(auxReq)
            del auxReq.GET['genre']
    del auxReq

    if (relatedMovies != []):
        movie['related_movies'] = relatedMovies[0]
        movie['relation'] = relatedMovies[1][1]
    movie['latest'] = latestList("order by $m/year descending", 10)

    if ("movie" in request.path and movie['type'] == "Movie") or ("serie" in request.path and movie['type'] == "Series"):
        # close query object
        query.close()
        return render(request, 'single.html', context=movie)
    else:
        # close query object
        query.close()
        if ("movie" in request.path):
            return HttpResponseNotFound("That ID is from a serie, not a movie!!")
        else:
            return HttpResponseNotFound("That ID is from a movie, not a serie!!")

def review(request, mid, rid):
    if request.method == 'POST':
        input = """
        let $m := collection("smallset")//doc[docid=""" + mid + """]
        return if (exists($m//review[@id='""" + rid + """']))
               then (update:output("Update successful."), replace node $m//review[@id='""" + rid + """'] with (
                 <review id='""" + rid + """'>
                  <name>""" + request.POST['name'] + """</name>
                  <stars>""" + request.POST['stars'] + """</stars>
                  <comment>""" + request.POST['review'] + """</comment>
                 </review>
               ))
               else (
                  if (not(exists($m/reviews)))
                         then (update:output("Create successful."), insert nodes(
                           <reviews>
                             <review id='0'>
                              <name>""" + request.POST['name'] + """</name>
                              <stars>""" + request.POST['stars'] + """</stars>
                              <comment>""" + request.POST['review'] + """</comment>
                             </review>
                           </reviews>
                         ) after $m/type)
                         else (update:output("Add successful."), insert node(
                                <review id="{count($m//review)}">
                                  <name>""" + request.POST['name'] + """</name>
                                  <stars>""" + request.POST['stars'] + """</stars>
                                  <comment>""" + request.POST['review'] + """</comment>
                                </review>
                            ) into $m/reviews)
               )
        """

    if request.method == 'DELETE':
        input = """
            let $m := collection("smallset")//doc[docid=""" + mid + """]
            return delete node $m//review[@id='""" + rid + """']
        """

    query = session.query(input)
    query.execute()

    return HttpResponse(status=200)

def handle_api_data(title, year, id):
    api_dict = utils.get_api_dict(title, year)

    return get_write_api_data(api_dict, id)


def handle_api_doc(api_doc, id):
    api_dict = utils.get_api_dict_from(api_doc)

    return get_write_api_data(api_dict, id)

def get_write_api_data(api_dict, id):
    poster = api_dict["poster"]
    imdb_rating = api_dict["imdb_rating"]
    imdb_votes = api_dict["imdb_votes"]
    awards = api_dict["awards"]
    metascore = api_dict["metascore"]
    input = """for $m in collection('smallset')//doc\nwhere $m/docid = """ + id + """\nreturn insert nodes (
                <poster>""" + escape_xml(poster) + """</poster>,
                <imdb_rating>""" + escape_xml(imdb_rating) + """</imdb_rating>,
                <imdb_votes>""" + escape_xml(imdb_votes) + """</imdb_votes>,
                <awards>""" + escape_xml(awards) + """</awards>,
                <metascore>""" + escape_xml(metascore) + """</metascore>
            ) after $m/type
            """
    query = session.query(input)
    query.execute()

    return {
        "poster": poster,
        "imdb_rating": imdb_rating,
        "imdb_votes": imdb_votes,
        "awards": awards,
        "metascore": metascore
    }

def escape_xml(string):
    return string.translate(str.maketrans({
        "\"": "&quot;",
        "'": "&apos;",
        "<": "&lt;",
        ">": "&gt;",
        "&": "&amp;",
    }))


def handler404(request, exception):
    return render(request, "error404.html", status=404)


def handler500(request):
    return render(request, "error500.html", status=500)
