# ezmaster-dokuwiki@1.0.5

Ollama for ezMaster

Based on
[ollama/ollama](https://github.com/ollama/ollama).

## Usage

Pull a model:

```bash
curl http://localhost:8000/api/pull -d '{
  "name": "phi3"
}'
```

Generate an answer:

```bash
$ curl http://localhost:8000/api/generate -d '{ "model": "phi3", "prompt": "Pourquoi le ciel est-il bleu?", "stream": false}'
{"model":"phi3","created_at":"2024-07-29T09:31:01.954312497Z","response":" Le ciel apparaît bleu pour plusieurs raisons liées aux propriétés de la lumière blanche et à la diffusion Rayleigh. La lumière blanche contient toutes les couleurs du spectre visible, similairement à un mélange des couleurs primaires (rouge, vert, bleue). Lorsque le soleil illumine l'atmosphère terrestre pendant une journée claire, la plupart de la lumière est violette et verte. Cependant, ces longueurs d'onde plus courtes sont absorbées ou réfractées par les particules atmosphériques plus petites (comme le dioxyde de carbone et l'oxygène) avant qu'elles n'atteignent le spectateur au sol.\n\n\nLes ondes lumineuses bleues, qui ont une longueur d'onde relativement courte par rapport à la rouge ou la verte, sont plus fréquemment dispersées dans toutes les directions par ces petites particules atmosphériques en raison de l'effet Rayleigh. Cela signifie que lorsque nous regardons le ciel directement vers le zénith pendant une journée lumineuse et claire sans nuages, la plupart des couleurs bleues dispersées par les molécules d'air seront dans notre champ visuel provenant de toutes les directions autour du soleil. Le résultat est que nous percevons le ciel comme étant principalement bleu car cette couleur domine lenergie lumineuse qui atteint nos yeux après diffusion multiple, particulièrement à des hauteurs où la densité atmosphérique et donc la probabilité de diffusion Rayleigh sont les plus élevées.","done":true,"done_reason":"stop","context":[32010,6803,339,7768,454,24850,707,29899,309,10767,29884,29973,32007,32001,951,24850,623,2518,13871,10767,29884,1671,10741,1153,14125,619,2406,3479,10850,28141,316,425,19703,5289,16568,1173,634,818,425,23253,9596,280,1141,29889,997,19703,5289,16568,1173,640,993,14984,966,3581,280,1295,868,6683,276,7962,29892,1027,4233,19211,818,443,286,3610,927,553,3581,280,1295,1903,7147,313,27537,479,29892,4837,29892,10767,434,467,19551,802,454,14419,309,4486,398,457,301,29915,271,7681,561,1908,27386,276,13180,1597,21824,1318,3711,533,29892,425,715,786,442,316,425,19703,5289,707,28008,20200,634,24241,29889,27816,29892,7015,24286,1295,270,29915,13469,2298,2085,2167,3435,6425,11831,2406,2123,1841,29888,1461,2406,610,966,1936,2540,15489,561,4894,1912,2298,5697,3246,313,510,1004,454,20562,3594,311,316,1559,15933,634,301,29915,2251,4790,8146,29897,10042,439,29915,4999,302,29915,15127,647,296,454,6683,7289,782,899,29889,13,13,13,24560,373,2783,19703,457,6394,10767,1041,29892,1750,4625,1597,24286,332,270,29915,13469,14215,882,2085,371,610,13659,818,425,16053,479,2123,425,24241,29892,3435,2298,1424,21871,331,358,29106,2406,1465,14984,966,18112,610,7015,5697,3246,1936,2540,15489,561,4894,1912,427,18836,316,301,29915,12352,300,9596,280,1141,29889,315,3100,1804,28821,712,28194,8556,4880,787,454,24850,1513,882,1224,454,503,1690,389,13180,1597,21824,1318,19703,457,1509,634,3711,533,7209,4948,1179,29892,425,715,786,442,553,3581,280,1295,10767,1041,29106,2406,610,966,6062,29948,21337,270,29915,1466,724,609,1465,24145,18480,1998,2491,16413,424,316,14984,966,18112,26269,868,14419,309,29889,951,6896,499,271,707,712,8556,17189,29894,787,454,24850,4191,19154,3420,6311,10767,29884,1559,5278,3581,20519,2432,457,301,759,12053,19703,457,1509,1750,21609,524,7814,26809,7907,23253,2999,29892,16530,20564,818,553,447,1082,1295,6722,425,6245,2131,15489,561,20600,634,12866,425,23950,2131,316,23253,9596,280,1141,3435,966,2298,904,2608,2406,29889],"total_duration":43446861605,"load_duration":11921374,"prompt_eval_count":14,"prompt_eval_duration":627267000,"eval_count":378,"eval_duration":42806523000}                                                                   
```

List the loaded models:

```bash
curl http://localhost:8000/api/ps
```

Remove a model:

```bash
curl -X DELETE http://localhost:8000/api/delete -d '{ "name": "phi3" }'
```
