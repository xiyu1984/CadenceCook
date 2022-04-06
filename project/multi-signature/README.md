# A general Multi-Signature Mechanism on Flow


This is the main branch. Development here and for fcl in the future.

## Introduction
### Contracts
[multiSignature.cdc](https://github.com/xiyu1984/CadenceCook/blob/main/project/multi-signature/multiSignature.cdc) is the general multi-signature contract used to make any operation of user defined resources be restricted by multi-signature. 

[example.cdc](https://github.com/xiyu1984/CadenceCook/blob/main/project/multi-signature/example.cdc) is a simple contract showing how to use `multiSignature.cdc` to make one of its resource function be a multi-signature operation. 


### Transactions
[createProposal_Tx.cdc](https://github.com/xiyu1984/CadenceCook/blob/main/project/multi-signature/transaction/createProposal_Tx.cdc), [executePp_Tx.cdc](https://github.com/xiyu1984/CadenceCook/blob/main/project/multi-signature/transaction/executePp_Tx.cdc), [clearData_Tx.cdc](https://github.com/xiyu1984/CadenceCook/blob/main/project/multi-signature/transaction/clearData_Tx.cdc) are used to show how to create, execute, and clear a proposal.

[executeByOther_Tx.cdc](https://github.com/xiyu1984/CadenceCook/blob/main/project/multi-signature/transaction/executeByOther_Tx.cdc) is for testing unauthorized account's operation result.

[createSigner_Tx.cdc](https://github.com/xiyu1984/CadenceCook/blob/main/project/multi-signature/transaction/createSigner_Tx.cdc), [sign_Tx.cdc](https://github.com/xiyu1984/CadenceCook/blob/main/project/multi-signature/transaction/sign_Tx.cdc) show how to create a signer and how to sign a proposal.


## Usage
1. Prepare at least three account, for example, account 0x01, account 0x02, account 0x03. Substitute the addresses when you are trying;

2. Deploy [multiSignature.cdc](https://github.com/xiyu1984/CadenceCook/blob/main/project/multi-signature/multiSignature.cdc) with any account;
```
flow accounts add-contract MultiSignatureFactory ./multiSignature.cdc -n testnet --signer 0x01
```

3. Deploy [example.cdc](https://github.com/xiyu1984/CadenceCook/blob/main/project/multi-signature/example.cdc) with any account;
```
flow accounts add-contract Example ./example.cdc -n testnet --signer 0x01
```

4. execute transaction [createProposal_Tx.cdc](https://github.com/xiyu1984/CadenceCook/blob/main/project/multi-signature/transaction/createProposal_Tx.cdc) with account `0x03`. This will create a multi-sign resource proposal as `0x03`'s resource;
```
flow transactions send ./transaction/createProposal_Tx.cdc --signer 0x03 -n testnet
```

5. execute transaction [createSigner_Tx.cdc](https://github.com/xiyu1984/CadenceCook/blob/main/project/multi-signature/transaction/createSigner_Tx.cdc) with accout `0x01` and account `0x02` respectively;
```
flow transactions send ./transaction/createSigner_Tx.cdc --signer 0x01 -n testnet
flow transactions send ./transaction/createSigner_Tx.cdc --signer 0x02 -n testnet
```

6. execute transaction [sign_Tx.cdc](https://github.com/xiyu1984/CadenceCook/blob/main/project/multi-signature/transaction/sign_Tx.cdc) with account `0x01` and account `0x02` respectively. This will sign for the proposal created by step `5`;
```
flow transactions send ./transaction/sign_Tx.cdc --signer 0x01 -n testnet
flow transactions send ./transaction/sign_Tx.cdc --signer 0x02 -n testnet
```

7. execute transaction [executePp_Tx.cdc](https://github.com/xiyu1984/CadenceCook/blob/main/project/multi-signature/transaction/executePp_Tx.cdc) with account `0x03`. This will success and event print "Hello example!" will be showed;
```
flow transactions send ../CadenceCook/project/multi-signature/transaction/executePp_Tx.cdc --signer 0x03 -n testnet
```

8. execute transaction [executePp_Tx.cdc](https://github.com/xiyu1984/CadenceCook/blob/main/project/multi-signature/transaction/executePp_Tx.cdc) again, but this time error message "unexpectedly found nil while forcing an Optional value" will be showed. This is because once the multi-signature operation executes, the `R_Proposal` will clear it and do not allow it to be accessed again. Details [here](https://github.com/xiyu1984/CadenceCook/blob/9da201e023bd6bafc09bcb1f93ec85591048d1e0/project/multi-signature/multiSignature.cdc#L100).
```
flow transactions send ../CadenceCook/project/multi-signature/transaction/executePp_Tx.cdc --signer 0x03 -n testnet
```


## Coming soon
I have prepared a more flexibie way when `sign`ing, which has not been tested because the playground cannot supports `PublicPath` currently.
I'll complete the test on testnet soon.
