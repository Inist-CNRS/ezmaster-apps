

#!/bin/sh
set +x
#
# ./termsuite-ezsapp/public/test_launcher_extraction.py.sh
#
# example :
#   python3 launch_extraction.py  "/home/schneist/app/ezts/test/data/txt_local" --output "/home/schneist/app/ezts/test/data/results.tsv" --url https://webhook.site/12786bef-e62f-4508-a06a-aa63606c0f6b  --topn 50  --lang "en"
#
#
echo ""
echo "----------------------------------------------------------"
echo "Run Full test"

cp -rf test/data/txt_local_gold/ test/data/txt_local/ \

URL="https://webhook.site/0c9f044b-d279-4eb9-8e99-0d4760c2d002"

python3 ./termsuite-ezsapp/public/launch_extraction.py  "/home/schneist/app/ezts/test/data/txt_local" \
--output "results" \
--url $URL \
--topn 50 \
--lang "en"

echo "Finished: file send to the webhook  $URL"
