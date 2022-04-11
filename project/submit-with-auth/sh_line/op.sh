#!/bin/bash

# deploy
flow accounts add-contract SubmitAuthor ../CadenceCook/project/submit-with-auth/SubmitAuthor.cdc -n testnet --signer testnet-account

# update 
flow accounts update-contract SubmitAuthor ../CadenceCook/project/submit-with-auth/SubmitAuthor.cdc -n testnet --signer testnet-account

# create acceptor by testnet-subone
flow transactions send ../CadenceCook/project/submit-with-auth/transaction/createAcceptor_Tx.cdc --signer testnet-subone -n testnet

# create submitter by testnet-subtwo
flow transactions send ../CadenceCook/project/submit-with-auth/transaction/createSubmitter_Tx.cdc --signer testnet-subtwo -n testnet

# just submit by testnet-subtwo
flow transactions send ../CadenceCook/project/submit-with-auth/transaction/submit_Tx.cdc --signer testnet-subtwo -n testnet

# clear
flow transactions send ../CadenceCook/project/submit-with-auth/transaction/clearSubmitter_Tx.cdc --signer testnet-subtwo -n testnet

flow transactions send ../CadenceCook/project/submit-with-auth/transaction/clearAcceptor_Tx.cdc --signer testnet-subone -n testnet

# remove contract
flow accounts remove-contract SubmitAuthor -n testnet --signer testnet-account
