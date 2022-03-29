import MultiSignatureFactory from 0x01
import Example from 0x02

// This transaction is signed by another address, like 0x03
transaction{
    prepare(acct: AuthAccount) {
        let myProposalRef = acct.borrow<&MultiSignatureFactory.R_Proposal>(from: /storage/MyProposal);
        
        let rst: Example.MyData? = myProposalRef!.doExecute()! as? Example.MyData
        if (nil == rst){
            log("data failed!");
        }
        log(rst!.s);
    }

    execute{
        let pubAcct = getAccount(0x03);
        //let proposalRef = pubAcct.getCapability<&{MultiSignatureFactory.R_ProposalFace}>(/public/proposalFace)
        let exaResLink = pubAcct.getCapability<&{MultiSignatureFactory.MultiSignRscEXEC}>(/public/ExaMSLink);
        if let exaResRef = exaResLink.borrow(){
            let md = Example.MyData();
            // invalid because of `access(contract)`
            //exaResRef.multiSignRscEXEC(inputs: md);
        }
    }
}