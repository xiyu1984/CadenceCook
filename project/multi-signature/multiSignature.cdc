access(all) contract MultiSignatureFactory{

    pub resource interface SignerFace{
        pub fun isSigned(name: UInt128): Bool;
    }

    pub resource Singer: SignerFace{
        priv let proposalName: {UInt128: Bool};

        // Created only by contract
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
        pub fun getProposalInfo(): MultiSignatureFactory.ProposalInfo;
    }

    pub struct ProposalInfo{
        pub let handle: [(([AnyStruct]): [AnyStruct])];
        pub let inputData: [AnyStruct];

        init(){
            self.handle = [];
            self.inputData = [];
        }
    }

    pub resource Proposal: ProposalFace{
        priv let name: UInt128;
        priv var t: UInt;
        priv let signers: [Address];

        priv let ppInfo: ProposalInfo;

        // Created only by contract
        access(contract) init(threshole: UInt, oName: UInt128){
            self.t = threshole;
            self.signers = [];
            self.name = oName;

            self.ppInfo = MultiSignatureFactory.ProposalInfo();
        }

        // accessed only by AuthAccount and the contract
        pub fun addSingers(signers: [Address]){
            self.signers.appendAll(signers);
        }

        // interface of `ProposalFace`
        pub fun sign(signer: Address){
            if (!self.signers.contains(signer)){
                panic("Invalid signer address!");
            }

            let pubAcct = getAccount(signer);
            let signerLink = pubAcct.getCapability<&{SignerFace}>(/public/signerLink);
            if let signerRef = signerLink.borrow(){
                if signerRef.isSigned(name: self.name){
                    self.signers.append(signer);
                }
            }
        }

        pub fun getName(): UInt128{
            return self.name
        }

        pub fun getProposalInfo(): MultiSignatureFactory.ProposalInfo{
            return self.ppInfo;
        }
    }

}