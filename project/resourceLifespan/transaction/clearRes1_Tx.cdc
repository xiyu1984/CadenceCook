import ResBag from 0x33a8abe2196c9e15

transaction {

  prepare(acct: AuthAccount) {
    let res1Ins <- acct.load<@ResBag.Res1>(from: /storage/res1);
    destroy res1Ins;
  }

  execute {
    
  }
}