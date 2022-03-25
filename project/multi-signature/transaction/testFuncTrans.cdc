import tFunType from 0x01

transaction {

  prepare(acct: AuthAccount) {}

  execute {
    let myData = tFunType.MyStr();

    let funObj: ((AnyStruct): AnyStruct) = tFunType.getPrivFunc();

    let sOpt = funObj(data: myData) as? tFunType.MyRst

    let s = sOpt!;

    log(s.name);
  }
}
