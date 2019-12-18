#!/bin/bash
docker exec -t ontario /Ontario/scripts/create_rdfmts.py -s /configurations/datasources.json -o /configurations/myconfig.json
docker exec -t ontario /Ontario/scripts/runExperiment.py -c /configurations/myconfig.json -q /queries/q3.rq -r True
#docker exec -t ontario /Ontario/scripts/runExperiment.py -c /configurations/myconfig.json -q /queries/complexqueries/SQ2 -r True