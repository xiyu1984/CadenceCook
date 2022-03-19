import MessageVisitor from 0x04
import MessageHolder from 0x01

transaction {

  let signer: AuthAccount;

  prepare(acct: AuthAccount) {
    self.signer = acct;
  }

  execute {
    MessageVisitor.createMessage();

    // Invalid below, because of `account access`
    // MessageVisitor.addMessage(msgInfo: "Glory!");
    
    // only account of address 0x04 is valid  
    let msgRef = self.signer.borrow<&MessageHolder.Message>(from: /storage/myMessage)
    msgRef!.addMsg(inputMsg: "Hello2 ".concat(self.signer.address.toString()))
    log(msgRef!.getFirstMsg())

    log(MessageVisitor.sendMessage(at: 2));
  }
}