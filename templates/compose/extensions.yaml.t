version: "3.7"

services:

{{#ifEquals components.trading.enabled true}}
    tradingView:
        restart: always
        image: {{components.extensions.tradingview.image}}
        volumes:
            - ../config/tradingView.js:/usr/share/nginx/html/tradingview/public/tvconfig.js
    {{#ifEquals mode "swarm"}}
        deploy:
            labels:
                - "traefik.http.routers.tview.rule=Host(`{{base_url}}`) && PathPrefix(`/tradingview`)"
                - "traefik.enable=true"
                - "traefik.http.services.tview.loadbalancer.server.port=80"
                {{#if components.traefik.ssl.enabled}}
                - "traefik.http.routers.tview.entrypoints=websecure"
                - "traefik.http.routers.tview.tls=true"
                - "traefik.http.routers.tview.tls.certresolver=myresolver"
                - "traefik.http.routers.tview.middlewares=secureheaders"
                {{else}}
                - "traefik.http.routers.tview.entrypoints=web"
                {{/if}}
    {{/ifEquals}}
    {{#ifEquals mode "compose"}}
        labels:
            - "traefik.http.routers.tview.rule=Host(`{{base_url}}`) && PathPrefix(`/tradingview`)"
            - "traefik.enable=true"
            - "traefik.http.services.tview.loadbalancer.server.port=80"
            {{#if components.traefik.ssl.enabled}}
            - "traefik.http.routers.tview.entrypoints=websecure"
            - "traefik.http.routers.tview.tls=true"
            - "traefik.http.routers.tview.tls.certresolver=myresolver"
            - "traefik.http.routers.tview.middlewares=secureheaders"
            {{else}}
            - "traefik.http.routers.tview.entrypoints=web"
            {{/if}}
    {{/ifEquals}}
{{/ifEquals}}

{{#ifEquals storage.type "MINIO"}}
    {{#if storage.bucketName}}
    {{storage.bucketName}}:
    {{else}}
    defaultbucket:
    {{/if}}
        image: minio/minio:latest
        hostname: minio
        command: server /data --console-address ":9001" --address ":80"
        environment:
            - MINIO_ROOT_USER={{storage.accessKey}}
            - MINIO_ROOT_PASSWORD={{storage.secretKey}}
        volumes:
            - ../config/minio:/data
        restart: unless-stopped
        labels:
            - "traefik.http.routers.minio.rule=Host(`{{base_url}}`) && PathPrefix(`/{{#if storage.bucketName}}{{storage.bucketName}}{{else}}defaultbucket{{/if}}`)"
            - "traefik.http.routers.minio.priority=255"
            - "traefik.enable=true"
            - "traefik.http.services.minio.loadbalancer.server.port=80"
            {{#if components.traefik.ssl.enabled}}
            - "traefik.http.routers.minio.entrypoints=websecure"
            - "traefik.http.routers.minio.tls=true"
            - "traefik.http.routers.minio.tls.certresolver=myresolver"
            - "traefik.http.routers.minio.middlewares=secureheaders"
            {{else}}
            -   "traefik.http.routers.minio.entrypoints=web"
            {{/if}}
{{/ifEquals}}

    proxy:
        restart: always
        image: {{components.extensions.proxy.image}}
        env_file:
            - ../config/storage.env
        environment:
            PORT: {{components.extensions.proxy.port}}
    {{#ifEquals mode "swarm"}}
        deploy:
            labels:
                - "traefik.http.routers.proxy.rule=Host(`{{base_url}}`) && PathPrefix(`/proxy`)"
                - "traefik.enable=true"
                - "traefik.http.services.proxy.loadbalancer.server.port={{components.extensions.proxy.port}}"
                - "traefik.http.routers.proxy.middlewares=test-replacepathregex"
                - "traefik.http.middlewares.test-replacepathregex.replacepathregex.regex=^/proxy(.*)"
                - "traefik.http.middlewares.test-replacepathregex.replacepathregex.replacement=/$$1"
                {{#if components.traefik.ssl}}
                - "traefik.http.routers.proxy.entrypoints=websecure"
                - "traefik.http.routers.proxy.tls=true"
                - "traefik.http.routers.proxy.tls.certresolver=myresolver"
                {{else}}
                - "traefik.http.routers.tview.entrypoints=web"
                {{/if}}
    {{/ifEquals}}
    {{#ifEquals mode "compose"}}
        labels:
            - "traefik.http.routers.proxy.rule=Host(`{{base_url}}`) && PathPrefix(`/proxy`)"
            - "traefik.enable=true"
            - "traefik.http.services.proxy.loadbalancer.server.port={{components.extensions.proxy.port}}"
            - "traefik.http.routers.proxy.middlewares=test-replacepathregex"
            - "traefik.http.middlewares.test-replacepathregex.replacepathregex.regex=^/proxy(.*)"
            - "traefik.http.middlewares.test-replacepathregex.replacepathregex.replacement=/$$1"
            {{#if components.traefik.ssl}}
            - "traefik.http.routers.proxy.entrypoints=websecure"
            - "traefik.http.routers.proxy.tls=true"
            - "traefik.http.routers.proxy.tls.certresolver=myresolver"
            {{else}}
            - "traefik.http.routers.proxy.entrypoints=web"
            {{/if}}
    {{/ifEquals}}

{{#if components.extensions.googleAuth.enabled}}
    googleAuth:
        image: {{components.extensions.googleAuth.image}}
        hostname: googleAuth
        command: node_modules/moleculer/bin/moleculer-runner
        restart: always
        environment:
            SERVICES: services/googleAuth
            LOGLEVEL: {{log_level}}
        volumes:
            - "../config/googleAuth.json:/app/config.json"
        depends_on:
            - nats
            - db
    {{#ifEquals components.jaeger.enabled true}}
            - jaeger
    {{/ifEquals}}
    {{#ifEquals mode "swarm"}}
        deploy:
            labels:
                - "traefik.http.routers.googleauth.rule=Host(`{{base_url}}`) && PathPrefix(`/google`)"
                - "traefik.enable=true"
                - "traefik.http.services.googleauth.loadbalancer.server.port=3000"
                {{#if components.traefik.ssl.enabled}}
                - "traefik.http.routers.googleauth.entrypoints=websecure"
                - "traefik.http.routers.googleauth.tls=true"
                - "traefik.http.routers.googleauth.tls.certresolver=myresolver"
                {{else}}
                - "traefik.http.routers.googleauth.entrypoints=web"
                {{/if}}
                - "traefik.http.routers.googleauth.priority=200"
    {{/ifEquals}}
    {{#ifEquals mode "compose"}}
        labels:
            - "traefik.http.routers.googleauth.rule=Host(`{{base_url}}`) && PathPrefix(`/google`)"
            - "traefik.enable=true"
            - "traefik.http.services.googleauth.loadbalancer.server.port=3000"
            {{#if components.traefik.ssl.enabled}}
            - "traefik.http.routers.googleauth.entrypoints=websecure"
            - "traefik.http.routers.googleauth.tls=true"
            - "traefik.http.routers.googleauth.tls.certresolver=myresolver"
            {{else}}
            - "traefik.http.routers.googleauth.entrypoints=web"
            {{/if}}
            - "traefik.http.routers.googleauth.priority=200"
    {{/ifEquals}}
{{/if}}
