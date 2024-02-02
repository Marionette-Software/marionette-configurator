{
  "url": "{{base_url}}",
  "terms_and_conditions_url": "{{components.userapp.terms_and_conditions_url}}",
  "google_auth": {
    "enabled": {{components.extensions.googleAuth.enabled}},
    "client_id": "{{components.extensions.googleAuth.client_id}}"
  },

  "enabledBuySell": true,
  "enabledLoginCaptcha": {{#if login_captcha}}true{{else}}false{{/if}},
  "enabledPhoneVerificationStep": {{#ifEquals no_phone_verification 1}}false{{else}}true{{/ifEquals}},
  "enabledReferrals": false,
  "enabledSellWithdrawZeroBalance": true,
  "enabledSpread": true,
  "enabledStaking": false,
  "enabled_non_custodial_exchange_page": {{components.userapp.non_custodial_exchange.enabled}},
  "enabled_non_custodial_wallet_connect": {{components.walletconnect.enabled}},
  "enabled_trading_page": {{components.trading.enabled}},
  "enabled_wallet_page": true,
  "withInstantBuy": true,
  "withInstantSell": true,
  "withTradingBalance": {{components.trading.separate_trading_user_account}}
}
