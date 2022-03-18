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

    pub fun getMessage(addr: Address, at: Int): String{
        let pubKey = getAccount(addr);
        let msgCap = pubKey.getCapability<&Message>(/public/messageQueue);
        let msgRef = msgCap.borrow()!;

        return msgRef.msg[at]
    }
}
