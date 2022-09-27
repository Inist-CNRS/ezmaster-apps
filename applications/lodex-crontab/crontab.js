const path = require('path');
const fs = require('fs');
const schedule = require('node-schedule');
const shell    = require('shelljs');
const { tasks, environnement } = require('./config.json');
const env = Object.assign(process.env, environnement);
const appDir = process.cwd();
const publicDir = path.resolve(process.cwd(), 'public');
const shellOptions = {
  silent: !Boolean(process.env.CRON_VERBOSE),
  env,
};
const run = (Target, FileName, Startup) => () => {
  if (FileName) {
    const ini = path.resolve(process.cwd(), 'public', `${FileName}.ini`);
    fs.lstatSync(ini);
    process.stdout.write(`\nProcessing  ${ini}\n`);
    const command = `ezs -e --param Startup="${Startup ? Startup : ''}" --param FileName="${FileName}" ${ini}`;
    shell.cd(appDir);
    shell.exec(command, shellOptions);
    return;
  }
  if (Target) {
    process.chdir(publicDir)
    process.stdout.write(`\nLaunching make ${Target}\n`);
    const command = `Startup="${Startup ? Startup : ''}" Target="${Target}" make ${Target}`;
    shell.cd(publicDir);
    shell.exec(command, shellOptions);
    return;
  }
  process.chdir(publicDir)
  process.stdout.write(`\nLaunching make\n`);
  const command = `Startup="${Startup ? Startup : ''}" make`;
  shell.cd(publicDir);
  shell.exec(command, shellOptions);
  return;
};

tasks.map(({ CronRule, Target, FileName }) => schedule.scheduleJob(CronRule, run(Target, FileName, false)));
tasks.filter(task => task.RunOnStartup).map(({ Target, FileName }) => run(Target, FileName, true)());
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
