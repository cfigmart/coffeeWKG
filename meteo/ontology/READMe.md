
## WeKG Semantic Model


Based on a network of existing ontologies (SOSA/SSN, GeoSPARQL, QUDT, OWL-Time ontology, RDF data Cube Vocabulary), we define a reusable and self-contained semantic model that describes the semantics of meteorological data. The ```weo:MeterologicalObservation``` class is the core class of our model; it supports the description of a single, atomic observation. A meteorological observation is related to a particular feature of interest, instance of class ```weo:MeteorologicalFeature```, and an observable property, instance of class ```weo:WeatherProperty```. These three classes specialize the following SOSA/SSN classes: [sosa:Observation](https://www.w3.org/TR/vocab-ssn/#SOSAObservation), [sosa:ObservableProperty](https://www.w3.org/TR/vocab-ssn/#SOSAObservableProperty) and [sosa:FeatureOfInterest](https://www.w3.org/TR/vocab-ssn/#SOSAFeatureOfInterest) classes. The `weatherdataset-model.ttl` provides the formal definitions in OWL of each class in our model. 

We also propose a SKOS vocabulary of weather observable properties and features of interest commonly used in weather reports. The current version of the SKOS vocabulary in turtle syntax is provided in ```features-properties-vocabulaire.ttl```. The current version includes 6 features of interest (air, wind, surface, gust, cloud, precipitations) and 21 observable properties (temperature, wind speed, diffrential pressure, ...). 

```turtle
  wevp:windAverageSpeed
    a weo:WeatherProperty, qudt:QuantityKind, skos:Concept;
    ssn:isPropertyOf wevf:wind ;
    skos:broadMatch <http://vocab.nerc.ac.uk/collection/P07/current/CFSN0038/> ;
    skos:broadMatch <http://qudt.org/vocab/quantitykind/Speed>;
    qudt:applicableUnit <http://qudt.org/vocab/unit/M-PER-SEC> ;
    skos:prefLabel "Vitesse moyenne du vent 10mn"@fr ;
    skos:prefLabel "Average wind speed 10mn"@en ;
    wep:hasAbbreviation "ff".
 ```
Furthermore, some qualitative weather properties require the use of standard encoded values defined by the WMO. For instance, the ground state is a weather property whose possible values (dry, moist, etc.) are in a predefined set of values of the [WMO 0901 code](https://epic.awi.de/id/eprint/29967/1/WMO2011i.pdf). For each qualitative weather properties, we created a ```skos:Collection``` whose members represent the possible values of the weather property as described in the WMO documentation. These collections are defined in ```WMO-Thesaurus.ttl ```

Note that the model and vocabulary are intended to be adopted and extended by any meteorological data provider. 


## Prefixes of ontologies and vocabularies used in WeKG semantic model

| Prefix  | URI |
| ------------- | ------------- |
| geo  | http://www.w3.org/2003/01/geo/wgs84_pos#  |
| geosparql | http://www.opengis.net/ont/geosparql# |
| nerc | http://vocab.nerc.ac.uk/collection/P07/current/ |
| qudt | http://qudt.org/2.0/schema/qudt |
| qudt-unit | http://qudt.org/2.1/vocab/unit  |
| qudtkind | http://qudt.org/vocab/quantitykind/ |
| skos | http://www.w3.org/2004/02/skos/core#  |
| qb | http://purl.org/linked-data/cube# |
| sosa |http://www.w3.org/ns/sosa/  |
| ssn | http://www.w3.org/ns/ssn/ |
| time | http://www.w3.org/2006/time# |
| weo | http://ns.inria.fr/meteo/ontology/ |
| wep | http://ns.inria.fr/meteo/ontology/property/ |
| wevp | http://ns.inria.fr/meteo/vocab/weatherproperty/ |
| wevf | http://ns.inria.fr/meteo/vocab/meteorologicalfeature/ |
| wes | http://ns.inria.fr/meteo/observationslice/ |
| wes-dimension| <http://ns.inria.fr/meteo/observationslice/dimension#> |
| wes-measure| <http://ns.inria.fr/meteo/observationslice/measure#> |
| wes-attribute| <http://ns.inria.fr/meteo/observationslice/attribute#> |
