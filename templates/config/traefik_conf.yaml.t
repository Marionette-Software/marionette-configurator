{{#if localhost_run}}
tls:
  certificates:
    - certFile: "/etc/certs/cert.pem"
      keyFile: "/etc/certs/key.pem"
{{else}}
tls:
  options:
    default:
      minVersion: VersionTLS12
      sniStrict : true
      cipherSuites:
        - TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        - TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256
        - TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256
        - TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        - TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256
        - TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256

    mintls13:
      minVersion: VersionTLS13
{{/if}}
