#### Welcome to Marionette Software Test Drive Configurator!

By accessing this repository, or any other repository related to Marionette Software (https://github.com/Marionette-Software), you understand and agree that the software in these repositories cannot be used for any commercial purposes without obtaining a separate commercial license from Licensor. "Commercial purposes" include, but are not be limited to, any use that involves generating revenue, profit, or financial gain directly or indirectly. You agree not to modify, adapt, translate, reverse engineer, decompile, disassemble, or create derivative works based on the Software. You agree not to remove or alter any copyright, trademark, or other proprietary notices from the Software. You agree not to rent, lease, loan, or sublicense the Software to any third party. You agree not to use the Software in a manner that violates any applicable laws or regulations. By accesssing the software in this reposotory, or any other repository related to Marionette Software, you agree to abide by the terms and conditions detailed in the 'TuneX LLC Marionette Software Creative Commons CC-BY-NC-ND-4.0 International Public License'.

#### TuneX LLC Marionette Software Creative Commons CC-BY-NC-ND-4.0 International Public License Agreement: [Read here](https://github.com/Marionette-Software/marionette-configurator/tree/main?tab=License-1-ov-file#tunex-llc-marionette-software-creative-commons-cc-by-nc-nd-40-international-public-license)

#### Software Licensor: TuneX LLC
#### Licensor Contact Information: E-mails: admin@tunex.io / humans@marionette.dev // Website: https://marionette.dev/

#### More information about GitHub Release VS Commercial License: https://marionette.dev/test-drive/

## Marionette Configurator

**Configurator** - is a toolset to generate deployment configuration

![Marionette Configurator Diagram](docs/diagram.drawio.svg)

## Inside

- User's configuration file `global/config.yaml`
- Handlebars templates
- NodeJS CLI tool `m` that generates deployment configuration

## Get Stated

Please read full guideline of configuration process from scratch on our official portal with [documentation](https://tunex.atlassian.net/wiki/spaces/MS/pages/39616513/)

Start in 5 lines:

```shell
nvm use 20
(cd tool && npm install)
# ... setup your values in global/config.yaml ...
./m render-config
docker compose up
```
