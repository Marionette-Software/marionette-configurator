doctype html
html(lang="en")
	head
		style.
			body { font-family: Open Sans, Helvetica Neue, Helvetica, Arial, sans-serif; background-color: #f2f2f2; }
			.padding10 { padding: 10px; }
			.height32 { height: 32px; }
			.placement { margin: 0 auto; min-width: 320px; max-width: 600px; text-align: center; }
			.image { width: 100%; max-width: 180px; padding-bottom: 15px; }
			.bgWhite { background-color: #ffffff; }
			.bgColor { color: #ffffff; background-color: #A32AFF; }
			.topTr { border-radius: 16px 16px 0 0; }
			.bottomTr { border-radius: 0 0 16px 16px; }
			.divider { margin: 15px; border-top: 1px solid #053f51 }
			.aroundButton { padding: 30px 0; }
			.button { width: 70%; padding: 10px; background-color: #A32AFF; color: #ffffff; font-size: 14px; font-weight: bold; text-decoration:none; border-radius: 5px; }
	body
		div.padding10
		div.placement
			div.height32.bgWhite.topTr &nbsp;
			div.bgWhite
				img.image(alt="{{project_name}}" src="{{#if components.traefik.ssl}}https{{else}}http{{/if}}://{{base_url}}/static{{logo}}")
				div.divider
				div.padding10 Hello!
				div.padding10 Welcome to {{project_name}}
				div.padding10 Use this unique link to confirm your email #{email}
			div.bgWhite
				div.aroundButton
					a.button(href=url) Confirm
			div.bgColor
				div.padding10 &nbsp;
				div.padding10 Email: {{support_email}}
				div.padding10 © Copyright 2024 {{project_name}} | All Rights Reserved
			div.height32.bgColor.bottomTr &nbsp;
		div.padding10