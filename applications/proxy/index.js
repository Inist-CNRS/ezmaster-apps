const recluster = require('recluster');
const path = require('path');

const cluster = recluster(path.join(__dirname, 'server.js'));
cluster.run();

process.on('SIGUSR2', function() {
    console.log('Got SIGUSR2, reloading cluster...');
    cluster.reload();
});
