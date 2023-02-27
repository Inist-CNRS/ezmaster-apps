#!/bin/bash

debug() {
    echo "$@" 1>&2;
}

exec_termsuite() {

    INPUT_CORPUS=$1
    
    # Termsuite runtime jar
    JAR=$(ls /opt/termsuite-core-*.jar)

    # tempory dir inside the container for storage
    OUTPUT_HOME=/tmp/  # docker-ws version

    TOKEN=`basename $INPUT_CORPUS`_result
    OUTPUT_PATH=${OUTPUT_HOME}${TOKEN}

    # file result
    mkdir -p ${OUTPUT_PATH}
    F_RESULT=${TOKEN}.tsv
    F=${OUTPUT_PATH}/${F_RESULT}

    #   1 - execution termsuite 
    java -Xms8g -Xmx16g -cp ${JAR} fr.univnantes.termsuite.tools.TerminologyExtractorCLI  -c  ${INPUT_CORPUS} --tsv $F -l en -t /opt/treetagger &
    # async mode
    message="execution launching"
    echo '{"value":"'${message}'", "code":0}'

    wait # waits for all child background jobs to complete.

    # termsuite hors docker-ws
    #~/termsuite/termsuite-docker/bin/termsuite extract  -c  ${INPUT_CORPUS} -l en  --tsv  $F
    # storage for the final result
    endpoint_storage=${WEBDAV_URL}

    #   2 -  reg the result on the storage
    # check if a result exist 
    if [ -s $F ]

    then
        Res=${endpoint_storage}${F_RESULT}.gz
        debug "$0 save result into $F"
        gzip -c $F | \
        curl -s -u "${WEBDAV_USER}:${WEBDAV_PAS}"  --proxy ""  -X PUT  --data-binary @- "${Res}"  -o /dev/null && \
        echo '{"value":"'${Res}'", "code":0}'

        debug "sending result file ${F_RESULT}.gz to ${endpoint_storage}" && \
        debug "rm -rf ${INPUT_CORPUS}  ${OUTPUT_PATH}"  && \
        rm -rf ${INPUT_CORPUS}  ${OUTPUT_PATH} > /dev/null  # delete input and output file from tmp
        
    else
        debug "$0 error : code 1"
        message="no data to delivery"
        echo '{"value":"'${message}'", "code":1}'
    fi    

}

debug "$0 is waiting for data"

while IFS= read -r line; do
    debug "$0 receive ${line}"
    exec_termsuite $1 
done < <(cat -)
