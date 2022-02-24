const http = require('http');
const config = require('./config.json');

const deflect = (input) => (config.host[input] ? config.host[input] : input);

const server = http.createServer();
server.on('request', (request, response) => {
  const { headers, url } = request;
  const { method } = request;
  if (!headers.host) {
    response.writeHead(404);
    return response.end();
  }
  const target = deflect(headers.host.split('.').shift());
  if (!target) {
    response.writeHead(400);
    return response.end();
  }
  const [ hostname, port = config.port ] = target.split(':');
  const options = {
    hostname,
    port,
    path: request.url,
    method,
    headers,
  };
  request
    .pipe(http.request(options, (source) => {
      response.writeHead(source.statusCode, source.headers);
      source.pipe(response);
    }))
    .on('error', (e) => {
      if (!response.headersSent) {
        response.writeHead(500);
      }
      return response.end();
    });
});
server.listen(8000);
