const path = require('path');
const fs = require('fs');
const schedule = require('node-schedule');
const shell    = require('shelljs');
const { tasks, environnement } = require('./config.json');
const env = Object.assign(process.env, environnement);
const run = (FileName, Startup) => () => {
  const ini = path.resolve(process.cwd(), 'public', `${FileName}.ini`);
  fs.lstatSync(ini);
  process.stdout.write(`\nProcessing  ${ini}\n`);
  const command = `ezs -e --param Startup="${Startup ? Startup : ''}" --param FileName="${FileName}" ${ini}`;
  return shell.exec(command, {
    silent: !Boolean(process.env.CRON_VERBOSE),
    env,
  })
};

tasks.map(({ CronRule, FileName }) => schedule.scheduleJob(CronRule, run(FileName, false)));
tasks.filter(task => task.RunOnStartup).map(({ FileName }) => run(FileName, true)());
/*
WHEN FORMAT

*    *    *    *    *    *
┬    ┬    ┬    ┬    ┬    ┬
│    │    │    │    │    │
│    │    │    │    │    └ day of week (0 - 7) (0 or 7 is Sun)
│    │    │    │    └───── month (1 - 12)
│    │    │    └────────── day of month (1 - 31)
│    │    └─────────────── hour (0 - 23)
│    └──────────────────── minute (0 - 59)
└───────────────────────── second (0 - 59, OPTIONAL)

*/
