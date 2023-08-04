## Competency Questions

We validate and evaluate the consistency of the WeKG-MF model and its ability to address requirements and cover the domain by providing SPARQL queries to answer a set of competency questions. We present some of them in following:

### CQ1 

- What is the measurement unit of a given weather parameter? 

```
PREFIX qudt: <http://qudt.org/schema/qudt/>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX weo: <http://ns.inria.fr/meteo/ontology/> 
PREFIX wep: <http://ns.inria.fr/meteo/ontology/property/> 
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>
select * where {
  ?x a weo:WeatherProperty; skos:prefLabel ?l.
  OPTIONAL {?x qudt:applicableUnit ?u}
  OPTIONAL {?x wep:applicableWMOcode  ?u}
}
```
### CQ2 

- At which time of the day was the highest value of a weather parameter measured (observed)?

```
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
PREFIX sosa: <http://www.w3.org/ns/sosa/>
PREFIX wep: <http://ns.inria.fr/meteo/ontology/property/>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX weo: <http://ns.inria.fr/meteo/ontology/>
PREFIX wevp: <http://ns.inria.fr/meteo/vocab/weatherproperty/> 

SELECT ?date ?heure ?station ?temp_max
{ 
    {
    SELECT ?date  ?s  (MAX(?v) as  ?temp_max) 
    
    WHERE 
    {
        ?obs a  weo:MeteorologicalObservation; 
        sosa:observedProperty wevp:airTemperature ;
        sosa:hasSimpleResult  ?v; 
        wep:madeByStation ?s ;
        sosa:resultTime ?t . 
        BIND(xsd:date("2020-08-01") as ?date)
        FILTER( xsd:date(?t) = ?date)
    } 
       GROUP BY ?s ?date 
    } 
    ?obs a  weo:MeteorologicalObservation; 
    sosa:observedProperty wevp:airTemperature ;
    sosa:hasSimpleResult  ?temp_max; 
    wep:madeByStation ?s ;
    sosa:resultTime ?t .
    ?s rdfs:label ?station  .
    FILTER(xsd:date(?t)= ?date)
    BIND(HOURS(?t) as ?heure) 
}
```

### CQ3 

- What is the closest weather station to a specific spatial location?

```
PREFIX geo:        <http://www.w3.org/2003/01/geo/wgs84_pos#> 
PREFIX weo:        <http://ns.inria.fr/meteo/ontology/> 
PREFIX geosparql:  <http://www.opengis.net/ont/geosparql#> 
PREFIX geof:       <http://www.opengis.net/def/function/geosparql/>
PREFIX uom:        <http://www.opengis.net/def/uom/OGC/1.0/>

SELECT  ?label ?lat ?long ?coordinates WHERE {
        ?x rdfs:label ?label ;
           geosparql:hasGeometry [ geosparql:asWKT ?coordinates];
           geo:lat ?lat; geo:long ?long .
        BIND("Point(0.1413499 45.1423348)"^^geosparql:wktLiteral as ?Currentposition)
        BIND (geof:distance(?coordinates,?Currentposition , uom:metre) as ?distance)     
        
    }
    ORDER BY ?distance
    LIMIT 1
```

### CQ4

- For a specific french region (identified by an INSEE region code), provide average daily air temperatures in Celsius for each station and over a period of time.

```
PREFIX dct: <http://purl.org/dc/terms/>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX sosa: <http://www.w3.org/ns/sosa/>
PREFIX wdt: <http://www.wikidata.org/prop/direct/>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
PREFIX wep: <http://ns.inria.fr/meteo/ontology/property/>
PREFIX weo: <http://ns.inria.fr/meteo/ontology/>
prefix wevp: <http://ns.inria.fr/meteo/vocab/weatherproperty/>

SELECT ?date  ?stationName  ?station ?label  ((?temp_max+?temp_min)/2.0 as ?temp_avg)
{
  SELECT ?date ?label ?station ?stationName (MIN(?vt) - 273.15 as ?temp_min) (MAX(?vt)- 273.15 as ?temp_max)
  {
      ?obs a weo:MeteorologicalObservation;
      sosa:observedProperty wevp:airTemperature;
      sosa:hasSimpleResult ?vt;
      sosa:resultTime ?t;
      wep:madeByStation ?station .
      ?station rdfs:label ?stationName; dct:spatial [ wdt:P131 [rdfs:label ?label ; wdt:P2585 '75']].
      BIND(xsd:date(?t) as ?date)
      FILTER(xsd:date(?t) >= xsd:date("2019-04-01"))
      FILTER(xsd:date(?t) <= xsd:date("2019-05-20"))                    
  }
 GROUP BY ?date ?station  ?label  ?stationName
}
ORDER BY ?date
```
### CQ5 

- For a specific french region (identified by an INSEE region code), provide average daily wind speed for each station and over a period of time.

```
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
PREFIX sosa: <http://www.w3.org/ns/sosa/>
PREFIX qudt: <http://qudt.org/schema/qudt/>
PREFIX wep: <http://ns.inria.fr/meteo/ontology/property/>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX weo: <http://ns.inria.fr/meteo/ontology/>
PREFIX dct: <http://purl.org/dc/terms/>
PREFIX wdt: <http://www.wikidata.org/prop/direct/>
PREFIX wevp: <http://ns.inria.fr/meteo/vocab/weatherproperty/>
 
select ?date ?stationID ?stationName ?region (CONCAT((avg(?v)  as ?avg), " ", "m/s") AS ?avg_speed_wind)  where {
 ?obs a  weo:MeteorologicalObservation;
 sosa:observedProperty wevp:windAverageSpeed;
 sosa:hasSimpleResult  ?v;
 wep:madeByStation ?station ;
 sosa:resultTime ?t .
 ?station weo:stationID ?stationID; rdfs:label ?stationName; dct:spatial [ wdt:P131 [rdfs:label ?region; wdt:P2585 '76']].
 BIND(xsd:date(?t) as ?date)
 FILTER(xsd:date(?t) >= xsd:date("2019-04-01"))
 FILTER(xsd:date(?t) <= xsd:date("2019-04-30"))
}
GROUP BY ?stationID ?date ?region ?stationName
ORDER BY ?date
```
