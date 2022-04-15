access(all) contract ResData{
    pub struct MsgData{
        pub let s: String;
        pub let v: UInt128;

        init(oStr: String, oVal: UInt128){
            self.s = oStr;
            self.v = oVal;
        }
    }

    pub event firstValue(info: String);
    
    pub resource SimpleRes{
        pub let msgs: [MsgData];

        init(){
            self.msgs = [];
        }

        pub fun addMsg(oMsgD: MsgData){
            self.msgs.append(oMsgD);
        }

        pub fun removeMsg(){
            self.msgs.removeFirst();
        }

        pub fun getMsg(){
            emit firstValue(info: self.msgs[0].s.concat(self.msgs[0].v.toString()));
        }
        
        pub fun getMsg2(){
            emit firstValue(info: self.msgs[0].s.concat(self.msgs[0].v.toString()));
        }
    }

    pub fun createRes(): @SimpleRes{
        return <- create SimpleRes();
    }
}