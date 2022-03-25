access(all) contract MultiSignatureFactory{

    // **
    // Singer resource, everyone can apply a signer to sign for `MultiSignatureFactory.Proposal`
    // **
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

    // **
    // Proposal resource, users can bind an contract operation to it
    // And execute is after multi-signed
    // 
    // **

    pub resource interface ProposalFace{
        pub fun sign(signer: Address);
        pub fun getName(): UInt128;
        pub fun getProposalInfo(): MultiSignatureFactory.ProposalInfo;
    }

    pub struct ProposalInfo{
        pub var handle: ((AnyStruct?): AnyStruct?)?;
        pub var inputData: AnyStruct?;

        init(){
            self.handle = nil;
            self.inputData = nil;
        }

        access(contract) fun setExecution(handle: ((AnyStruct?): AnyStruct?), inputs: AnyStruct?){
            self.handle = handle;
            self.inputData = inputs;
        }

        access(contract) fun doExecute(): AnyStruct?{
            let rst = self.handle!(self.inputData);
            self.clear();
            return rst
        }

        priv fun clear(){
            self.handle = nil;
            self.inputData = nil;
        }
    }

    pub resource Proposal: ProposalFace{
        priv let name: UInt128;
        priv let t: Int;
        priv let signers: [Address];
        priv let signedAccount: [Address];

        priv let ppInfo: ProposalInfo;

        // Created only by contract
        access(contract) init(threshole: Int, oName: UInt128){
            self.t = threshole;
            self.signers = [];
            self.signedAccount = [];
            self.name = oName;

            self.ppInfo = MultiSignatureFactory.ProposalInfo();
        }

        // accessed only by AuthAccount and the contract
        pub fun addSingers(signers: [Address]){
            self.signers.appendAll(signers);
        }

        pub fun setExecution(ohandle: ((AnyStruct?): AnyStruct?), oinputs: AnyStruct?){
            if (self.verify()){
                self.ppInfo.setExecution(handle: ohandle, inputs: oinputs);
            }
            else{
                panic("Un authorized!");
            }
        }

        pub fun doExecute(): AnyStruct?{
            return self.ppInfo.doExecute()
        }

        priv fun verify(): Bool{
            if self.signedAccount.length >= self.t{
                return true
            }
            else{
                return false
            }
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
                    self.signedAccount.append(signer);
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