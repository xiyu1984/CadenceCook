import MultiSignatureFactory from 0x01
import Example from 0x02

transaction{
    prepare(acct: AuthAccount) {

        let pubAcct = getAccount(0x03);
        let ppLink = pubAcct.getCapability<&{MultiSignatureFactory.R_ProposalFace}>(/public/proposalFace);
        if let ppRef = ppLink.borrow() {
            let signerRef = acct.borrow<&MultiSignatureFactory.Signer>(from: /storage/mySigner);
            if (nil != signerRef){
                let pID = ppRef.getName();
                signerRef!.sign(pName: pID);
                // ppRef.sign(signer: acct.address, link: "signerLink");
                ppRef.sign(signer: acct.address);
                log("address: ".concat(acct.address.toString()).concat(" signed!"))
            }
        }
    }

    execute{
        
        
    }
}