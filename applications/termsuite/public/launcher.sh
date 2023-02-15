#!/bin/bash

debug() {
    echo "$@" 1>&2;
}

exec_termsuite() {

    INPUT_CORPUS=$1
    
    # Termsuite exec
    JAR=$(ls /opt/termsuite-core-*.jar)

    OUTPUT_HOME=/tmp/  # docker-ws version

    TOKEN=`basename $INPUT_CORPUS`_result
    OUTPUT_PATH=${OUTPUT_HOME}${TOKEN}

    # name of the file result
    F_RESULT=${TOKEN}.tsv
    mkdir -p ${OUTPUT_PATH}

    F=${OUTPUT_PATH}/${F_RESULT}
    # simple test
    #echo -n "one result " >> $F # simul out of docker : fake result file just for test 
    # termsuite en docker-ws
    java -Xms1g -Xmx2g -cp ${JAR} fr.univnantes.termsuite.tools.TerminologyExtractorCLI  -c  ${INPUT_CORPUS} --tsv $F -l en -t /opt/treetagger
    
    # termsuite hors docker-ws
    #~/termsuite/termsuite-docker/bin/termsuite extract  -c  ${INPUT_CORPUS} -l en  --tsv  $F

    endpoint_storage="http://vdrichtext.intra.inist.fr:7000/"

    # check if a result exist 
    if [ -s $F ]

    then
        Res=${endpoint_storage}${F_RESULT}.gz
        debug "$0 save result into $F"
        gzip -c $F | \
        curl -s -u "admin:inist1234"  --proxy ""  -X PUT  --data-binary @- "${Res}"  -o /dev/null && \
        echo '{"value":"'${Res}'", "code":0}'

        debug "sending result file  ${F_RESULT}.gz to ${endpoint_storage}" && \
        debug "rm -rf ${INPUT_CORPUS}  ${OUTPUT_PATH}"  && \
        rm -rf ${INPUT_CORPUS}  ${OUTPUT_PATH} > /dev/null  # delete input and output file from tmp
        

    else
        debug "$0 error : code 1"
        echo '{"value":"", "code":1}'
    fi    

}

debug "$0 is waiting for data"

while IFS= read -r line; do
    debug "$0 receive ${line}"
    exec_termsuite $1 
done < <(cat -)
