const http = require('http');
const os = require('os');
const config = require('./config.json');

const deflect = (input) => (config.host[input] ? config.host[input] : input);
const maxLoad = parseInt(config.maxLoad || 10);
const maxMem = parseInt(config.maxMem || '95%');
const totalMem = os.totalmem();
const log = (message) => console.log('[', Date.now(), ']', message);

const server = http.createServer();
server.on('request', (request, response) => {
  const { headers, url } = request;
  const { method } = request;
  const mem = parseFloat(((totalMem - os.freemem()) * 100 / totalMem).toFixed(0));
  if (mem > maxMem) {
    response.writeHead(509);
    response.end();
    return log('509 - MAX MEM');
  }
  if (os.loadavg().shift() > maxLoad) {
    response.writeHead(509);
    response.end();
    return log('509 - MAX LOAD');
  }
  if (!headers.host) {
    response.writeHead(404);
    response.end();
    return log('404 - NO HOST');
  }
  const target = deflect(headers.host.split('.').shift());
  if (!target) {
    response.writeHead(400);
    response.end();
    return log('400 - NO TARGET');
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
      response.end();
      return log('500 - REQUEST ERROR');
    });
});
server.listen(3000);
