import MessageVisitor from 0x04
import MessageHolder from 0x01

transaction {

  let signerAddr: Address;

  prepare(acct: AuthAccount) {
    self.signerAddr = acct.address;

    // AuthAccount access in `prepare` phrase
    MessageVisitor.createMessage();

    // Invalid below, because of `account access`
    // MessageVisitor.addMessage(msgInfo: "Glory!");

    // only account of address 0x04 is valid  
    let msgRef = acct.borrow<&MessageHolder.Message>(from: /storage/myMessage)
    msgRef!.addMsg(inputMsg: "Hello ".concat(acct.address.toString()))
    log(msgRef!.getFirstMsg())
  }

  execute {
    log(MessageVisitor.sendMessage(at: 0));
  }
}