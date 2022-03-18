transaction {

  let name: String;

  prepare(acct: AuthAccount) {
    self.name = acct.address.toString();
  }

  execute {
    log(self.name);
  }
}