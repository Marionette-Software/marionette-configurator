{{#if components.extensions.googleAuth.enabled}}
{
    "service_prefix": "googleAuth",
    "client_id": "{{components.extensions.googleAuth.client_id}}",
    "db": {
        "dialect": "{{database.type}}",
        "port": "{{database.port}}",
        "host": "{{database.host}}",
        "user": "{{database.user}}",
        "database": "{{database.database}}",
        "password": "{{database.password}}",
        "tableprefixmigrate": "{{components.extensions.googleAuth.tableprefixmigrate}}"
    }
}
{{/if}}
