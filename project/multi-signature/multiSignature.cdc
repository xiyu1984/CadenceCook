access(all) contract MultiSignatureFactory{

    pub resource interface SignerFace{
        pub fun getName(): String;
        pub fun isSigned(name: String): Bool;
    }

    pub resource Singer: SignerFace{
         priv let proposalName: String;

         access(contract) init(propName: String){
             self.proposalName = propName;
         }

        pub fun getName(): String{
            return ""
        }

        pub fun isSigned(name: String): Bool{
            return true
        }
    }

    pub resource interface ProposalFace{
        pub fun sign(signer: Address);
        pub fun getName(): String;
    }

    pub resource Proposal: ProposalFace{
        priv let name: String;
        priv var t: UInt;
        priv let singers: [Address]

        access(contract) init(threshole: UInt, oName: String){
            self.t = threshole;
            self.singers = [];
            self.name = oName;
        }

        pub fun sign(signer: Address){
            let pubAcct = getAccount(signer);
            let signerLink = pubAcct.getCapability<&{SignerFace}>(/public/signerLink);
            if let signerRef = signerLink.borrow(){
                if signerRef.isSigned(name: self.name){
                    self.singers.append(signer);
                }
            }
        }

        pub fun getName(): String{
            return self.name
        }

    }

}