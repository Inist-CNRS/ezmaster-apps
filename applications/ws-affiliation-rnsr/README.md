# ws-affiliation-rnsr@5.0.0

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
curl -X POST "http://localhost:31976/v2/affiliation/rnsr" \
     -H  "accept: application/json" -H  "Content-Type: application/json" \
     -d "[{\"id\":1,\"value\":\"UAR 76, Inist-CNRS, 2 rue Jean Zay 54500 Vandoeuvre-lès-Nancy\"},{\"id\":2,\"value\":\"Institut Charles Gerhardt, Université de Montpellier\"},{\"id\":3,\"value\":\"UMR 7272 - CNRS, 06100 Nice\"}]"
```
