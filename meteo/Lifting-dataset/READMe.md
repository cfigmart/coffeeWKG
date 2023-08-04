## Transforming weather reports into RDF data is fully automatic. 

1. First, use the ```download.sh``` script to download last monthly weather reports available on the Website of Meteo-France. Please update the variables in ```ENV.sh``` script and specify the path directory in which downloaded weather reports will be stored.   
2. Run the ```run_pipeline.sh``` script to transform the downloaded into RDF data compliant with the proposed semantic model. Please update environment variables in ```ENV.sh``` script depending on your path directory. Make Sure that you have a path directory for raw weather reports and another path directory for the RDF data generated.
3. Load RDF data in a Virtuoso triple store by running the Script [virtuoso/import-weather-dataset.sh](virtuoso/import-weather-dataset.sh).     
