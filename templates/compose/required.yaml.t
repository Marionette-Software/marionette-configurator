version: "3.7"
services:     
    nats:
        image: {{components.nats}}
        command: "--cluster nats://0.0.0.0:6222 --routes=nats://ruser:@nats:6222 --config /nats-server.conf"
        volumes:
            - ../config/nats.conf:/nats-server.conf
        expose: 
            - "4222"

    db:
        image: {{database.image}}
        restart: always
    {{#ifEquals database.type "mysql"}}
        volumes:
            - ../data/db:/var/lib/mysql
    {{/ifEquals}}
        environment:
    {{#ifEquals database.type "mysql"}}
            MYSQL_ROOT_PASSWORD: {{database.password}}
    {{/ifEquals}}
    {{#ifEquals database.type "postgres"}}
            PG_MODE: primary
            PG_PRIMARY_USER: {{database.user}}
            PG_PRIMARY_PASSWORD: {{database.password}}
            PG_DATABASE: default
            PG_PRIMARY_PORT: {{database.port}}
    {{/ifEquals}}

    influxdb:
        image: {{influxdb.image}}
        restart: always
        volumes:
            - ../data/influxdb:/var/lib/influxdb
            - ../config/influxdb.conf:/etc/influxdb/influxdb.conf

    traefik:
        restart: always
        image: {{components.traefik.image}}
        ports:
            - "80:80"
            - "443:443"
        volumes:
            - /var/run/docker.sock:/var/run/docker.sock
    {{#if localhost_run}}
            - ../config/local-certs:/etc/certs
    {{/if}}
    {{#if components.traefik.ssl.enabled}}
            - ../config/letsencrypt:/letsencrypt
            - ../config/traefik_conf.yaml:/traefik_conf.yaml
    {{/if}}
        command:
            - "--log.level=DEBUG"
            - "--api.insecure=true"
            - "--providers.docker=true"
            - "--providers.file.filename=traefik_conf.yaml"
    {{#ifEquals mode "swarm"}}
            - "--providers.docker.swarmMode=true"
    {{/ifEquals}}
            - "--providers.docker.exposedbydefault=false"
            - "--entryPoints.web.address=:80"
            - "--entryPoints.web.forwardedHeaders.insecure"
    {{#if components.traefik.ssl.enabled}}
            - "--entryPoints.websecure.address=:443"
            - "--entryPoints.websecure.forwardedHeaders.insecure"
            - "--certificatesresolvers.myresolver.acme.httpchallenge=true"
            # - "--certificatesresolvers.myresolver.acme.caserver=https://acme-staging-v02.api.letsencrypt.org/directory"
            - "--certificatesresolvers.myresolver.acme.httpchallenge.entrypoint=web"
            - "--certificatesresolvers.myresolver.acme.email={{components.traefik.ssl.email}}"
            - "--certificatesresolvers.myresolver.acme.storage=/letsencrypt/acme.json"
    {{#ifEquals mode "swarm"}}
        deploy:
            labels:
                - "traefik.enable=true"
                - "traefik.http.routers.http-catchall.rule=hostregexp(`{host:[a-z-.]+}`)"
                - "traefik.http.routers.http-catchall.entrypoints=web"
    {{#if components.traefik.ssl.enabled}}
                - "traefik.http.routers.http-catchall.middlewares=redirect-to-https"
                - "traefik.http.middlewares.redirect-to-https.redirectscheme.scheme=https"
                - "traefik.http.middlewares.redirect-to-https.redirectscheme.permanent=true"
                - "traefik.http.middlewares.secureheaders.headers.sslredirect=true"
                - "traefik.http.middlewares.secureheaders.headers.framedeny=true"
                - "traefik.http.middlewares.secureheaders.headers.customFrameOptionsValue='sameorigin'"
                - "traefik.http.middlewares.secureheaders.headers.stspreload=true"
                - "traefik.http.middlewares.secureheaders.headers.stsseconds=31536000"
                - "traefik.http.middlewares.secureheaders.headers.stsincludesubdomains=true"                
                - "traefik.http.middlewares.secureheaders.headers.contenttypenosniff=true"
                - "traefik.http.middlewares.secureheaders.headers.accesscontrolallowmethods=GET,POST,PUT,PATCH,DELETE,OPTIONS,UPGRADE"            
                - "traefik.http.middlewares.secureheaders.headers.accesscontrolalloworiginlist={{#if components.traefik.ssl.enabled}}https{{else}}http{{/if}}://{{base_url}}"
                - "traefik.http.middlewares.secureheaders.headers.accesscontrolmaxage=3600"
                - "traefik.http.middlewares.secureheaders.headers.addvaryheader=true"
                - "traefik.http.middlewares.secureheaders.headers.contentsecuritypolicy=default-src data: blob: 'self' https://accounts.google.com https://apis.google.com 'unsafe-inline' 'unsafe-eval'; script-src data: blob: 'self' https://accounts.google.com https://apis.google.com 'unsafe-inline' 'unsafe-eval';"
                - "traefik.http.middlewares.secureheaders.headers.referrerpolicy=origin-when-cross-origin"
    {{/if}}
    {{/ifEquals}}
    {{#ifEquals mode "compose"}}
        labels:
            - "traefik.enable=true"
            - "traefik.http.routers.http-catchall.rule=hostregexp(`{host:[a-z-.]+}`)"
            - "traefik.http.routers.http-catchall.entrypoints=web"
    {{#if components.traefik.ssl.enabled}}
            - "traefik.http.routers.http-catchall.middlewares=redirect-to-https"
            - "traefik.http.middlewares.redirect-to-https.redirectscheme.scheme=https"
            - "traefik.http.middlewares.redirect-to-https.redirectscheme.permanent=true"
            - "traefik.http.middlewares.secureheaders.headers.sslredirect=true"
            - "traefik.http.middlewares.secureheaders.headers.framedeny=true"
            - "traefik.http.middlewares.secureheaders.headers.customFrameOptionsValue='sameorigin'"
            - "traefik.http.middlewares.secureheaders.headers.stspreload=true"
            - "traefik.http.middlewares.secureheaders.headers.stsseconds=31536000"
            - "traefik.http.middlewares.secureheaders.headers.stsincludesubdomains=true"                
            - "traefik.http.middlewares.secureheaders.headers.contenttypenosniff=true"
            - "traefik.http.middlewares.secureheaders.headers.accesscontrolallowmethods=GET,POST,PUT,PATCH,DELETE,OPTIONS,UPGRADE"            
            - "traefik.http.middlewares.secureheaders.headers.accesscontrolalloworiginlist={{#if components.traefik.ssl.enabled}}https{{else}}http{{/if}}://{{base_url}}"
            - "traefik.http.middlewares.secureheaders.headers.accesscontrolmaxage=3600"
            - "traefik.http.middlewares.secureheaders.headers.addvaryheader=true"
            - "traefik.http.middlewares.secureheaders.headers.contentsecuritypolicy=default-src data: blob: 'self' https://accounts.google.com https://apis.google.com 'unsafe-inline' 'unsafe-eval'; script-src data: blob: 'self' https://accounts.google.com https://apis.google.com 'unsafe-inline' 'unsafe-eval';"
            - "traefik.http.middlewares.secureheaders.headers.referrerpolicy=origin-when-cross-origin"
    {{/if}}
    {{/ifEquals}}
{{/if}}

{{#ifEquals components.jaeger.enabled true}}
    jaeger:
        image: {{components.jaeger.image}}
        environment:
            COLLECTOR_ZIPKIN_HTTP_PORT: 9411
            QUERY_BASE_PATH: {{components.jaeger.path}}
{{#ifEquals mode "swarm"}}      
        deploy:
            labels:
                - "traefik.http.routers.jaeger.rule=Host(`{{base_url}}`) && PathPrefix(`{{components.jaeger.path}}`)"
                - "traefik.enable=true"
                - "traefik.http.services.jaeger.loadbalancer.server.port=16686"
                {{#if components.traefik.ssl.enabled}}
                - "traefik.http.routers.jaeger.entrypoints=websecure"
                - "traefik.http.routers.jaeger.tls=true"
                - "traefik.http.routers.jaeger.tls.certresolver=myresolver"
                {{else}}
                - "traefik.http.routers.jaeger.entrypoints=web"
                {{/if}}
{{/ifEquals}}
{{#ifEquals mode "compose"}}
        labels:
            - "traefik.http.routers.jaeger.rule=Host(`{{base_url}}`) && PathPrefix(`{{components.jaeger.path}}`)"
            - "traefik.enable=true"
            - "traefik.http.services.jaeger.loadbalancer.server.port=16686"
            {{#if components.traefik.ssl.enabled}}
            - "traefik.http.routers.jaeger.entrypoints=websecure"
            - "traefik.http.routers.jaeger.tls=true"
            - "traefik.http.routers.jaeger.tls.certresolver=myresolver"
            {{else}}
            - "traefik.http.routers.jaeger.entrypoints=web"
            {{/if}}
{{/ifEquals}}
{{/ifEquals}}
