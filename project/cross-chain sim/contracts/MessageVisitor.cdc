import MessageHolder from 0x01

access(all) contract HelloWorld {
    pub fun createMessage(){
      self.account.save(<-MessageHolder.createMessage(), to: /storage/myMessage);
      self.account.link<&MessageHolder.Message>(/public/messageQueue, target: /storage/myMessage);
    }

    pub fun addMessage(msgInfo: String){
      let pubKey = getAccount(self.account.address);
      let msgCap = pubKey.getCapability<&MessageHolder.Message>(/public/messageQueue);
      msgCap.borrow()!.addMsg(msgInfo: "Glorys!")
    }

    pub fun getMessage(at: Int): String{
      return MessageHolder.getMessage(addr: self.account.address, at: 0)
    }
}
