To convert your dataset into RDF first you have to convert the csv file into a json file thank to this command done in the mongo folder:

python preprocess.py SynopStations ../appli/raw-files/

You have to create first the folder appli,appli/raw-files, appli/raw-files/csv and appli/raw-files/json. You also have to launch a mongoDB instance (Mongoosh is very useful to deal with mongoDb in a command prompt).

Then, if it works, you should find a new json file in the appli/raw-files/json.

Next step you go to the xr2rml folder and launch:

java -Xmx20g -Dlog4jconfiguration=file:./log4j.properties -jar morph-xr2rml-dist-1.3.1-jar-with-dependencies.jar --configDir . --configFile xr2rml.properties --mappingFile MappingStation.ttl --output stations.ttl

the last argument is the name of the output file.

And normally you should have your rdf database.

If you are lucky, maybe just launching the run_pipeline.sh can be enough…


Weather Stations: 
Preprosessing data from csv to JSON
python preprocess.py SynopStations ../appli/raw-files/     

Lifting data: from JSON to RDF
java -Xmx20g -Dlog4jconfiguration=file:./log4j.properties -jar morph-xr2rml-dist-1.3.1-jar-with-dependencies.jar --configDir . --configFile xr2rml.properties --mappingFile MappingStation.ttl --output stations.ttl


Observations: 
Preprosessing data from csv to JSON
python preprocess.py SynopWeather10 ../appli/raw-files/     

Lifting data: from JSON to RDF
java -Xmx20g -Dlog4jconfiguration=file:./log4j.properties -jar morph-xr2rml-dist-1.3.1-jar-with-dependencies.jar --configDir . --configFile xr2rml.properties --mappingFile mapping_observation.ttl --output observations_col.ttl