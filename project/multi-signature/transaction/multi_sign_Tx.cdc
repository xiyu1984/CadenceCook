import MultiSignatureFactory from 0x01
import Example from 0x02

// This transaction is signed by another address
transaction{
    
    let myProposal: @MultiSignatureFactory.R_Proposal;

    prepare(acct: AuthAccount) {
        //acct.save(<- Example.createExaMultiSign(), to: /storage/ExaMS);
        //acct.link<&{MultiSignatureFactory.MultiSignRscEXEC}>(/public/ExaMSLink, target: /storage/ExaMS);

        self.myProposal <- MultiSignatureFactory.createR_Proposal(sign_threshole: 0);

        let execHandle = acct.getCapability<&{MultiSignatureFactory.MultiSignRscEXEC}>(/public/ExaMSLink);
        if let eh = execHandle.borrow() {
            log("valid handle!");
        }
        else{
            log("invalid handle!");
        }

        let myData = Example.MyData();
        let myPpinfo = MultiSignatureFactory.R_ProposalInfo(handle: execHandle, inputs: myData);

        self.myProposal.setExecution(resEXECinfo: myPpinfo);
    }

    execute{
        //self.myProposal.doExecute();
        let rst: Example.MyData? = self.myProposal.doExecute()! as? Example.MyData
        if (nil == rst){
            log("data failed!");
        }
        log(rst!.s);

        destroy self.myProposal;
    }
}