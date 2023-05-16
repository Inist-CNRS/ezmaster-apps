#!/bin/bash
while IFS='$\n' read -r line; do

	source library
	
    # data  json stream  receive from collect procedure
    PROJECT=$(echo $line|node -pe 'JSON.parse(fs.readFileSync(0)).project')
	INPUT_CORPUS=$(echo $line|node -pe 'JSON.parse(fs.readFileSync(0)).corpus')
	TOKEN=$(echo $line|node -pe 'JSON.parse(fs.readFileSync(0)).token')
	LANG=$(echo $line|node -pe 'JSON.parse(fs.readFileSync(0)).language')
	TOPN=$(echo $line|node -pe 'JSON.parse(fs.readFileSync(0)).topn')
    WEBHOOK=$(echo $line|node -pe 'JSON.parse(fs.readFileSync(0)).webhook')
    PID=$PROJECT/$$	
    FILE_RESULT=${PROJECT}/result_${TOKEN}.tsv

	cmd="(
         (extract $PROJECT $INPUT_CORPUS $FILE_RESULT $LANG $TOPN $PID) &&
         (forward $PROJECT $FILE_RESULT $WEBHOOK $PID) && 
         (clean $PROJECT $PID))
         >> ${PID}.log 2>&1 &"
	eval $cmd
done < <(cat -)
echo "{\"extraction\":\"$(date "+%D:%T")\", \"result\":\"$FILE_RESULT\",  \"webhook\":\"$WEBHOOK\"  }"
