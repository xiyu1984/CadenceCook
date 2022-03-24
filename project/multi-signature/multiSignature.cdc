access(all) contract MultiSignatureFactory{

    pub resource interface SignerFace{
        pub fun isSigned(name: UInt128): Bool;
    }

    pub resource Singer: SignerFace{
         priv let proposalName: {UInt128: Bool};

         access(contract) init(){
             self.proposalName = {};
         }

        pub fun isSigned(name: UInt128): Bool{
            if (self.proposalName.containsKey(name)){
                return self.proposalName[name]!
            }

            return false
        }

        pub fun sign(pName: UInt128){
            self.proposalName[pName] = true
        }
    }

    pub resource interface ProposalFace{
        pub fun sign(signer: Address);
        pub fun getName(): UInt128;
    }

    pub resource Proposal: ProposalFace{
        priv let name: UInt128;
        priv var t: UInt;
        priv let singers: [Address]

        access(contract) init(threshole: UInt, oName: UInt128){
            self.t = threshole;
            self.singers = [];
            self.name = oName;
        }

        pub fun addSingers(signers: [Address]){
            self.signers.appendAll(signers);
        }

        pub fun sign(signer: Address){
            if (!self.singers.containsKey(signer)){
                panic("Invalid signer address!");
            }

            let pubAcct = getAccount(signer);
            let signerLink = pubAcct.getCapability<&{SignerFace}>(/public/signerLink);
            if let signerRef = signerLink.borrow(){
                if signerRef.isSigned(name: self.name){
                    self.singers.append(signer);
                }
            }
        }

        pub fun getName(): UInt128{
            return self.name
        }
    }

}