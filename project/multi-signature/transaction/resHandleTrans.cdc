import tFunType from 0x01

transaction {

    let privCap: Capability<auth &AnyResource>;

  prepare(acct: AuthAccount) {
    self.privCap = acct.getCapability<auth &AnyResource>(/private/reeees);

    
  }

  execute {
    //tFunType.testReeeesFI();

    let capRef = self.privCap.borrow();
    if let resRef = capRef{
      log("has something")

      // let resFI: auth &AnyResource{tFunType.ReeeesIF}? = resRef as? auth &AnyResource{tFunType.ReeeesIF}
      let resFI: &AnyResource{tFunType.ReeeesIF}? = resRef as? auth &AnyResource{tFunType.ReeeesIF}
      log(resFI!.funcInRes())

      // invalid below because of `access(contract)`
      // log(resFI!.funcInContract())
      log(tFunType.visitCAccess(resRef:resFI!))

      // This works, although the link is just `<auth &AnyResource{ReeeesIF}>`
      // `auth` can upcast and downcast completely freely! 
      // That is, `auth` lost the "interface type control" of the access to capability
      let resFI2: &tFunType.Reeees? = resRef as? auth &tFunType.Reeees;
      log(resFI2!.funcInChild())

    }
    else{
      log("unknow")
    }
  }
}