GRAPHQL_PATH=/graphql
PUBLIC_PATH=/public
PROXY_PATH={{#if components.traefik.ssl}}https{{else}}http{{/if}}://{{base_url}}/proxy
STATIC_PATH=/static

VERIFY_SUCCESS={{paths.verify_email_success}}
VERIFY_ERROR={{paths.verify_email_error}}
VERIFY_EMAIL_PATH={{paths.verify_email}}
RECOVERY_PASSWORD_PATH={{paths.recovery_password}}
