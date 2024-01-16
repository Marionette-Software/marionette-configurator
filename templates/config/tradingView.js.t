const colors = {
    light: {
        chart: {
            primary: '#fff',
            up: '#21b390',
            down: '#cb3c64',
        },
        depth: {
            fillAreaAsk: '#fa5252',
            fillAreaBid: '#12b886',
            gridBackgroundStart: '#fff',
            gridBackgroundEnd: '#fff',
            strokeAreaAsk: '#fa5252',
            strokeAreaBid: '#12b886',
            strokeGrid: ' #B8E9F5',
            strokeAxis: '#cccccc',
        },
        textcolor: {
            charttext: '#221F54'
        }
    },
    basic: {
        chart: {
            primary: '#fff',
            up: '#21b390',
            down: '#cb3c64',
        },
        depth: {
            fillAreaAsk: '#fa5252',
            fillAreaBid: '#12b886',
            gridBackgroundStart: '#fff',
            gridBackgroundEnd: '#fff',
            strokeAreaAsk: '#fa5252',
            strokeAreaBid: '#12b886',
            strokeGrid: ' #B8E9F5',
            strokeAxis: '#cccccc',
        },
    },
    dark: {
        chart: {
            primary: '#1E272F', // background color
            up: '#21b390', // green candle on diagram
            down: '#cb3c64', // red candle on diagram
        },
        textcolor: {
            charttext: '#8C8F9F' // axes text on diagram
        }
    },
};

const tradingurl = '{{#if components.traefik.ssl}}https{{else}}http{{/if}}://{{base_url}}/graphql';
const wsurl = '{{#if components.traefik.ssl}}wss{{else}}ws{{/if}}://{{base_url}}/graphql';
