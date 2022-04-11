# submit with authority

## Some strange thing
* deploy first with 
```
flow accounts add-contract SubmitAuthor ../CadenceCook/project/submit-with-auth/SubmitAuthor.cdc -n testnet --signer testnet-account
```
* create submitter and acceptor
```
# create acceptor by testnet-subone
flow transactions send ../CadenceCook/project/submit-with-auth/transaction/createAcceptor_Tx.cdc --signer testnet-subone -n testnet

# create submitter by testnet-subtwo
flow transactions send ../CadenceCook/project/submit-with-auth/transaction/createSubmitter_Tx.cdc --signer testnet-subtwo -n testnet
```
* submit by testnet-subtwo
```
flow transactions send ../CadenceCook/project/submit-with-auth/transaction/submit_Tx.cdc --signer testnet-subtwo -n testnet
```

**AMazing thing happens**
* **remove** contract
```
flow accounts remove-contract SubmitAuthor -n testnet --signer testnet-account
```
* un-comments the below lines:
```
// in resource contract `SubmitAuthor`
// test field, add after remove
priv let id2: UInt128;
```
and
```
// in contract `SubmitAuthor`
self.id2 = 200;
```
and
```
// in resource `Submitter`
// test field, add after remove
pub let id: UInt128;
```
and
```
// in resource `Submitter`
self.id = 100;
```

* re-deploy
```
flow accounts add-contract SubmitAuthor ../CadenceCook/project/submit-with-auth/SubmitAuthor.cdc -n testnet --signer testnet-account
```

* submit by testnet-subtwo **directly (without `create...` again)**
```
flow transactions send ../CadenceCook/project/submit-with-auth/transaction/submit_Tx.cdc --signer testnet-subtwo -n testnet
```
