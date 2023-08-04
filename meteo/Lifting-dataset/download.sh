
#!/bin/bash

. ./last_update.sh

. ./ENV.sh

if [[ "${LASTupdateM:0:1}" = "0" ]] 
then 
    if [[ "${LASTupdateM:1:1}" != "9" ]] 
    then
        m=${LASTupdateM:1:1}
        LASTupdateM=${LASTupdateM:0:1}$(( m + 1 ))
    else
    LASTupdateM=$((10#09+1))
    fi 
else 
    if [[ "${LASTupdateM}" != "12" ]]
    then
    LASTupdateM=$(( $LASTupdateM + 1 ))
    else 
    LASTupdateY=$(( $LASTupdateY + 1 ))
    LASTupdateM="01"
    fi
fi
    
echo 'export LASTupdateY="'$LASTupdateY'"\nexport LASTupdateM="'$LASTupdateM'"' > last_update.sh

NEWDATE=$LASTupdateY$LASTupdateM
wget $URL."$NEWDATE".csv.gz

mv synop."$NEWDATE".csv.gz synop"$NEWDATE".csv.gz
gunzip synop"$NEWDATE".csv.gz

mkdir -p "$DIR"csv

mkdir -p "$DIR"json

mv synop"$NEWDATE".csv "$DIR"csv/synop"$NEWDATE".csv

