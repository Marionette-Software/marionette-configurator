version: "3.7"

services:

{{#if paymentInterfaces.bitcoin.enabled}}
  {{paymentInterfaces.bitcoin.id}}:
    image: {{paymentInterfaces.bitcoin.image}}
    hostname: {{paymentInterfaces.bitcoin.id}}
    restart: always
    command: npm start
    environment:
      RPC_USER: "{{paymentInterfaces.bitcoin.rpcuser}}"
      RPC_PASSWORD: "{{paymentInterfaces.bitcoin.rpcpassword}}"
      RPC_HOST: "{{paymentInterfaces.bitcoin.rpchost}}"
      NETWORK: "{{paymentInterfaces.bitcoin.network}}"
      RPC_PORT: "{{paymentInterfaces.bitcoin.rpcport}}"
      PORT: "{{paymentInterfaces.bitcoin.port}}"
      EXPLORER_ADDRESS: {{paymentInterfaces.bitcoin.explorer_address}}
      EXPLORER_TRANSACTION: {{paymentInterfaces.bitcoin.explorer_transaction}}
      LOGLEVEL: {{log_level}}
      PREFIX: {{paymentInterfaces.bitcoin.id}}
      TITLE: {{paymentInterfaces.bitcoin.title}}
      SUBTITLE: {{paymentInterfaces.bitcoin.subtitle}}
      DESCRIPTION: {{paymentInterfaces.bitcoin.description}}
      WAIT_CONFIRMATION_TIMEOUT: {{paymentInterfaces.bitcoin.wait_confirmation_timeout}}
      MIN_CONFIRMATIONS: {{paymentInterfaces.bitcoin.min_confirmations}}
      MAX_REQUEST_BLOCKS: {{paymentInterfaces.bitcoin.max_request_blocks}}
      VERBOSE: {{paymentInterfaces.bitcoin.verbose}}
    depends_on:
      - api
      - db-bridge
{{/if}}

{{#each paymentInterfaces.evm}}
{{#if enabled}}
  {{id}}:
    image: {{image}}
    hostname: {{id}}
    restart: always
    command: npm start
    environment:
      PREFIX: {{id}}
      LOGLEVEL: {{paymentInterfaces.log_level}}
      TYPE: {{type}}
      EXPLORER_ADDRESS: {{explorer_address}}
      EXPLORER_TRANSACTION: {{explorer_transaction}}
      NETWORK: {{network}}
      CHAIN_ID: {{chainId}}
      TITLE: {{title}}
      SUBTITLE: {{subtitle}}
      DESCRIPTION: {{description}}
      URL: {{url}}
      INFURA_PROJECT_ID: {{projectId}}
      INFURA_PROJECT_SECRET: {{projectSecret}}
      USER: {{user}}
      PASSWORD: {{password}}
      WAIT_CONFIRMATION_TIMEOUT: {{wait_confirmation_timeout}}
      MIN_CONFIRMATIONS: {{min_confirmations}}
      MAX_REQUEST_BLOCKS: {{max_request_blocks}}
      VERBOSE: {{verbose}}
    depends_on: 
      - api
      - db-bridge
{{/if}}
{{/each}}

{{#each paymentInterfaces.manual}}
  {{#if enabled}}
  {{id}}:
    image: {{image}}
    hostname: {{id}}
    restart: always
    command: npm start
    environment:
      PREFIX: {{id}}
      EXPLORER_ADDRESS: {{explorer_address}}
      EXPLORER_TRANSACTION: {{explorer_transaction}}
      LOGLEVEL: {{paymentInterfaces.log_level}}
      NETWORK: {{network}}
      TITLE: {{title}}
      SUBTITLE: {{subtitle}}
      DESCRIPTION: {{description}}
      INVOICE_BASED: {{invoice_based}}
      VERBOSE: {{verbose}}
    depends_on:
      - api
      - db-bridge
{{/if}}
{{/each}}

{{#if paymentInterfaces.bank.enabled}}
  {{paymentInterfaces.bank.id}}:
    image: {{paymentInterfaces.bank.image}}
    hostname: {{paymentInterfaces.bank.id}}
    restart: always
    command: npm start
    volumes:
      - ../config/bank.json:/app/api/config.json
    environment:
      LOGLEVEL: {{paymentInterfaces.log_level}}
      USER_REF_COUNT: {{paymentInterfaces.bank.ref_no_count}}
      USER_REF_LABEL: "{{paymentInterfaces.bank.ref_no_label}}"
    depends_on:
      - api
      - db-bridge
{{/if}}
