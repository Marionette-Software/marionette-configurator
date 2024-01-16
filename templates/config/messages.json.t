{
{{#ifNotEquals messages.mail.type "none"}}
    "MAILER_TYPE": "{{messages.mail.type}}",
{{/ifNotEquals}}
{{#ifNotEquals messages.mail.port "none"}}
    "MAILER_PORT": "{{messages.mail.port}}",
{{/ifNotEquals}}
{{#ifEquals messages.mail.type "AWS"}}
    "MAILER_HOST": "{{messages.mail.region}}",
    "MAILER_USER": "{{messages.mail.ses_user_access_key}}",
    "MAILER_PASSWORD": "{{messages.mail.ses_secret_access_key}}",
{{else}}
{{#ifNotEquals messages.mail.host "none"}}
    "MAILER_HOST": "{{messages.mail.host}}",
{{/ifNotEquals}}
    "MAILER_USER": "{{messages.mail.user}}",
    "MAILER_PASSWORD": "{{messages.mail.password}}",
{{/ifEquals}}
    "MAILER_FROM": "{{messages.mail.from}}",
{{#ifEquals messages.sms.type "AWS"}}
    "AWS_REGION": "{{messages.sms.region}}",
    "SMS_TYPE": "{{messages.sms.type}}",
    "AWS_ACCESS_KEY_ID": "{{messages.sms.sns_user_access_key}}",
    "AWS_SECRET_ACCESS_KEY": "{{messages.sms.sns_secret_access_key}}",
{{else}}
{{#ifEquals messages.sms.type "twilio"}}
    "TWILIO_PHONE_NUMBER": "{{messages.sms.phone_number}}",
    "TWILIO_ACCOUNT_SID": "{{messages.sms.account_sid}}",
    "TWILIO_AUTH_TOKEN": "{{messages.sms.auth_token}}",
{{/ifEquals}}
{{/ifEquals}}
    "LOGLEVEL": "warn",
    "GRAPHQL_PATH": "/graphql",
    "PUBLIC_PATH": "/public",
    "PROJECT_NAME": "{{project_name}}",
    "LOGO_URL": "{{#if components.traefik.ssl}}https{{else}}http{{/if}}://{{base_url}}/static/logo.png",
    "SUPPORT_EMAIL": "{{support_email}}"
}