import InterfaceCook from 0x02

transaction {

  prepare(acct: AuthAccount) {}

  execute {
      InterfaceCook.testCerrect(lastWD: 1100)
      log(InterfaceCook.getCerrect())
  }
}