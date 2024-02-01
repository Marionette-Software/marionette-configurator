version: "3.7"
services:
    userapp:
        image: {{components.userapp.image}}
        environment:
            LOGLEVEL: {{log_level}}
        volumes:
            - ../config/userapp.json:/usr/share/nginx/html/assets/assets/config.json
            - ../config/staticuserapp.json:/usr/share/nginx/html/assets/config.json
{{#ifEquals mode "swarm"}}      
        deploy:
            labels:
                - "traefik.http.routers.userapp.rule=Host(`{{base_url}}`) && PathPrefix(`/`)"
                - "traefik.enable=true"
                - "traefik.http.services.userapp.loadbalancer.server.port=80"
                {{#if components.traefik.ssl.enabled}}
                - "traefik.http.routers.userapp.entrypoints=websecure"
                - "traefik.http.routers.userapp.tls=true"
                - "traefik.http.routers.userapp.tls.certresolver=myresolver"
                - "traefik.http.routers.userapp.middlewares=secureheaders"
                {{else}}
                - "traefik.http.routers.userapp.entrypoints=web"
                {{/if}}
{{/ifEquals}}
{{#ifEquals mode "compose"}}
        labels:
            - "traefik.http.routers.userapp.rule=Host(`{{base_url}}`) && PathPrefix(`/`)"
            - "traefik.enable=true"
            - "traefik.http.services.userapp.loadbalancer.server.port=80"
            {{#if components.traefik.ssl.enabled}}
            - "traefik.http.routers.userapp.entrypoints=websecure"
            - "traefik.http.routers.userapp.tls=true"
            - "traefik.http.routers.userapp.tls.certresolver=myresolver"
            - "traefik.http.routers.userapp.middlewares=secureheaders"
            {{else}}
            - "traefik.http.routers.userapp.entrypoints=web"
            {{/if}}
{{/ifEquals}}

    adminPanel:
        restart: always
        image: {{components.adminPanel}}
        volumes:
            - ../config/admin-env.js:/usr/share/nginx/html/admin/env.js
{{#ifEquals mode "swarm"}}
        deploy:
            labels:
                - "traefik.http.routers.adminpanel.rule=Host(`{{base_url}}`) && PathPrefix(`/admin`)"
                - "traefik.enable=true"
                - "traefik.http.services.adminpanel.loadbalancer.server.port=3000"
                {{#if components.traefik.ssl.enabled}}
                - "traefik.http.routers.adminpanel.entrypoints=websecure"
                - "traefik.http.routers.adminpanel.tls=true"
                - "traefik.http.routers.adminpanel.tls.certresolver=myresolver"
                - "traefik.http.routers.adminpanel.middlewares=secureheaders"
                {{else}}
                - "traefik.http.routers.adminpanel.entrypoints=web"
                {{/if}}
{{/ifEquals}}
{{#ifEquals mode "compose"}}
        labels:
            - "traefik.http.routers.adminpanel.rule=Host(`{{base_url}}`) && PathPrefix(`/admin`)"
            - "traefik.enable=true"
            - "traefik.http.services.adminpanel.loadbalancer.server.port=3000"
            {{#if components.traefik.ssl.enabled}}
            - "traefik.http.routers.adminpanel.entrypoints=websecure"
            - "traefik.http.routers.adminpanel.tls=true"
            - "traefik.http.routers.adminpanel.tls.certresolver=myresolver"
            - "traefik.http.routers.adminpanel.middlewares=secureheaders"
            {{else}}
            - "traefik.http.routers.adminpanel.entrypoints=web"
            {{/if}}
{{/ifEquals}}
