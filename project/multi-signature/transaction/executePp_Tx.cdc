import MultiSignatureFactory from 0x33a8abe2196c9e15
import Example from 0x33a8abe2196c9e15

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

    }
}