# Lifespan Test for `Resource`

## Introduction
This is a test for the lifespan of a `resource`.

As we know for the [doc](https://docs.onflow.org/cadence/language/contract-updatability/#gatsby-focus-wrapper), contracts update has many restrictions.

We found a more flexible way to do the "update", that is, by `remove` contract and re-`deploy` is.

The resource created by the older contract is just the same after the related contract is `remove`d and re-`deploy`ed.

Details are as below：

## Steps
* Deploy `contract ResBag` without the field `priv let n: UInt128;`.
```
flow accounts add-contract ResBag ../CadenceCook/project/resourceLifespan/resourceBag.cdc -n testnet --signer testnet-account
```
**img**

* create and visit Res1
```
# create Res1
flow transactions send ../CadenceCook/project/resourceLifespan/transaction/createRes1_Tx.cdc --signer testnet-subone -n testnet

# visit Res1
flow transactions send ../CadenceCook/project/resourceLifespan/transaction/visitRes1_Tx.cdc --signer testnet-subone -n testnet
```
**img**

* Remove `contract ResBag`
```
flow accounts remove-contract ResBag -n testnet --signer testnet-account
```
**img**

* **Add** the field `priv let n: UInt128;` and **re-deploy** `contract ResBag`.
```
flow accounts add-contract ResBag ../CadenceCook/project/resourceLifespan/resourceBag.cdc -n testnet --signer testnet-account
```
**img**


* Visit Res1 again 
# visit Res1
```
flow transactions send ../CadenceCook/project/resourceLifespan/transaction/visitRes1_Tx.cdc --signer testnet-subone -n testnet
```
**img**

**Amazing**, we found the same `uuid`. But if we add another field (`priv let n2: UInt128;`) again to test update:
* Add the field `priv let n2: UInt128;` and update:
```
flow accounts update-contract ResBag ../CadenceCook/project/resourceLifespan/resourceBag.cdc -n testnet --signer testnet-account
```
**img**

## Conclusion
`remove` and re-`deploy` may implement the ability like "update" but without some restrictions.
