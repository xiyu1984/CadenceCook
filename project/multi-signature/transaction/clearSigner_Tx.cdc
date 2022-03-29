import MultiSignatureFactory from 0x01
import Example from 0x02

// This transaction is signed by another address, like 0x03
transaction{
    prepare(acct: AuthAccount) {
        acct.unlink(/public/signerLink);

        let signer <- acct.load<@MultiSignatureFactory.Signer>(from: /storage/mySigner);
        destroy signer;

    }

    execute{

    }
}