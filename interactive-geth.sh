#!/bin/bash

# print command in shell script and wait for confirmation before executing it
trap 'read -p "run: $BASH_COMMAND"' DEBUG

# 1) Initialise the genesis block || Writes the genesis state
# chaindata(stores all data related to blockchain) and 
# keystore(stores private keys associated with accounts on the blockchain) 
# for local blockchain.

geth --datadir . init genesis-admin.json

# 2) creating accounts
# use "password" as password as mentioned in "password.sec"
# otherwise change the password there and use the same.

# create 2 account, to send/recieve eth later.
geth --datadir . account new
# geth --datadir . account new

# 3)listing the accounts
geth --datadir . account list

# 4) starting the blockchain *on a new terminal*
gnome-terminal --command="bash -c 'geth --networkid 4224 --mine --minerthreads 1 --datadir . --nodiscover --rpc --rpcport "8545" --port "30303" --rpccorsdomain "*" --nat "any" --rpcapi eth,web3,personal,net --unlock 0 --password ./password.sec --ipcpath "./ethereum/geth.ipc"; $SHELL'"

# 5) connect to this geth node initialized
geth attach ipc:./geth.ipc console

# now we're in the js console, we can write a few commands like:

# 6) to list all the accounts
##eth.accounts

# 7) to get balance of the accounts
##eth.getBalance(eth.accounts[0])

# 8) to get the balance in ether instead of wei
## web3.fromWei(eth.getBalance(eth.accounts[0]), "ether")

# 9) stop mining
## miner.stop()

# 10) start mining
## miner.start()

# 11) making transaction [from coinbase account to account 1]
## eth.sendTransaction({from: eth.coinbase, to: eth.accounts[1], value: web3.toWei(10, "ether")})


# after the transaction takes place, make sure the mining is running
# otherwise start the mining.
# after mining starts/continues the transaction will be successful.

# 12) check the balance of account[1]
## web3.fromWei(eth.getBalance(eth.accounts[1]), "ether")
