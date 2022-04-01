# A general Multi-Signature Mechanism on Flow

This branch is for flc version, the `flow ` command lines will be writen here later.

## Introduction
### Contracts
[multiSignature.cdc](https://github.com/xiyu1984/CadenceCook/blob/main/project/multi-signature/multiSignature.cdc) is the general multi-signature contract used to make any operation of user defined resources be restricted by multi-signature. 

[example.cdc](https://github.com/xiyu1984/CadenceCook/blob/main/project/multi-signature/example.cdc) is a simple contract showing how to use `multiSignature.cdc` to make one of its resource function be a multi-signature operation. 


### Transactions
[createProposal_Tx.cdc](https://github.com/xiyu1984/CadenceCook/blob/main/project/multi-signature/transaction/createProposal_Tx.cdc), [executePp_Tx.cdc](https://github.com/xiyu1984/CadenceCook/blob/main/project/multi-signature/transaction/executePp_Tx.cdc), [clearData_Tx.cdc](https://github.com/xiyu1984/CadenceCook/blob/main/project/multi-signature/transaction/clearData_Tx.cdc) are used to show how to create, execute, and clear a proposal.

[executeByOther_Tx.cdc](https://github.com/xiyu1984/CadenceCook/blob/main/project/multi-signature/transaction/executeByOther_Tx.cdc) is for testing unauthorized account's operation result.

[createSigner_Tx.cdc](https://github.com/xiyu1984/CadenceCook/blob/main/project/multi-signature/transaction/createSigner_Tx.cdc), [sign_Tx.cdc](https://github.com/xiyu1984/CadenceCook/blob/main/project/multi-signature/transaction/sign_Tx.cdc) show how to create a signer and how to sign a proposal.


## Usage
1. Prepare at least three account, for example, account 0x01, account 0x02, account 0x03;
2. Deploy [multiSignature.cdc](https://github.com/xiyu1984/CadenceCook/blob/main/project/multi-signature/multiSignature.cdc) with any account;
3. Deploy [example.cdc](https://github.com/xiyu1984/CadenceCook/blob/main/project/multi-signature/example.cdc) with any account;
4. execute transaction [createProposal_Tx.cdc](https://github.com/xiyu1984/CadenceCook/blob/main/project/multi-signature/transaction/createProposal_Tx.cdc) with account `0x03`. This will create a multi-sign resource proposal as `0x03`'s resource;
5. execute transaction [createSigner_Tx.cdc](https://github.com/xiyu1984/CadenceCook/blob/main/project/multi-signature/transaction/createSigner_Tx.cdc) with accout `0x01` and account `0x02` respectively;
6. execute transaction [sign_Tx.cdc](https://github.com/xiyu1984/CadenceCook/blob/main/project/multi-signature/transaction/sign_Tx.cdc) with account `0x01` and account `0x02` respectively. This will sign for the proposal created by `5`;
7. execute transaction [executePp_Tx.cdc](https://github.com/xiyu1984/CadenceCook/blob/main/project/multi-signature/transaction/executePp_Tx.cdc) with account `0x03`. This will success and log "Hello example!" will be showed;
8. execute transaction [executePp_Tx.cdc](https://github.com/xiyu1984/CadenceCook/blob/main/project/multi-signature/transaction/executePp_Tx.cdc) again, but this time error message "unexpectedly found nil while forcing an Optional value" will be showed. This is because once the multi-signature operation executes, the `R_Proposal` will clear it and do not allow it to be accessed again. Details [here](https://github.com/xiyu1984/CadenceCook/blob/9da201e023bd6bafc09bcb1f93ec85591048d1e0/project/multi-signature/multiSignature.cdc#L100).


## Coming soon
I have prepared a more flexibie way when `sign`ing, which has not been tested because the playground cannot supports `PublicPath` currently.
I'll complete the test on testnet soon.
