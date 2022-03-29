import MultiSignatureFactory from 0x01
import Example from 0x02

// This transaction is signed by another address, like 0x03
transaction{
    prepare(acct: AuthAccount) {
        // create multi-sign operation(resource)
        acct.save(<- Example.createExaMultiSign(), to: /storage/ExaMS);
        acct.link<&{MultiSignatureFactory.MultiSignRscEXEC}>(/public/ExaMSLink, target: /storage/ExaMS);
        let execHandle = acct.getCapability<&{MultiSignatureFactory.MultiSignRscEXEC}>(/public/ExaMSLink);

        // create proposal
        let myProposal <- MultiSignatureFactory.createR_Proposal(sign_threshole: 2);
        let myData = Example.MyData();
        let myPpinfo = MultiSignatureFactory.R_ProposalInfo(handle: execHandle, inputs: myData);
        myProposal.setExecution(resEXECinfo: myPpinfo);
        myProposal.addSingers(signers: [0x01, 0x02]);

        acct.save(<-myProposal, to: /storage/MyProposal);
        acct.link<&{MultiSignatureFactory.R_ProposalFace}>(/public/proposalFace, target: /storage/MyProposal);
    }

    execute{

    }
}