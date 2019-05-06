## price-feed

### Table of content

- [Get started](#get_started)
- [Run](#run)
- [Adapters table](#adapters_table)

## Get started

##### Overview

The purpose of that script is to calculate and provide price feed for PEG.PHP currency on the Bitshares DEX. It uses the couple of free & paid ones API in order to calculate average price via other currencies (eg, via BTC, BTS, etc). 

##### Requirement

*  [Docker](https://www.docker.com/)
*  [Bitshares client up and running](https://github.com/bitshares/bitshares-core)

This price feed will use your bitshares client, so account name indicated in price feed should be added to bitshares client.

##### Instalation
Clone the project<br/>
`git clone https://hub.teamvoy.com/Bitsparkbtc/price-feed.git`<br/>
`cd price-feed`<br/>
`./install.sh`<br/>

##### Config
Configure `BITSHARES_ENDPOINT` in `.env` file<br/>

Configure<br/>
`MAINTENANCE_COLLATERAL_RATIO` default: 2000 (2.0)<br/>
`MAXIMUM_SHORT_SQUEEZE_RATIO` default: 1200 (1.2)<br/>
`CORE_EXCHANGE_RATE` default: 1.05<br/>
`DEFAULT_ACCOUNT` BitShares account that produce feed, default: nathan (please ensure keys for that account are imported on your bitsahres client)

Configure `crontab` file in root folder<br/>
`PriceFeed` constructor takes two parameters:<br/>
First parameter is bitshares name that can produce feed to PHP currency and should be added active key to your bitshares client.<br/>
Second parameter is adapter class, adapters can be found in `lib\adapter` folder

## Run
##### Via docker swarm:<br/>
To start<br/>
`docker stack deploy -c docker.yml price-feed`<br/>
To stop<br/>
`docker stack rm price-feed`<br/>

##### Via docker composer<br/>
To start<br/>
`docker-compose -f docker.yml up`<br/>

to launch docker as daemon use -D<br/>
`docker-compose -f docker.yml up -D`<br/>
To stop daemonized process<br/>
`docker-compose -f docker.yml down`<br/>

## Adapters table

| Name | Paid | Pairs |
| ------ | ------ | ------ |
| Bloom | yes | PHP-BTC, PHP-USD |
| Coingecko | no | PHP-BTS, BTC-BTS, USD-BTS |
| Coinigy | no | BTC-BTS, USD-BTS |
| Coins.ph | no | PHP-BTC, PHP-USD |
| Currencylayer | yes | PHP-BTC, PHP-USD |
| Exchangeratelab | yes | PHP-USD |
| Exchangeratesapi | no | PHP-USD |
| Fixer | yes | PHP-EUR |
| Rebit | no | PHP-BTC |
| Xe | yes | PHP-USD |






