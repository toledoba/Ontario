#!/bin/bash
curl -G 'http://localhost:6001/sparql' \
     --data-urlencode query='
PREFIX dcat: <http://www.w3.org/ns/dcat#>
PREFIX dct: <http://purl.org/dc/terms/>
PREFIX foaf: <http://xmlns.com/foaf/0.1/>
PREFIX org: <http://www.w3.org/ns/org#>
SELECT *  WHERE {
?DatasetURI a dcat:Catalog .

}'
