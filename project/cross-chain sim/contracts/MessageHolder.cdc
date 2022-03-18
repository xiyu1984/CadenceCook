access(all) contract MessageHolder {

    pub resource Message{
        pub let msg: [String];

        init(){
            self.msg = [];
        }

        pub fun addMsg(msgInfo: String){
            self.msg.append(msgInfo);

            if (self.msg.length > 10){
                self.msg.removeFirst();
            }
        }

        pub fun getFirstMsg(): String{
            return self.msg[0]
        }
    }

    pub fun createMessage(): @Message{
        return <- create Message()
    }

    // This mechanism can be used in cross-chain msg send
    // 
    // The first param `addr` is the sender, the message is stored by the sender in his /storage/myMessage. 
    // and the sender create a `Capability` `link` of /public/messageQueue
    // See `MessageVisitor.cdc`, `createMessage` for details
    // 
    // So when the sender will send cross-chain messages, he calls this method, input his addr, so the corss-chain contract could know who's sending messages
    // This is exactly a classic case for `resource-oriented` programming
    pub fun sendMessage(addr: Address, at: Int): String{
        let pubKey = getAccount(addr);
        let msgCap = pubKey.getCapability<&Message>(/public/messageQueue);
        let msgRef = msgCap.borrow()!;

        return msgRef.msg[at]
    }
}
