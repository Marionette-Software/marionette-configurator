#### Welcome to Marionette Software Test Drive Configurator!

**Who is Marionette Test Drive for and what can you do with it?**

1. Teams who want to test the core functionality of Marionette Software to see if Marionette is the right fit for their vision/team/project.

2. Teams who want to contribute to the improvements of Marionette Software, earn contributor bounties or earn a commercial license for Marionette Software. 

3. Teams who want to understand what does it actually take to run a cryptocurrency and fiat FinTech service.

4. Teams who want to build their Proof of Concept and seek public and/or private investment with a go to market ready MVP.

5. Teams can customize the UI with examples and thorough documentation of API's and Architecture.
5.1 User App Architecture: https://tunex.atlassian.net/wiki/spaces/ID/pages/4325435/User+App+Architecture
5.2 Configurations for User App: https://tunex.atlassian.net/wiki/spaces/ID/pages/22970398/Configurations+for+User+App
5.3 User App Queries, Mutations and Subscriptions: https://tunex.atlassian.net/wiki/spaces/ID/pages/10289175/User+App+Queries+Mutations+and+Subscriptions

6. Teams can introduce their custom plugins and features. From introducing 3rd party services like custom bots, to integrating local banks, payment gateways, liquidity providers, market makers as well as very custom and unique user facing services.

**!! Before you begin, please read the following paragraph summary and get acquainted with the License Agreement for Marionette Software Test Drive !!**
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
