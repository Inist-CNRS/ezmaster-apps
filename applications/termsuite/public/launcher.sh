#!/bin/bash

debug() {
    echo "$@" 1>&2;
}

exec_termsuite() {

    INPUT_CORPUS=$1
    
    # Termsuite exec
    JAR=$(ls /opt/termsuite-core-*.jar)

    OUTPUT_HOME=/tmp/  # docker-ws version
    TOKEN=`basename $1`_result
    OUTPUT_PATH=${OUTPUT_HOME}${TOKEN}

    # name of the file result
    F_RESULT=result_${TOKEN}.tsv
    mkdir -p ${OUTPUT_PATH}
    
    # simple test
    #echo -n "one result " >> ${OUTPUT_PATH}/${F_RESULT} # simul out of docker : fake result file just for test 
    # termsuite en docker-ws
    java -Xms1g -Xmx2g -cp ${JAR} fr.univnantes.termsuite.tools.TerminologyExtractorCLI  -c  ${INPUT_CORPUS} --tsv ${OUTPUT_PATH}/${F_RESULT} -l en -t /opt/treetagger
    
    # termsuite hors docker-ws
    #~/termsuite/termsuite-docker/bin/termsuite extract  -c  ${INPUT_CORPUS} -l en  --tsv  ${OUTPUT_PATH}/${F_RESULT}


    # check if a result exist 
    if [ -s ${OUTPUT_PATH}/${F_RESULT} ]
    then
        debug "$0 save result into ${OUTPUT_PATH}/${F_RESULT}"
        echo '{"value":"'${OUTPUT_PATH}'", "code":0}'
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
