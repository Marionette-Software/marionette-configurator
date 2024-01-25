version: "3.7"

services:
  {{rateSources.manualRateSource.id}}:
    image: {{rateSources.manualRateSource.image}}
    hostname: {{rateSources.manualRateSource.id}}
    command: node_modules/moleculer/bin/moleculer-runner
    restart: always
    environment:
      SERVICES: services/{{rateSources.manualRateSource.id}}
      LOGLEVEL: {{log_level}}
      NAME: {{rateSources.manualRateSource.name}}
    volumes:
      - "../config/manualRateSource.json:/app/config.json"
    depends_on:
      - api
      - nats
  {{#ifEquals rateSources.jaeger.enabled true}}
      - jaeger
  {{/ifEquals}}
      - rateSourceConfig

{{#ifEquals rateSources.marketcapRateSource.enabled true}}
  {{rateSources.marketcapRateSource.id}}:
    image: {{rateSources.marketcapRateSource.image}}
    hostname: {{rateSources.marketcapRateSource.id}}
    command: npm start
    restart: always                
    environment:
      API_KEY: {{rateSources.marketcapRateSource.apikey}}
      TIMEINTERVAL: {{rateSources.marketcapRateSource.timeinterval}}
      LOGLEVEL: {{log_level}}
      NAME: {{rateSources.marketcapRateSource.name}}
    depends_on:
      - api
      - nats
      - paymentGateway
{{#ifEquals rateSources.jaeger.enabled true}}
      - jaeger
{{/ifEquals}}
      - rateSourceConfig
{{/ifEquals}}
