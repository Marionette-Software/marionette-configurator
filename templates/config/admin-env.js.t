window.env = {
    API_URL: "{{#if components.traefik.ssl}}https{{else}}http{{/if}}://{{base_url}}",
    WS_URL: "{{#if components.traefik.ssl}}wss{{else}}ws{{/if}}://{{base_url}}/graphql",
    GQL_URL: "{{#if components.traefik.ssl}}https{{else}}http{{/if}}://{{base_url}}/graphql",
    BASE_COLOR: "{{#if production}}{{prod_color}}{{else}}{{stage_color}}{{/if}}",
    NODERED_ENABLED: {{admin_options.NodeRed.enabled}},
{{#if admin_options.changingBalance.enabled}}
    MANUAL_PI_ID: "{{admin_options.changingBalance.manualPaymentInterfaceId}}",
    MANUAL_INVOICE_BASED: false,
    BANK_PI_IDS: [
        {{#each admin_options.changingBalance.bankPaymentInterfaces}}"{{id}}",{{/each}}
    ],
{{/if}}
    MANUAL_PI_ENABLED: {{admin_options.changingBalance.enabled}},
{{#ifEquals components.extensions.googleAuth.enabled true}}
    GOOGLE_AUTH_CLIENT_ID: "{{components.extensions.googleAuth.client_id}}",
    GOOGLE_AUTH_ENABLED: true,
{{else}}
    GOOGLE_AUTH_ENABLED: false,
{{/ifEquals}}
    TRADING_ENABLED: {{components.trading.enabled}},
    TRADING_SEPARATE_ACCOUNT: {{components.trading.separate_trading_user_account}},
    TRADING_DEFAULT_MARKET: "{{components.trading.default_market}}",
    MANUAL_RATE_SOURCE_ENABLED: true,
}
