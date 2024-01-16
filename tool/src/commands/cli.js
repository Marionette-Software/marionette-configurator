/*
const { spawn } = require('child_process');
const child = spawn('docker-compose',);
process.stdin.pipe(child.stdin)
child.stdout.pipe(process.stdout)
child.stderr.pipe(process.stderr)
*/

const {Command, flags} = require('@oclif/command')
const RenderConfigCommand = require('./render-config')

var path = require('path'), 
    fs = require('fs'), 
    yaml = require('js-yaml'),
    chalk = require('chalk'),
    child_process = require('child_process');



class CliCommand extends Command {
  
  static args = [
    {

    },
  ]
  


    async run() {
        const attr =  ['exec', '-T', 'api', './node_modules/.bin/moleculer-runner', '-r']
        const command = `docker-compose`;
        const child = child_process.spawn(command, attr);
        process.stdin.pipe(child.stdin)
        child.stdout.pipe(process.stdout)
        child.stderr.pipe(process.stderr)

    }
  
}

CliCommand.description = `Start CLI tool
...

`

CliCommand.flags = {
  // name: flags.string({char: 'n', description: 'name to print'}),
}

module.exports = CliCommand
