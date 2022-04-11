access(all) contract SubmitAuthor{
    priv let id: UInt128;
    // test field, add after remove
    priv let id2: UInt128;

    pub event uuidEvent(type: String, uuuuid: UInt64);

    pub init(){
        self.id = 100;
        self.id2 = 200;
    }
    
    // example of content to be submitted
    pub struct eContent{
        pub let info: String;
        pub let id: UInt128;

        pub init(oInfo: String){
            self.info = oInfo;
            self.id = 100;
        } 
    }

    // Submitter's interface
    pub resource interface SubmitterFace{
        access(contract) fun getHookedContent(): eContent;
    }

    // Submitter
    pub resource Submitter: SubmitterFace{
        priv var hookedContent: eContent?;
        // test field, add after remove
        pub let id: UInt128;

        pub init(){
            self.hookedContent = nil;
            self.id = 100;
        }

        // the `oSubmitterAddr` must be the owner of this resource, or else `Acceptor` will receive an invalid submit
        pub fun submitWithAuth(_ outContent: eContent, acceptorAddr: Address, alink: String, oSubmitterAddr: Address, slink: String){
            emit uuidEvent(type: "Submitter", uuuuid: self.uuid);
            
            // make `set` and `clear` atomic
            self.setHookedContent(outContent);

            let pubAcct = getAccount(acceptorAddr);
            let linkPath = PublicPath(identifier: alink);
            // let linkPath = /public/acceptlink;
            let acceptorLink = pubAcct.getCapability<&{SubmitAuthor.AcceptorFace}>(linkPath!);
            if let acceptorRef = acceptorLink.borrow(){
                acceptorRef.AcceptContent(submitterAddr: oSubmitterAddr, link: slink, oid: 100);
            }else{
                panic("Invalid acceptor!");
            }

            self.clearHookedContent();
        }

        // Implementation of interface `SubmitterFace`
        access(contract) fun getHookedContent(): eContent{
            return self.hookedContent!;
        }

        // private functions
        priv fun setHookedContent(_ outContent: eContent){
            self.hookedContent = outContent;
        }

        priv fun clearHookedContent(){
            self.hookedContent = nil;
        }
    }

    // Acceptor's interface
    pub resource interface AcceptorFace{
        // `oid` is the test field, add after remove
        pub fun AcceptContent(submitterAddr: Address, link: String, oid: UInt128);
    }

    pub event submitEvent(res: String);

    pub resource Acceptor: AcceptorFace{
        pub fun AcceptContent(submitterAddr: Address, link: String, oid: UInt128){

            emit uuidEvent(type: "Acceptor", uuuuid: self.uuid);

            let pubAcct = getAccount(submitterAddr);
            let linkPath = PublicPath(identifier: link);
            // let linkPath = /public/submitlink;
            let submittorLink = pubAcct.getCapability<&{SubmitterFace}>(linkPath!);

            if let submittorRef = submittorLink.borrow(){
                let rst = submittorRef.getHookedContent();
                emit submitEvent(res: submitterAddr.toString().concat(rst.info));
            }else{
                panic("Invalid submitter!");
            }
        }
    }

    pub fun createAcceptor(): @SubmitAuthor.Acceptor{
        return <- create SubmitAuthor.Acceptor();
    }

    pub fun createSubmitter(): @SubmitAuthor.Submitter{
        return <- create SubmitAuthor.Submitter();
    }
}