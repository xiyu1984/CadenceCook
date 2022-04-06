import MultiSignatureFactory from 0x33a8abe2196c9e15
// import Example from 0x02

transaction{
    prepare(acct: AuthAccount) {

        let pubAcct = getAccount(0xd77db11694592a2b);
        let ppLink = pubAcct.getCapability<&{MultiSignatureFactory.R_ProposalFace}>(/public/proposalFace);
        if let ppRef = ppLink.borrow() {
            let signerRef = acct.borrow<&MultiSignatureFactory.Signer>(from: /storage/mySigner);
            if (nil != signerRef){
                let pID = ppRef.getName();
                signerRef!.sign(pName: pID);
                ppRef.sign(signer: acct.address, link: "signerLink");
                // ppRef.sign(signer: acct.address);
                log("address: ".concat(acct.address.toString()).concat(" signed!"))
            }
        }
    }

    execute{
        
        
    }
}