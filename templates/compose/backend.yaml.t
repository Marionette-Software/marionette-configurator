version: "3.7"

x-backend: &backend
    image: {{components.backend}}
    restart: always
    depends_on:
{{#ifEquals components.jaeger.enabled true}}
        - jaeger
{{/ifEquals}}
        - db
        - nats
        - influxdb

services:

    db-bridge:
        << : *backend
        hostname: db-bridge
        command: npm run-script start-db
        env_file:
            - ../config/database.env
        environment:
            LOGLEVEL: {{log_level}}
    
    api:
        << : *backend
        hostname: api
        command: npm start
        env_file:
            - ../config/path.env
        environment:
            NODE_ENV: {{#if production}}production{{else}}development{{/if}}
            LOGLEVEL: {{log_level}}
        volumes:
            - ../static:/app/static
            - ../config/staticuserapp.json:/app/static/config.json
{{#ifEquals mode "swarm"}}
        deploy:
            labels:
                - "traefik.http.routers.api.rule=Host(`{{base_url}}`) && (PathPrefix(`/graphql`) || PathPrefix(`/public`) || PathPrefix(`/static`))"
                - "traefik.enable=true"
                - "traefik.http.services.api.loadbalancer.server.port=3000"
                {{#if components.traefik.ssl.enabled}}
                - "traefik.http.routers.api.entrypoints=websecure"
                - "traefik.http.routers.api.tls=true"
                - "traefik.http.routers.api.tls.certresolver=myresolver"
                - "traefik.http.routers.api.middlewares=secureheaders"
                {{else}}
                - "traefik.http.routers.api.entrypoints=web"
                {{/if}}
                - "traefik.http.routers.api.priority=200"
{{/ifEquals}}
{{#ifEquals mode "compose"}}
        labels:
            - "traefik.http.routers.api.rule=Host(`{{base_url}}`) && (PathPrefix(`/graphql`) || PathPrefix(`/public`) || PathPrefix(`/static`))"
            - "traefik.enable=true"
            - "traefik.http.services.api.loadbalancer.server.port=3000"
            {{#if components.traefik.ssl.enabled}}
            - "traefik.http.routers.api.entrypoints=websecure"
            - "traefik.http.routers.api.tls=true"
            - "traefik.http.routers.api.tls.certresolver=myresolver"
            - "traefik.http.routers.api.middlewares=secureheaders"
            {{else}}
            - "traefik.http.routers.api.entrypoints=web"
            {{/if}}
            - "traefik.http.routers.api.priority=200"
{{/ifEquals}}

    rateSourceConfig:
        << : *backend
        hostname: rateSourceConfig
        command: ./node_modules/.bin/moleculer-runner
        env_file:
            - ../config/database.env
        environment:
            SERVICES: services/rateSourceConfig
            LOGLEVEL: {{log_level}}
            RATE_SOURCE_TIMEOUT: {{rate_source_timeout}}

    users:
        << : *backend
        hostname: users
        command: ./node_modules/.bin/moleculer-runner
        env_file:
            - ../config/path.env
            - ../config/storage.env
        environment:
            SERVICES: services/users
            LOGLEVEL: {{log_level}}
            DOCUMENT_TYPES: "{{kyc.document_types}}"
            DOC_COUNT: {{kyc.document_count}}
            DOMAIN: {{#if components.traefik.ssl.enabled}}https{{else}}http{{/if}}://{{base_url}}
            PROJECT_NAME: {{project_name}}
            LOGO_URL: {{#if components.traefik.ssl.enabled}}https{{else}}http{{/if}}://{{base_url}}{{components.path.static}}{{logo}}
            SUPPORT_EMAIL: {{support_email}}
            BASE_URL: {{base_url}}
            NO_PHONE_VERIFICATION: {{no_phone_verification}}
{{#ifEquals storage.type "GOOGLE"}}
        volumes:
            - ../config/secrets/google_storage.json:/app/google_storage.json
{{/ifEquals}}
            
    auth:
        << : *backend
        hostname: auth
        command: ./node_modules/.bin/moleculer-runner
        env_file:
            - ../config/database.env
        volumes:
            - ../config/secrets:/secrets
        environment:
            SERVICES:  services/auth
            LOGLEVEL: {{log_level}}
            DOMAIN: {{base_url}}
            TOKEN_LIFETIME: {{auth.token_lifetime}}

    markets:
        << : *backend
        hostname: markets
        command: ./node_modules/.bin/moleculer-runner
        environment:
            SERVICES: services/markets
            LOGLEVEL: {{log_level}}

    currencies:
        << : *backend
        hostname: currencies
        command: ./node_modules/.bin/moleculer-runner
        env_file:
            - ../config/path.env
            - ../config/storage.env
        environment:
            SERVICES: services/currencies
            LOGLEVEL: {{log_level}}
            BASE_URL: {{base_url}}
{{#ifEquals storage.type "GOOGLE"}}
        volumes:
            - ../config/secrets/google_storage.json:/app/google_storage.json
{{/ifEquals}}

    operations:
        << : *backend
        hostname: operations
        command: ./node_modules/.bin/moleculer-runner
        env_file:
            - ../config/database.env
        environment:
            SERVICES: services/operations
            LOGLEVEL: {{log_level}}
{{#ifEquals components.trading.enabled true}}
            SEPARATE_TRADING_USER_ACCOUNT: {{#ifEquals components.trading.separate_trading_user_account true}}1{{else}}0{{/ifEquals}} 
{{/ifEquals}}

    trading:
        << : *backend
        hostname: trading
        command: ./node_modules/.bin/moleculer-runner
        env_file:
            - ../config/database.env
        environment:
            SERVICES: services/trading
            LOGLEVEL: {{log_level}}
            SEPARATE_TRADING_USER_ACCOUNT: {{#ifEquals components.trading.separate_trading_user_account true}}1{{else}}0{{/ifEquals}}

    paymentGateway:
        << : *backend
        hostname: paymentGateway
        command: ./node_modules/.bin/moleculer-runner
        env_file:
            - ../config/path.env
            - ../config/database.env
            - ../config/storage.env
        environment:
            SERVICES: services/paymentGateway
            LOGLEVEL: {{log_level}}
            BASE_URL: {{base_url}}
{{#ifEquals storage.type "GOOGLE"}}
        volumes:
            - ../config/secrets/google_storage.json:/app/google_storage.json
{{/ifEquals}}

    messages:
        << : *backend
        hostname: messages
        command: npm run-script start-messages
        environment:
            LOGLEVEL: {{log_level}}
        volumes:
            - ../email_templates:/app/email_templates
            - ../config/messages.json:/app/config.json

    countries:
        << : *backend
        hostname: countries
        command: ./node_modules/.bin/moleculer-runner
        environment:
            SERVICES: services/countries
            LOGLEVEL: {{log_level}}

    wallets:
        << : *backend
        hostname: wallets
        command: ./node_modules/.bin/moleculer-runner
        env_file:
            - ../config/path.env
        environment:
            SERVICES: services/wallets
            LOGLEVEL: {{log_level}}
            DEPOSIT_WALLET_ON_DEMAND: 1
            BASE_URL: {{base_url}}
            EXTERNAL_WALLET_MESSAGE: {{components.walletconnect.wallet_verify_message}}
    
    balances:
        << : *backend
        hostname: balances
        command: ./node_modules/.bin/moleculer-runner
        env_file:
            - ../config/database.env
        environment:
            SERVICES: services/balances
            LOGLEVEL: {{log_level}}

    donateProjects:
        << : *backend
        hostname: donateProjects
        command: ./node_modules/.bin/moleculer-runner
        env_file:
            - ../config/path.env
            - ../config/storage.env
        environment:
            SERVICES: services/donateProjects
            LOGLEVEL: {{log_level}}
            BASE_URL: {{base_url}}
    {{#ifEquals storage.type "GOOGLE"}}
        volumes:
            - ../config/secrets/google_storage.json:/app/google_storage.json
    {{/ifEquals}}

    blockchainRegistry:
        << : *backend
        hostname: "blockchainRegistry"
        command: ./node_modules/.bin/moleculer-runner
        env_file:
            - ../config/database.env
        environment:
            SERVICES: services/blockchainRegistry
            LOGLEVEL: {{log_level}}

    monitoring:
        << : *backend
        hostname: monitoring
        command: ./node_modules/.bin/moleculer-runner
        environment:
            SERVICES:  services/monitoring
            LOGLEVEL: {{log_level}}
        restart: always        
        depends_on:
            - api 

{{#if admin_options.NodeRed.enabled}}
    red:
        << : *backend
        hostname: nodered
        command: node index.red.js
        environment:
            SERVICES: services/red
            LOGLEVEL: {{log_level}}
        labels:
            - "traefik.http.routers.red.rule=Host(`{{base_url}}`) && PathPrefix(`/red`)"
            - "traefik.enable=true"
            - "traefik.http.services.red.loadbalancer.server.port=8000"
            {{#if components.traefik.ssl.enabled}}
            - "traefik.http.routers.red.entrypoints=websecure"
            - "traefik.http.routers.red.tls=true"
            - "traefik.http.routers.red.tls.certresolver=myresolver"
            {{else}}
            - "traefik.http.routers.api.entrypoints=web"
            {{/if}}
            - "traefik.http.routers.red.priority=200"
{{/if}}

