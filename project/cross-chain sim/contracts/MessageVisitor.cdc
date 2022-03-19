
import MessageHolder from 0x01

access(all) contract MessageVisitor {
    pub fun createMessage(){
      self.account.save(<-MessageHolder.createMessage(), to: /storage/myMessage);
      self.account.link<&{MessageHolder.BaseMsg}>(/public/messageQueue, target: /storage/myMessage);
    }

    access(account) fun addMessage(msgInfo: String){
      // let pubKey = getAccount(self.account.address);
      // let msgCap = pubKey.getCapability<&MessageHolder.Message>(/public/messageQueue);
      // msgCap.borrow()!.addMsg(inputMsg: msgInfo)

      let msgRef = self.account.borrow<&MessageHolder.Message>(from: /storage/myMessage);
      msgRef!.addMsg(inputMsg: msgInfo);
    }

    pub fun sendMessage(at: Int): String{
      return MessageHolder.sendMessage(addr: self.account.address, at: at)
    }
}
