import os, requests
from lxml import etree
from moviedb.settings import BASE_DIR
import aiohttp
import asyncio

def get_omdb_params(key, value, year=None):
    return {
        'apikey': '732c648f',
        'r': 'xml',
        key: value,
    } if year is None else {
        'apikey': '732c648f',
        'r': 'xml',
        key: value,
        'y': year
    }

def get_feed(url):

    try:
        r = requests.get(url)
        r.raise_for_status()

        feed = etree.fromstring(bytes(r.text, encoding='utf-8'))

        return feed

    except:
        return None

def get_api_data_by_title(title, year):

    search_xsd=etree.parse(os.path.join(BASE_DIR, "app/api_search.xsd"))
    imdb_xsd=etree.parse(os.path.join(BASE_DIR, "app/api_ID.xsd"))

    try:
        r = requests.get('http://www.omdbapi.com/', params=get_omdb_params('s', title, year))
        r.raise_for_status()

        res = etree.fromstring(bytes(r.text, encoding='utf-8'))
        if res.attrib["response"]=="True":
            schema = etree.XMLSchema(search_xsd)
            if not schema.validate(res):
                # invalid
                return None
        else:
            # no results found
            return None

        id = res.xpath("result[1]/@imdbID")

        r = requests.get('http://www.omdbapi.com/', params=get_omdb_params('i', id[0]))
        r.raise_for_status()

        res = etree.fromstring(bytes(r.text, encoding='utf-8'))
        if res.attrib["response"]=="True":
            schema = etree.XMLSchema(imdb_xsd)
            if not schema.validate(res):
                # invalid
                return None
        else:
            # no results found
            return None

        return res

    except:
        return None

async def get_api_data_by_title_async(s, title, year, docid):

    search_xsd=etree.parse(os.path.join(BASE_DIR, "app/api_search.xsd"))
    imdb_xsd=etree.parse(os.path.join(BASE_DIR, "app/api_ID.xsd"))

    try:
        resp = await s.get('http://www.omdbapi.com/', params=get_omdb_params('s', title, year))
        async with resp as response:
            r = await response.text()

        res = etree.fromstring(bytes(r, encoding='utf-8'))
        if res.attrib["response"]=="True":
            schema = etree.XMLSchema(search_xsd)
            if not schema.validate(res):
                # invalid
                return title, None, docid
        else:
            # no results found
            return title, None, docid

        id = res.xpath("result[1]/@imdbID")

        resp = await s.get('http://www.omdbapi.com/', params=get_omdb_params('i', id[0]))
        async with resp as response:
            r = await response.text()

        res = etree.fromstring(bytes(r, encoding='utf-8'))
        if res.attrib["response"]=="True":
            schema = etree.XMLSchema(imdb_xsd)
            if not schema.validate(res):
                # invalid
                return title, None, docid
        else:
            # no results found
            return title, None, docid

        return title, res, docid

    except Exception as e:
        return title, None, docid

async def get_bulk_data(doc):
    async with aiohttp.ClientSession(loop=get_async_loop(), raise_for_status=True) as s:
        results = await asyncio.gather(*[get_api_data_by_title_async(s, t.text, y.text, d.text) for t, y, d in doc])
        return results

def get_api_dict(title, year):
    api_doc = get_api_data_by_title(title, year)

    return get_api_dict_from(api_doc)

def get_api_dict_from(api_doc):
    if api_doc is not None:
        return {
            'poster': str(api_doc.xpath("@poster")[0]) if api_doc.xpath("@poster") else "N/A",
            'imdb_rating': str(api_doc.xpath("@imdbRating")[0]) if api_doc.xpath("@imdbRating") else "N/A",
            'imdb_votes': str(api_doc.xpath("@imdbVotes")[0]) if api_doc.xpath("@imdbVotes") else "N/A",
            'awards': str(api_doc.xpath("@awards")[0]) if api_doc.xpath("@awards") else "N/A",
            'metascore': str(api_doc.xpath("@metascore")[0]) if api_doc.xpath("@metascore") else "N/A",
        }
    return {
        'poster': "N/A",
        'imdb_rating': "N/A",
        "imdb_votes": "N/A",
        "awards": "N/A",
        "metascore": "N/A",
    }

def get_async_loop():
    try:
        asyncio.get_event_loop()
    except:
        asyncio.set_event_loop(asyncio.new_event_loop())
    finally:
        return asyncio.get_event_loop()

