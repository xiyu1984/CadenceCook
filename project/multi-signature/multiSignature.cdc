access(all) contract MultiSignatureFactory{

    // **
    // Singer resource, everyone can apply a signer to sign for `MultiSignatureFactory.Proposal`
    // **
    pub resource interface SignerFace{
        pub fun isSigned(name: UInt128): Bool;
    }

    pub resource Signer: SignerFace{
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
    // Proposal resource, users can bind an **resource** operation to it
    // And execute is after multi-signed
    // **

    pub resource interface R_ProposalFace{
        pub fun sign(signer: Address);
        pub fun getName(): UInt128;
        pub fun getProposalInfo(): MultiSignatureFactory.R_ProposalInfo;
    }

    // operations need multi-sign shall implement this interface
    pub resource interface MultiSignRscEXEC{
        access(contract) fun multiSignRscEXEC(inputs: AnyStruct?): AnyStruct?;
    }

    pub struct R_ProposalInfo{
        priv var handle: Capability<&{MultiSignRscEXEC}>;
        pub var inputData: AnyStruct?;

        init(handle: Capability<&{MultiSignRscEXEC}>, inputs: AnyStruct?){
            self.handle = handle;
            self.inputData = inputs;
        }

        access(contract) fun doExecute(): AnyStruct?{
            let execRef = self.handle.borrow();
            //if (nil == execRef){
            //    return panic("invalid handle!");
            //}
            //log("in real processing!");
            //return nil
            if (nil == self.inputData){
                log("invalid data!");
            }
            return execRef!.multiSignRscEXEC(inputs: self.inputData)
        }
    }

    pub resource R_Proposal: R_ProposalFace{
        priv let name: UInt128;
        priv let t: Int;
        priv let signers: [Address];
        priv let signedAccount: [Address];

        priv var ppInfo: R_ProposalInfo?;

        // Created only by contract
        access(contract) init(threshole: Int, oName: UInt128){
            self.t = threshole;
            self.signers = [];
            self.signedAccount = [];
            self.name = oName;
            self.ppInfo = nil;
        }

        // accessed only by AuthAccount and the contract
        pub fun addSingers(signers: [Address]){
            self.signers.appendAll(signers);
        }

        pub fun setExecution(resEXECinfo: R_ProposalInfo){
            self.ppInfo = resEXECinfo;
        }

        pub fun doExecute(): AnyStruct?{
            if (self.verify()){
                return self.ppInfo!.doExecute();
            }
            else{
                return panic("Unauthorized!");
            }
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

        pub fun getProposalInfo(): MultiSignatureFactory.R_ProposalInfo{
            return self.ppInfo!;
        }
    }

    // **
    // Proposal resource, users can bind an **contract** operation to it
    // And execute is after multi-signed
    // Maybe it's unnecessary for multi-sign operations of contracts, because there's not any direct authority control for contracts
    // **
    // pub resource interface C_ProposalFace{
    //     pub fun sign(signer: Address);
    //     pub fun getName(): UInt128;
    //     pub fun getProposalInfo(): MultiSignatureFactory.C_ProposalInfo;
    // }

    // pub struct C_ProposalInfo{
    //     priv var handle: ((AnyStruct?): AnyStruct?)?;
    //     pub var inputData: AnyStruct?;

    //     init(){
    //         self.handle = nil;
    //         self.inputData = nil;
    //     }

    //     access(contract) fun setExecution(handle: ((AnyStruct?): AnyStruct?), inputs: AnyStruct?){
    //         self.handle = handle;
    //         self.inputData = inputs;
    //     }

    //     access(contract) fun doExecute(): AnyStruct?{
    //         let rst = self.handle!(self.inputData);
    //         self.clear();
    //         return rst
    //     }

    //     priv fun clear(){
    //         self.handle = nil;
    //         self.inputData = nil;
    //     }
    // }

    // pub resource C_Proposal: C_ProposalFace{
    //     priv let name: UInt128;
    //     priv let t: Int;
    //     priv let signers: [Address];
    //     priv let signedAccount: [Address];

    //     priv let ppInfo: C_ProposalInfo;

    //     // Created only by contract
    //     access(contract) init(threshole: Int, oName: UInt128){
    //         self.t = threshole;
    //         self.signers = [];
    //         self.signedAccount = [];
    //         self.name = oName;

    //         self.ppInfo = MultiSignatureFactory.C_ProposalInfo();
    //     }

    //     pub fun getProposalInfo(): MultiSignatureFactory.C_ProposalInfo{
    //         return self.ppInfo
    //     }

    //     // accessed only by AuthAccount and the contract
    //     pub fun addSingers(signers: [Address]){
    //         self.signers.appendAll(signers);
    //     }

    //     pub fun setExecution(ohandle: ((AnyStruct?): AnyStruct?), oinputs: AnyStruct?){
    //         if (self.verify()){
    //             self.ppInfo.setExecution(handle: ohandle, inputs: oinputs);
    //         }
    //         else{
    //             panic("Un authorized!");
    //         }
    //     }

    //     pub fun doExecute(): AnyStruct?{
    //         return self.ppInfo.doExecute()
    //     }

    //     priv fun verify(): Bool{
    //         if self.signedAccount.length >= self.t{
    //             return true
    //         }
    //         else{
    //             return false
    //         }
    //     }

    //     // interface of `ProposalFace`
    //     pub fun sign(signer: Address){
    //         if (!self.signers.contains(signer)){
    //             panic("Invalid signer address!");
    //         }

    //         let pubAcct = getAccount(signer);
    //         let signerLink = pubAcct.getCapability<&{SignerFace}>(/public/signerLink);
    //         if let signerRef = signerLink.borrow(){
    //             if signerRef.isSigned(name: self.name){
    //                 self.signedAccount.append(signer);
    //             }
    //         }
    //     }

    //     pub fun getName(): UInt128{
    //         return self.name
    //     }
    // }

    // *********************************************
    // Functions in `MultiSignatureFactory` contract
    // *********************************************
    priv var c_pp_id: UInt128;
    priv var r_pp_id: UInt128;

    init(){
        self.c_pp_id = 0;
        self.r_pp_id = 0;
    }

    // **
    // For `Signer`
    // **
    pub fun createSigner(): @Signer{
        return <- create Signer()
    }

    // **
    // For `C_Proposal`
    // Maybe it's unnecessary for multi-sign operations of contracts
    // **
    // pub fun createC_Porposal(sign_threshole: Int): @C_Proposal{
    //     let id = self.c_pp_id;
    //     self.c_pp_id = self.c_pp_id + 1;
    //     return <-create C_Proposal(threshole: sign_threshole, oName: id)
    // }

    // **
    // For `R_Proposal`
    // **
    pub fun createR_Proposal(sign_threshole: Int): @R_Proposal{
        let id = self.r_pp_id;
        self.r_pp_id = self.r_pp_id + 1;
        return <-create R_Proposal(threshole: sign_threshole, oName: id)
    }
}