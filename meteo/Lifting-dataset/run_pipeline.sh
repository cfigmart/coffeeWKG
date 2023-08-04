 #!/bin/bash
# Input argument:
# - arg1: MongoDB collection name
# - arg1: path to raw weather observations files (csv files)
# - arg3: xR2RML mapping file
# - arg4: output file name
#
# Author: Nadia Yacoubi Ayadi, University Cote d'Azur, CNRS, Inria
# Inspired from scripts written by Franck Michel (https://github.com/frmichel)
# Licensed under the Apache License, Version 2.0 (http://www.apache.org/licenses/LICENSE-2.0)
 
. ./ENV.sh

. ./last_update.sh
log() {
    echo "[$(date '+%F %T')] $1"
}

help()
{
  exe=$(basename $0)
  echo "Usage: $exe <MongoDB collection> <Path Directory> <xR2RML mapping> <output file name>"
  echo "Example:"
  echo "   $exe  ColObservations2021 mapping_observation_tpl.ttl  observations2021.ttl"
  exit 1
}

echo "==========================================================================="


collection=$1
if [[ -z "$collection" ]] ; then help; fi

dirpath=$DIR
if [[ -z "$dirpath" ]] ; then help; fi

log "Preprocessing and Importing files into MongoDB..."

cd mongo

python3 preprocess.py $collection $dirpath


log "Generating RDF files..."

cd ..
cd xr2rml

mappingTemplate=$2
if [[ -z "$mappingTemplate" ]] ; then help; fi

rm $DATASET_DIR/*

output=$DATASET_DIR$3
if [[ -z "$output" ]] ; then help; fi

./run_xr2rml.sh $collection $mappingTemplate $output 


log "Loading in Virtuoso Triple Store"

cd ..
cd virtuoso

touch import-virtuoso$LASTupdateY$LASTupdateM.sh

echo 'export LASTupdateY="'$LASTupdateY'"\nexport LASTupdateM="'$LASTupdateM'"' > import-virtuoso$LASTupdateY$LASTupdateM.sh

echo '/database/virtuoso-import.sh  --graph "http://ns.inria.fr/meteo/observation/'$LASTupdateY'" --path /dataset *.ttl' > import-virtuoso$LASTupdateY$LASTupdateM.sh

docker exec -it weatherkg-docker bash ./import-virtuoso$LASTupdateY$LASTupdateM.sh
