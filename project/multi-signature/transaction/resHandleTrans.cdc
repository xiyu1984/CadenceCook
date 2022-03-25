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

      //let resFI: auth &AnyResource{tFunType.ReeeesIF}? = resRef as? auth &AnyResource{tFunType.ReeeesIF}
      let resFI: &AnyResource{tFunType.ReeeesIF}? = resRef as? auth &AnyResource{tFunType.ReeeesIF}
      log(resFI!.funcInRes())
    }
    else{
      log("unknow")
    }
  }
}