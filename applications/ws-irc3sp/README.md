# ws-irc3sp@1.0.0

IRC3: Indexation par Recherche et Comparaison de Chaînes de Caractères

Applied on **sp**ecies.

## Test

```bash
curl -X POST "http://localhost:31976/v1/irc3sp" \
     -H  "accept: application/json" -H  "Content-Type: application/json" \
     -d "[{\"id\":1,\"value\":\"Trophic diversity accumulation curves of (a) Pseudopercis semifasciata, (b) Acanthistius patachonicus and (c) Pinguipes brasilianus. Horizontal lines show Brillouin diversity index (Hz) values (Hz± 0·05 Hz) and the vertical line shows a value n- 2 (n = number of stomachs).\"},{\"id\":2,\"value\":\"Phasianus colchicus/versicolor: in our study, the best match.\"},{\"id\":3,\"value\":\"short lower jaw in Etheostoma bellator Suttkus\"}]"
```
