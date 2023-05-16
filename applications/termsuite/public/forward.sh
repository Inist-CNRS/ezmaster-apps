#!/bin/bash
while IFS='$\n' read -r line; do

    #  TODO Controle PARAM
	WEBHOOK=$(echo $line|node -pe 'JSON.parse(fs.readFileSync(0)).webhook')
	FILE_RESULT=$(echo $line|node -pe 'JSON.parse(fs.readFileSync(0)).result')
	SIZE=$(echo $FILE_RESULT|wc -l)
	GENERATED=$(date "+%D:%T")
	MESSAGE=$(cat <<-END
    "filename": "${FILENAME}", "size": "${SIZE}","send": "${GENERATED}","webhook":"${WEBHOOK}",
END
)
	curl -s -H "Content-Type: application/json" -d "${FILE_RESULT}" "${WEBHOOK}"
	
done < <(cat -)
