# Requirements

Node version: v16.10.0
NPM version: v7.24.0

## How to create local node.

```js
npx hardhat node
```

## How to deploy smart contract into local node

```js
npx hardhat run scripts/deploy.js --network localhost
```

## How to run frontend/ui

```js
cd frontend
npm install
npm start
```

## How to connect wallet to the application

[Guide](https://support.chainstack.com/hc/en-us/articles/4408642503449-Using-MetaMask-with-a-Hardhat-node)

New RPC URL: http://127.0.0.1:8545/
ChainID: 1337

## How to add some ETH and Token for the specific adress

```js
npx hardhat --network localhost faucet <adress>
```

## How to add two employees avaliable to purchase

```js
npx hardhat --network localhost employee
```