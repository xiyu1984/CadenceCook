import HelloWorld from 0x04

transaction {
  prepare(acct: AuthAccount) {}

  execute {
    HelloWorld.createMessage();
    HelloWorld.addMessage(inputMsg: "Glory!");
    log(HelloWorld.getMessage(at: 0));
  }
}