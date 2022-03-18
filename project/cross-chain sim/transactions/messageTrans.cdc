import MessageHolder from 0x01

transaction {

  let signer: AuthAccount

  prepare(acct: AuthAccount) {
    self.signer = acct;
  }

  execute {
    self.signer.save(<- MessageHolder.createMessage(), to: /storage/myMessage);
    self.signer.link<&MessageHolder.Message>(/public/messageQueue, target: /storage/myMessage);

    let pubKey = getAccount(self.signer.address);
    let msgCap = pubKey.getCapability<&MessageHolder.Message>(/public/messageQueue);
    msgCap.borrow()!.addMsg(msgInfo: "Hello world!")

    log(self.signer.address)
    log(MessageHolder.getMessage(addr: self.signer.address, at: 0))
  }
}
