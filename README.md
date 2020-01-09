# Ontario Demo

To demonstrate Ontario SDL in action, we use the following setting:

### Data Sources
- GTFS: `RDF-Virtuoso`
- GTFS: `RDF-Virtuoso`

Demo folder contains:

- `./configureations/` - contains `datasources.json` and `config.json`. Note: `config.json` is created by the RDF-MT creation script. (see below)
- `./data.zip` - contains  sample datasets for `rdf` files.
- `./mappings` - contains sample mapping files for raw files in `./data`, i.e., for MySQL data and TSV files
- `./queries` - contains sample queries 
- `./docker-compose.yml` - file for creating three docker containers: `ontario`, `drugbankrdb`, and `keggrdf`

### Extract `./data.zip`
```bash
unzip data.zip
```

### Create the Semantic Data Lake
To create the containers, run the following:
```bash
 docker-compose up -d 
```

Wait for some seconds until the data is completely loaded:
Check logs of virtuoso:
```bash
....
17:32:22 Checkpoint started
17:32:22 Checkpoint finished, log reused
17:32:22 HTTP/WebDAV server online at 8890
17:32:22 Server online at 1111 (pid 103)
```

### Create RDF Molecule Templates (RDF-MT) - `myconfig.json`
After datasets are loaded, run the following script to create configuration file:

```bash
 docker exec -t ontario /Ontario/scripts/create_rdfmts.py -s /configurations/datasources.json -o /configurations/myconfig.json 
```

The above command creates the RDF-MT based source descriptions stored in `/configurations/myconfig.json`. 
Make sure the file exists by running the following command:
```bash
docker exec -t ontario ls /configurations
```

The excerpt from `myconfig.json` looks like as follows:

```json
{
  "templates": [
    {
      "rootType": "http://vocab.gtfs.org/terms#Shape",
      "predicates": [
        {
          "predicate": "http://www.w3.org/1999/02/22-rdf-syntax-ns#type",
          "range": [],
          "policies": [
            {
              "dataset": "gtfs-rdf",
              "operator": "PR"
            }
          ]
        },
        {
          "predicate": "http://www.w3.org/2003/01/geo/wgs84_pos#lat",
          "range": [],
          "policies": [
            {
              "dataset": "gtfs-rdf",
              "operator": "PR"
            }
          ]
        },
   ....
   ....
    {
      "name": "gtfs-rdf",
      "ID": "gtfs-rdf",
      "url": "http://rdfstore:8890/sparql",
      "params": {},
      "type": "SPARQL_Endpoint",
      "mappings": []
    },
    {
      "name": "gtfs5-rdf",
      "ID": "gtfs-rdf1",
      "url": "http://rdfstore5:8890/sparql",
      "params": {},
      "type": "SPARQL_Endpoint",
      "mappings": []
    }
  ]
}
```

You might see the following warning (not an error!):
```bash
WARNING: Couldn't create 'parsetab'. [Errno 20] Not a directory: '/usr/local/lib/python3.6/dist-packages/ontario-0.3-py3.6.egg/ontario/sparql/parser/parsetab.py'
```
### Execute a queries - `command-line`

```bash
./run.sh
```
Where `-r` indicates whether to print results (rows) or not.
The following queries are available for testing:

- `/queries/q3.rq`


Summary of execution (and raw results) will be printed on your terminal.
You can inspect `ontario.log` file as: `$ docker exec -t ontario less /Ontario/ontario.log` .


### Execute multiple queries
```bash
# docker exec -t ontario /Ontario/scripts/runOntarioExp.sh  [query_folder] [config_file] [result_file_name] [errors_file_name] [planonlyTrueorFalse] [printResultsTrueorFalse]
docker exec -it ontario /Ontario/scripts/runOntarioExp.sh /queries/simpleQueries /configurations/myconfig.json /results/result.tsv /results/error.txt False False
```
Summary of execution will be saved in `/results/result.tsv`. 
You can inspect it as: `$ docker exec -t ontario cat /results/result.tsv` ,
OR you can find the file in main directory of Ontario (since `\results`, `\configurations`, and others are bounded as volumes)