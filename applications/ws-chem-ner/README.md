# ws-chem-ner@3.0.1

## Requirements

Before building, ensure that the installed `certifi` is a recent one (in
[`Dockerfile`](./Dockerfile)).

## Build

Required: initialize environment variables:

- `WEBDAV_URL`
- `WEBDAV_LOGIN`
- `WEBDAV_PASSWORD`

> **Remember:** when using a webdav remote, the URL's protocol is `webdav`.
> **Remember:** Do not forget to export these environment variables.

Before calling `npm run build` or `npm start`.

> 📗 Suggestion: put them in `.env` file and don't forget to run `source .env`
> before calling `npm run build` or `npm start`.

## Test

```bash
curl -X POST "http://localhost:31976/v1/chem/tagger" \
     -H  "accept: application/json" -H  "Content-Type: application/json" \
     -d "[{\"id\":1,\"value\":\"This is three chemical name entity: methanol, 2-propanol, or CO2\"}]"
```
