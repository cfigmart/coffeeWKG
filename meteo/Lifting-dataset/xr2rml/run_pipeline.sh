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
 


log() {
    echo "[$(date '+%F %T')] $1"
}


echo "==========================================================================="


collection=$1
if [[ -z "$collection" ]] ; then help; fi

dirpath=$2
if [[ -z "$dirpath" ]] ; then help; fi

python3 uploadMongoDB.py $collection $dirpath

cd xr2rml 

mappingTemplate=$3
if [[ -z "$mappingTemplate" ]] ; then help; fi

output=$4
if [[ -z "$output" ]] ; then help; fi

./run_xr2rml.sh $collection $mappingTemplate $output 

