import MultiSignatureFactory from 0x01
import Example from 0x02

// This transaction is signed by another address, like 0x03
transaction{
    prepare(acct: AuthAccount) {
        acct.unlink(/public/ExaMSLink);
        acct.unlink(/public/proposalFace);

        let exaMS <- acct.load<@Example.ExaMultiSign>(from: /storage/ExaMS);
        destroy exaMS;

        let myProposal <- acct.load<@MultiSignatureFactory.R_Proposal>(from: /storage/MyProposal);
        destroy myProposal;
    }

    execute{

    }
}