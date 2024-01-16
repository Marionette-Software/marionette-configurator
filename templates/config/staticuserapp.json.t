
{
  "url": "{{base_url}}",
  "terms_and_conditions_url": "{{components.userapp.terms_and_conditions_url}}",
  "google_auth": {
    "enabled": {{components.extensions.googleAuth.enabled}},
    "client_id": "{{components.extensions.googleAuth.client_id}}"
  },
  "withTradingBalance": {{components.trading.separate_trading_user_account}},
  "enabled_trading_page": {{components.trading.enabled}},
  "enabled_wallet_page": true,
  "enabled_non_custodial_exchange_page": false,
  "enabled_non_custodial_wallet_connect": false,
  "enabledBuySell": true,
  "orderBookMiddle": true,
  "enabledSpread": true,
  "enabledStaking": false,
  "enabledPhoneVerificationStep": {{#ifEquals no_phone_verification 1}}false{{else}}true{{/ifEquals}},
  "enabledReferrals": false,
  "enabledLoginCaptcha": {{#if login_captcha}}true{{else}}false{{/if}},
  "withInstantBuy": true,
  "withInstantSell": true,
  "enabledSellWithdrawZeroBalance": true
}