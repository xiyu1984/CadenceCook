import MessageVisitor from 0x04

transaction {
  prepare(acct: AuthAccount) {}

  execute {
    MessageVisitor.createMessage();
    MessageVisitor.addMessage(inputMsg: "Glory!");
    log(MessageVisitor.sendMessage(at: 0));
  }
}