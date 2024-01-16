const {Command, flags} = require('@oclif/command')
var path = require('path'), 
    fs = require('fs'), 
    Handlebars = require('handlebars'), 
    yaml = require('js-yaml'),
    base64 = require('base-64'),
    chalk = require('chalk');

class RenderConfigCommand extends Command {

  async run() {
    const {flags, args} = this.parse(RenderConfigCommand)
    // console.log("flags, args", flags, args)
    var configYaml = {};
    var barongPrivateKey = '';
    var barongPublicKey = '';
    try {
      const fileConfigYaml = fs.readFileSync('./global/config.yaml', 'utf8');
      configYaml = yaml.load(fileConfigYaml);
    } catch(e) {
      console.log(chalk.red(`ERROR in global/config.yaml: ${e.reason}`));
      console.log(e.message);
      return;
    }
    try {
      const fileBarongKey = fs.readFileSync('./config/secrets/key.pem', 'utf8');
      const filePubBarongKey = fs.readFileSync('./config/secrets/public.pem', 'utf8');
      barongPrivateKey = base64.encode(fileBarongKey);
      barongPublicKey = base64.encode(filePubBarongKey);
    } catch(e) {
      console.log(chalk.red(`ERROR key.pem in config/secrets: ${e.reason}`));
      console.log(e.message);
      return;
    }

    function fromDir(startPath,filter) {
        if (!fs.existsSync(startPath)) {
            console.log("no dir ",startPath);
            return;
        }

        var files=fs.readdirSync(startPath);
        for(var i=0;i<files.length;i++){
            var filename=path.join(startPath,files[i]);
            var stat = fs.lstatSync(filename);
            if (stat.isDirectory()){
                fromDir(filename,filter); //recurse
            }
            else if (filename.indexOf(filter)>=0) {
              
                var from = filename;
                
                var to = filename.slice(10 ,-2);
                try {
                  var input = fs.readFileSync(from, {encoding: 'utf8'});
                  
                  Handlebars.registerHelper('ifEquals', function(arg1, arg2, options) {
                    return (arg1 == arg2) ? options.fn(this) : options.inverse(this);
                  });
                  Handlebars.registerHelper('ifNotEquals', function(arg1, arg2, options) {
                    return (arg1 != arg2) ? options.fn(this) : options.inverse(this);
                  });
                  Handlebars.registerPartial('barong_private_key', barongPrivateKey);
                  Handlebars.registerPartial('barong_public_key', barongPublicKey);
                  var template = Handlebars.compile(input);
                  var result = template(configYaml);
                  fs.writeFileSync(to, result);
                  console.log(chalk.green(" Done"), "Render:", from, "=>" , to);
                } catch(e) {
                  console.log(chalk.red(`ERROR in ${from}`));
                  console.log(e.message)
                }
            };
        };
    };

    fromDir('./templates','.t');

  }
}

RenderConfigCommand.description = `Generate config and compose files
...
Based on templates folder
`

RenderConfigCommand.flags = {
  // name: flags.string({char: 'n', description: 'name to print'}),
}

module.exports = RenderConfigCommand
