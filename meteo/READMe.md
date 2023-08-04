I'm going to update this read.me once I've finished the paper and the code. 

# A Weather Knowlege Graph of Météo-France Archives

The Météo-France RDF Weather dataset (WeKG-MF) is an RDF knowledge graph that provides access to meteorological measurements provided by 62 Météo-France weather stations located in different regions in metropolitan France and overseas departments. The dataset incorporates measurements of several weather parameters such as wind direction and speed, air pressure, precipitations, humidity and air temperature. These measurements are provided every three hours per day.

The WeKG-MF namespace is ```http://ns.inria.fr/meteo/```. 

# Documentation  

### [RDF Data Modeling](https://github.com/Wimmics/weather-kg/tree/main/meteo/ontology)

### [Generation Pipeline](https://github.com/Wimmics/weather-kg/tree/main/meteo/Lifting-dataset)

## Downloading and SPARQL querying 

**A new version of WeaKG-MF is now available ! Please download RDF dumps (in Turtle syntax) from Zenodo :** [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.5925413.svg)](https://doi.org/10.5281/zenodo.5925413)

It can also be queried through our Virtuoso SPARQL endpoint:   [http://weakg.i3s.unice.fr/sparql](http://weakg.i3s.unice.fr/sparql)

In order to re-use the WeKG dataset and create your local SPARQL endpoint, we recommend to use the [openLink Virtuoso Docker Image](https://hub.docker.com/r/openlink/virtuoso-opensource-7). We provide scripts availabe in ```Lifting-dataset/virtuoso``` repository to upload the downloaded WeaKG RDF datasetin different named graphs. Use the script ```import-weather-dataset``` as main entry point. 

Several SPARQL queries are provided in ```sparql-examples``` directory and serves as illustrative examples showing how data is retreived from the WeaKG graph. A Jupyter Notebook ```WeaKG-MFQuerying.ipynb``` demonstrates how the results of some SPARQL queries can be used to generate visualizations very useful for experts in different domains. 

Statistics about WeaKG-MF is provided as follows :

| Named Graph  | No. of RDF triples |
| ------------- | ------------- |
| http://ns.inria.fr/meteo/ontology  | 193  |
| http://ns.inria.fr/meteo/vocab | 346 |
| http://ns.inria.fr/meteo/weatherstation | 794 |
| http://ns.inria.fr/meteo/observation/2021 | 20.604.775 |
| http://ns.inria.fr/meteo/observation/2020 | 20.868.650  |
| http://ns.inria.fr/meteo/observation/2019 | 20.832.677 |
| http://ns.inria.fr/meteo/observation/2018 | 19.684.672 |
| http://ns.inria.fr/meteo/observation/2017 | 20.539.699 |

## WeKG-MF Pipeline Generation

We provide a fully automatic pipeline that enables us the maintenance and update of the WeaKG graph with new weather data from the Météo-France organism. This pipeline allowed us to generate the WeKG dataset and then we reuse it to update the WeaKG knowledge graph over time. The pipeline involves several steps including the preprocessing and loading data in MongoDB database as JSON collections and their transformation in RDF data. The [Morph-xR2RML tool](https://github.com/frmichel/morph-xr2rml/) allows the generation of RDF data. 
 
The script ```run_pipeline.sh``` available in ```Lifting-dataset``` directory is the main entry point of the pipeline.

The script ```run_pipeline.sh``` needs 3 arguments: 
 
* JSON collection name: the CSV files of weather report downloaded from the Meteo-France Website are loaded as JSON collection in MongoDB.

* Mapping rules file : mappings files are available in ```Lifting-dataset/xr2rml```, e.g., mapping_observation_tpl.ttl

* Output file name : e.g, ```rdf-dataset-yyyy.ttl```

Example : 

```bash
./run_pipeline.sh collection022021 mapping_observation_tpl.ttl rdf-dataset-02-2021.ttl
```
More informations are available in ```Lifting-dataset```repository !
