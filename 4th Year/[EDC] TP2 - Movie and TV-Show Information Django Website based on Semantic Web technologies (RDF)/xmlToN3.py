from lxml import etree
import itertools

def display(root, tab=0):
    seen = set([])

    for i in range(len(root)):
        child = root[i]
        children = list(child)
        
        if etree.tostring(child) not in seen:
            seen.add(etree.tostring(child))
        else: 
            continue

        text = child.text
        tag = child.tag

        text = text.replace('"', '')

        if tag in ['certificate', 'releasedate', 'runningtime']:
            tag = '[predicate:' + tag + ' ' + ('"' if tag != 'runningtime' else '') + text + ('"' if tag != 'runningtime' else '') + ';\n' + ("  " * tab) + ' predicate:country "' + child.xpath("@country")[0] + '"]'
            text = ""
            children = []
        elif tag == 'review':
            tag = '[predicate:id ' + str(child.xpath("@id")[0]) + ';\n' + ("  " * tab)  + ' predicate:name "' + child.xpath("name")[0].text + '";\n' + ("  " * tab) + ' predicate:stars ' + child.xpath("stars")[0].text + ';\n' + ("  " * tab) + ' predicate:comment "' + child.xpath("comment")[0].text + '"]'
            text = ""
            children = []
        elif tag == 'credit':
            tag = '[predicate:actor person:' + child.xpath("actor")[0].text.replace(", ", "_").replace(
                " (", "_").replace(")", "").replace(" ", "_").replace(".", "").replace("'", "") + ';\n' + ("  " * tab) + ' predicate:role "' + child.xpath("role")[0].text.replace('"', "'") + '"]'
            text = ""
            children = []
        elif tag in ["producer", "actor", "writer", "editor", "director", "composer"]:
            text = text.replace(", ", "_").replace(
                " (", "_").replace(")", "").replace(" ", "_").replace(".", "").replace("'", "")
            tag = "person:"
        elif tag in ["genre"]:
            text = text.replace(" ", "_")
            tag = tag + ":"
        elif tag in ["keyword", "colorinfo", "language", "country", "soundmix"]:
            text = '"' + text + '"'
            tag = ""
        elif tag == "doc":
            tag = "doc:" + child.xpath("@id")[0]
        elif tag == "imdb_votes":
            text = text.replace(",", "") if text != "N/A" else '"N/A"'
            tag = "predicate:" + tag + " "
        else:
            text = '"' + text + '"'
            tag = "predicate:" + tag + " "
            
        statement = ("  " * tab) + tag
        
        if len(children):
            print(statement)
            display(child, tab + 1)
        else:
            if child.text is not None:
                statement += text
                if root.tag == "doc":
                    if i < len(root) - 1:
                    	statement += ";"
                    else:
                    	statement += "."
                else:
                    if i < len(root) - 1:
                    	statement += ","
                    else:
                    	statement += ";"
            print(statement)


root = etree.parse("smallset.xml").getroot()

print("@prefix entity: <http://moviesDB.com/entity>.")
for e in ["doc", "genre", "person"]:
	print("@prefix " + e + ": <http://moviesDB.com/entity/" + e + ">.")

print("@prefix predicate: <http://moviesDB.com/predicate>.")
#print("@prefix foaf: <http://xmlns.com/foaf/0.1/>.")
print("@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns>.")

for genre in {g.text for g in root.xpath("//genre")}:
	print('genre:' + genre.replace(" ", "_") + ' predicate:name "' + genre + '".')

display(root)

for person in {p.text for p in list(itertools.chain(*[root.xpath("//" + query) for query in ["producer", "actor", "writer", "editor", "director", "composer"]]))}:
	print("person:" + person.replace(", ", "_").replace(" (", "_").replace(")", "").replace(" ", "_").replace(".", "").replace("'", ""))
	print('  predicate:name "' + person + '";')
	print('  rdf:type entity:person.')
	
	
