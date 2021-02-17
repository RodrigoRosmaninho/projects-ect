from SPARQLWrapper import SPARQLWrapper, JSON

endpoint = "http://localhost:7200/repositories/moviedb" # repository endpoint

sparql = SPARQLWrapper(endpoint)
sparql.setReturnFormat(JSON)

def simple_list_query(id, prop):
    return """
        PREFIX predicate: <http://moviesDB.com/predicate>
        select ?value
        where {
            ?doc predicate:docid '""" + id + """' .
            ?doc predicate:""" + prop + """ ?value .
        }
    """

def nested_list_query(id, prop, nested_list):
    return """
        PREFIX predicate: <http://moviesDB.com/predicate>
        select """ + "".join(s for s in ["?{} ".format(ne) for ne in nested_list]) + """
        where {
            ?doc predicate:docid '""" + id + """' .
            ?doc predicate:""" + prop + """ ?anon .
            """ + "".join(s for s in ["?anon predicate:{} ?{} .\n".format(ne,ne) for ne in nested_list]) + """
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


sparql.setQuery(simple_list_query('000105', 'genres'))
ret = sparql.query().convert()
print(parse_query_results(ret))
print("")

sparql.setQuery(nested_list_query('061596','reviews',['name','stars','comment']))
ret = sparql.query().convert()
print(parse_query_results(ret))

sparql.setQuery("""
    PREFIX predicate: <http://moviesDB.com/predicate>
    SELECT ?name (count(?genre) as ?count)
    WHERE
    {
    ?mov predicate:genres ?genre .
    ?genre predicate:name ?name
    }
    GROUP BY ?name
""")
ret = sparql.query().convert()
print(parse_query_results(ret))