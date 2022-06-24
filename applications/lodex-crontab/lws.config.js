const { options } = require('./config.json');

module.exports = {
  //  "blacklist" : [ "(.*).ini" ],
  "indexView": "details",
  ...options
};
