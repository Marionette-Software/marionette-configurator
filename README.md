#### By accessing this or any other repository related to Marionette Software, you acknowledge and agree to abide by the terms and conditions of the'TuneX LLC Marionette Software Creative Commons CC-BY-NC-ND-4.0 International Public License' governing the use of this software.

#### License Agreement: [Read here](https://github.com/Marionette-Software/marionette-configurator/tree/main?tab=License-1-ov-file#tunex-llc-marionette-software-creative-commons-cc-by-nc-nd-40-international-public-license)

#### Contact Licensor: 
#### E-mails: admin@tunex.io / humans@marionette.dev // Website: https://marionette.dev/

#### More information about GitHub release VS Commercial License: https://marionette.dev/test-drive/

## Marionette Configurator

**Marionette Configurator** - is a toolset to generate deployment configuration

![Marionette Configurator Diargam](docs/diagram.drawio.svg)

## Inside

- User's configuration file `global/config.yaml`
- Handlebars templates
- NodeJS CLI tool `m` that generates deployment configuration

## Get Stated

Please read full guideline of configuration process from scratch on our official portal with [documentation](https://tunex.atlassian.net/wiki/x/AYBcAg)

Start in 5 rows:

```shell
nvm use 20
(cd tool && npm install)
# ... setup your values in global/config.yaml ...
./m render-config
docker compose up
```
