const {Command, flags} = require('@oclif/command')

var path = require('path'), 
    fs = require('fs'), 
    yaml = require('js-yaml'),
    chalk = require('chalk'),
    child_process = require('child_process');


    const services = ['api', 'users', 'auth', 'monitoring', 'db', 'nats', 'traefik', 'jaeger', 'userapp', 'wallets'];


class StopCommand extends Command {
  static args = [
    {
        name: 'service',
        description: 'service name',
        options: services,
        required: false
    },
  ]
  
  async stopCompose(serviceName) {
    const self = this;
    return new Promise( (resolve, reject) => {
      
      const command = `docker-compose`;
      const attr = ["rm", "-sf"].concat(serviceName? [serviceName] : services);
      
      // const command = `pwd`;
      const child = child_process.spawn(command, attr);
      child.on('exit', (code, signal)=>{
          //if (code===0) self.runCompose(serviceName);
          if (code===0)  { 
            resolve()
          } else {
            reject()
          }
      });

      child.on('error', function(e) {
          console.log("ERROR", chalk.red(JSON.stringify(e)));
      })
      
      child.stdout.on('data', (data) => {
          console.log(chalk.reset(data.toString("utf8")));
      });
    
      child.stderr.on('data', (data) => {
          console.log(chalk.yellow(data.toString("utf8")));
      });
    })
    
  }

  async run() {
    //console.log(">>STOP321", this)
    const {flags, args} = this.parse(StopCommand)
    //console.log(">>STOP", args)
    var configYaml = {};
    try {
        const fileConfigYaml = fs.readFileSync('./global/config.yaml', 'utf8');
        configYaml = yaml.load(fileConfigYaml);
    } catch(e) {
        console.log(chalk.red(`ERROR in global/config.yaml: ${e.reason}`));
        console.log(e.message);
        return;
    }

    if (configYaml.mode === 'compose') {
        return this.stopCompose(args.service);
    }
  }
}

StopCommand.description = `Stop component(s)
...

`

StopCommand.flags = {
  // name: flags.string({char: 'n', description: 'name to print'}),
}

module.exports = StopCommand
