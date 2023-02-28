#!/bin/bash


debug() {
    echo "$@" 1>&2;
}

exec_termsuite() {

    # input texts directory 
    INPUT_CORPUS=$1
    
    # Termsuite runtime jar
    JAR=$(ls /opt/termsuite-core-*.jar)
    # tempory dir inside the container for storage
    OUTPUT_HOME=/tmp/  # docker-ws version

    # check if input text exist
    if [ -d "${INPUT_CORPUS}" ]; then

        TOKEN=`basename ${INPUT_CORPUS}`_result
        OUTPUT_PATH=${OUTPUT_HOME}${TOKEN}
        NBR_TXT=$(ls -A ${INPUT_CORPUS} | wc -l)

        if [ "${NBR_TXT}" -gt 0  ]; then
            # file result
            mkdir -p ${OUTPUT_PATH}
            F_RESULT=${TOKEN}.tsv
            F=${OUTPUT_PATH}/${F_RESULT}

            #   1 - execution termsuite 
            java -Xms16g -Xmx48g -cp ${JAR} fr.univnantes.termsuite.tools.TerminologyExtractorCLI  -c  ${INPUT_CORPUS} --tsv $F -l en -t /opt/treetagger &
            # async mode
            message="execution in progress for [${NBR_TXT}] doc..."
            echo '{"value":"'${message}'", "code":0}'

            wait # waits for all child background jobs to complete.

        else
            debug "$0 error : code 1"
            message="$[{NBR_TXT}] doc , no input data"
            echo '{"value":"'${message}'", "code":1}'
            exit 1
        fi
    
    else
            debug "$0 error : code 1"
            message="input directory [${INPUT_CORPUS}] not exist"
            echo '{"value":"'${message}'", "code":1}'
            exit 1

    fi

    # termsuite hors docker-ws
    #~/termsuite/termsuite-docker/bin/termsuite extract  -c  ${INPUT_CORPUS} -l en  --tsv  $F
    # storage for the final result
    endpoint_storage=${WEBDAV_URL}

    #   2 -  reg the result on the storage
    # check if a result exist to send
    if [ -s "${F}" ]

    then
        RES=${endpoint_storage}${F_RESULT}.gz
        debug "$0 save result into $F"
        gzip -c $F | \
        curl -s -u "${WEBDAV_USER}:${WEBDAV_PAS}"  --proxy ""  -X PUT  --data-binary @- "${RES}"  -o /dev/null && \
        echo '{"value":"'${RES}'", "code":0}'

        debug "sending result file ${F_RESULT}.gz to ${endpoint_storage}" && \
        debug "rm -rf ${INPUT_CORPUS}  ${OUTPUT_PATH}"  && \
        rm -rf ${INPUT_CORPUS}  ${OUTPUT_PATH} > /dev/null  # delete input and output file from tmp
        
    else
        debug "$0 error : code 1"
        message="no data to delivery"
        echo '{"value":"'${message}'", "code":1}'
        exit 1
    fi    

}

debug "$0 is waiting for data"

while IFS= read -r line; do
    debug "$0 receive ${line} - exec_termsuite $1"
    exec_termsuite $1 
done < <(cat -)
