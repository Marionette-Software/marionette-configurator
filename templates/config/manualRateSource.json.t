{
    "service_prefix": "{{rateSources.manualRateSource.id}}",
    "db": {
        "dialect": "{{database.type}}",
        "port": "{{database.port}}",
        "host": "{{database.host}}",
        "user": "{{database.user}}",
        "database": "{{database.database}}",
        "password": "{{database.password}}",
        "tableprefixmigrate": "{{rateSources.manualRateSource.tableprefixmigrate}}"
    },
    "time_interval": {{rateSources.manualRateSource.time_interval}},
    "base_url": "{{#if components.traefik.ssl}}https{{else}}http{{/if}}://{{base_url}}"
}
