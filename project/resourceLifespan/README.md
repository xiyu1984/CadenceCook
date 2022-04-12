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
![1](https://user-images.githubusercontent.com/83746881/162871394-0c509b7e-be36-41db-98fa-37e82ef81860.png)


* create and visit Res1
```
# create Res1
flow transactions send ../CadenceCook/project/resourceLifespan/transaction/createRes1_Tx.cdc --signer testnet-subone -n testnet

# visit Res1
flow transactions send ../CadenceCook/project/resourceLifespan/transaction/visitRes1_Tx.cdc --signer testnet-subone -n testnet
```
![2](https://user-images.githubusercontent.com/83746881/162871420-07fd7a4a-bfbf-4047-8d30-ad16843ced8f.png)


* Remove `contract ResBag`
```
flow accounts remove-contract ResBag -n testnet --signer testnet-account
```
![3](https://user-images.githubusercontent.com/83746881/162871430-ab47d31e-41d3-407a-8357-0ec163a44562.png)


* **Add** the field `priv let n: UInt128;` and **re-deploy** `contract ResBag`.
```
flow accounts add-contract ResBag ../CadenceCook/project/resourceLifespan/resourceBag.cdc -n testnet --signer testnet-account
```
![4](https://user-images.githubusercontent.com/83746881/162871446-f2398e64-7cb3-4e37-a8cf-a287594595f8.png)



* Visit Res1 again 
# visit Res1
```
flow transactions send ../CadenceCook/project/resourceLifespan/transaction/visitRes1_Tx.cdc --signer testnet-subone -n testnet
```
![5](https://user-images.githubusercontent.com/83746881/162871462-3d8c8cc8-9816-42a7-9a71-1e2769ae37db.png)


**Amazing**, we found the same `uuid`. But if we add another field (`priv let n2: UInt128;`) again to test update:
* Add the field `priv let n2: UInt128;` and update:
```
flow accounts update-contract ResBag ../CadenceCook/project/resourceLifespan/resourceBag.cdc -n testnet --signer testnet-account
```
![6](https://user-images.githubusercontent.com/83746881/162871474-5d791822-d18c-476a-901e-1ba5fbe8ee47.png)

## Conclusion
`remove` and re-`deploy` may implement the ability like "update" but without some restrictions.
