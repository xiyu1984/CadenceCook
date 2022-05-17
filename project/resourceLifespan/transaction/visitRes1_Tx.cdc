import ResBag from 0x33a8abe2196c9e15

transaction {

  prepare(acct: AuthAccount) {
    let res1Ref = acct.borrow<&ResBag.Res1>(from: /storage/res1);
    let s = res1Ref!.getInfo();
  }

  execute {
    
  }
}