#!/bin/bash
curl -G 'http://localhost:5001/sparql' \
     --data-urlencode query='
PREFIX dcat: <http://www.w3.org/ns/dcat#>
PREFIX dct: <http://purl.org/dc/terms/>

SELECT *
WHERE {
?d a dcat:Dataset . ?c a dcat:Catalog .
?c dcat:dataset ?d . ?d dct:qualFreq ?qf .
?d dct:metadataDate ?md.
OPTIONAL {
?d a dcat:Dataset . ?c a dcat:Catalog .
?c dcat:dataset ?d . ?d dct:qualFreq ?qf .
?d dct:metadataDate ?md.
?d_ a dcat:Dataset . ?c_ a dcat:Catalog .
?c_ dcat:dataset ?d_ . ?d_ dct:qualFreq ?qf_ .
?d_ dct:metadataDate ?md_ .
FILTER (?qf_ <= ?qf && ?md_ >= ?md && ?c_=?c && (?qf_ < ?qf || ?md_ > ?md)) }
FILTER(! BOUND(?d_)) }'
