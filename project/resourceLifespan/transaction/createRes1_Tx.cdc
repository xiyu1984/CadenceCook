import ResBag from 0x33a8abe2196c9e15

transaction {

  prepare(acct: AuthAccount) {
    acct.save(<- ResBag.createRes1(), to: /storage/res1);

    let res1Ref = acct.borrow<&ResBag.Res1>(from: /storage/res1);
    let s = res1Ref!.getInfo();
  }

  execute {
    
  }
}
