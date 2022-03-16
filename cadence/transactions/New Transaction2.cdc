import InterfaceCook from 0x02

transaction {

  prepare(acct: AuthAccount) {}

  execute {
      // InterfaceCook.testCerrect(lastWD: 1100)
      // log(InterfaceCook.getCerrect())
      // log(InterfaceCook.test_cross_contract())

      // execute twice will make run-time error!
      log(InterfaceCook.test_account_storage())
  }
}