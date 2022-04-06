import MultiSignatureFactory from 0x33a8abe2196c9e15
// import Example from 0x33a8abe2196c9e15

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