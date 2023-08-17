# CoffeeWKG: A Weather Knowledge Graph for Coffee Regions in Colombia 

CoffeeWKG is an RDF knowledge graph focused on weather conditions in the coffee-growing regions of Colombia over 15 years (2006-2020) to facilitate the understanding of climate impacts on coffee crops. Our knowledge graph enables the integration of heterogeneous sensor data collected from different weather stations and the definition of semantic metadata on agro-climatic parameters. Our knowlege graph obtained weather data from [Cenicafé yearbooks](https://www.cenicafe.org/es/index.php/nuestras\_publicaciones/anuarios\_meteorologicos) which includes daily aggregate values of weather parameters such as air temperature, relative air humidity, solar exposure, and cumulative precipitation. 

This project is based on the [WeKG-MF](https://github.com/Wimmics/weather-kg/tree/main/meteo) a knowledge graph for meteorological observational data in France created by the [Wimmics](https://team.inria.fr/wimmics/), a joint research team between INRIA Sophia Antipolis - Méditerranée and I3S (CNRS and Université Côte d'Azur)

The WeKG-MF namespace is ```http://ns.inria.fr/meteo/```. 

# Documentation  

### [RDF Data Modeling](https://github.com/Wimmics/weather-kg/tree/main/meteo/ontology)

## Downloading 

**CoffeeWKG is available as RDF dumps (in Turtle syntax) from Zenodo :** [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.8237867.svg)](https://doi.org/10.5281/zenodo.8237867)

You can query and use our CoffeeWKG konwledge graph creating your local SPARQL enpoing with [openLink Virtuoso Docker Image](https://hub.docker.com/r/openlink/virtuoso-opensource-7) or with [Apache Jena Fuseki](https://jena.apache.org/download/) 


SPARQL queries are provided in ```sparql-examples``` directory and serves as illustrative examples showing how data is retreived from the CoffeeWKG graph. 

Statistics about WeaKG-MF is provided as follows :

| Resoruces  | No. of RDF triples |
| ------------- | ------------- |
| Triples  | 2625.361  |
| Weather Stations | 62 |
| Observations | 786.513 |
| Agroclimatic properties | 6 |


## Project Structure 

- Intial CSV files for weather stations and weather observations are located at: CoffeeWKG/Lifting-dataset/appli/raw-files/csv_processed
- WeKG-modular-ontology is located at WeKG-modular-ontology
- preprocess_observations.py and preprocess_stations.py Preprocessing files to convert CSVs to JSON and upload to MongoDB located at: CoffeeWKG/Lifting-dataset/mongo
- Mapping file for weather stations: mapping_station_fnc.ttl is located at CoffeeWKG/Lifting-dataset/xr2rml
- Mapping file for weather observations: mapping_observation_fnc.ttl is located at CoffeeWKG/Lifting-dataset/xr2rml
- - Sample SPARQL queries are located at spartql-samples folder

## Convert the CSV data to RDF Graph

This process assumes that you have MongoDB installed: 

1. To convert your dataset into RDF first you have to convert the csv file into a json file using this command done in the mongo folder:
python preprocess_stations.py SynopStations ../appli/raw-files/
2. Verify that you have the following folders appli,appli/raw-files, appli/raw-files/csv and appli/raw-files/json. You also have to launch a mongoDB instance (Mongoosh is very useful to deal with mongoDb in a command prompt).
3. If it works, you should find a new json file in the appli/raw-files/json.
4. Go to the xr2rml folder and execute: java -Xmx20g -Dlog4jconfiguration=file:./log4j.properties -jar morph-xr2rml-dist-1.3.1-jar-with-dependencies.jar --configDir . --configFile xr2rml.properties --mappingFile mapping_station_fnc.ttl --output result_stations_fnc.ttl the last argument is the name of the output file.
5. The same procedure for weather observations. Therefore you should execute: python preprocess_observations.py SynopWeather10 ../appli/raw-files/
6. Lifting observations data from JSON to RDF java -Xmx20g -Dlog4jconfiguration=file:./log4j.properties -jar morph-xr2rml-dist-1.3.1-jar-with-dependencies.jar --configDir . --configFile xr2rml.properties --mappingFile mapping_observation.ttl --output result_observations_fnc.ttl
