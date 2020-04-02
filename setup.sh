#!/bin/bash
docker exec -t ontario /Ontario/scripts/create_rdfmts.py -s /configurations/datasources.json -o /configurations/config.json
