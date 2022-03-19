import MessageHolder from 0x01
import MessageVisitor from 0x04

transaction {

  let signer: AuthAccount

  prepare(acct: AuthAccount) {
    self.signer = acct;
  }

  execute {
    // Create `Message` to the self of the signer
    self.signer.save(<- MessageHolder.createMessage(), to: /storage/myMessage);
    // Pulished a link with `BaseMsg`, otherwise everyone can add msg to it
    self.signer.link<&{MessageHolder.BaseMsg}>(/public/messageQueue, target: /storage/myMessage);
    // Add msg to the signer's `Message` resource related to `/storage/myMessage` 
    let msgRef = self.signer.borrow<&MessageHolder.Message>(from: /storage/myMessage);
    msgRef!.addMsg(inputMsg: "Hello ".concat(self.signer.address.toString()))

    // read the msg
    let pubKey = getAccount(self.signer.address);
    let msgCap = pubKey.getCapability<&{MessageHolder.BaseMsg}>(/public/messageQueue);
    // Invalid below
    // msgCap.borrow()!.addMsg(msgInfo: "Hello world!")

    log(MessageHolder.sendMessage(addr: self.signer.address, at: 0))

    // Visit resource from 0x04, it's invalid to call `addMsg`
    let pubKey4 = getAccount(0x04);
    let msgCap4 = pubKey.getCapability<&{MessageHolder.BaseMsg}>(/public/messageQueue);
    // Invalid below
    // msgCap.borrow()!.addMsg(msgInfo: "Hello world!")

    log(MessageHolder.sendMessage(addr: 0x04, at: 0))

    // The same as above (`let pubKey4...` to `log(MessageHolder.sendMessage(`)
    log(MessageVisitor.sendMessage(at: 0))
  }
}
