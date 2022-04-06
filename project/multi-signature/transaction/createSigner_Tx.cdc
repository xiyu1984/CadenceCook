import MultiSignatureFactory from 0x33a8abe2196c9e15
// import Example from 0x33a8abe2196c9e15

transaction{
    prepare(acct: AuthAccount) {
        acct.save(<- MultiSignatureFactory.createSigner(), to: /storage/mySigner);
        // Be careful about the link: `/public/signerLink`, this must be consistent with the link when signing 
        acct.link<&{MultiSignatureFactory.SignerFace}>(/public/signerLink, target: /storage/mySigner);
    }

    execute{
        
        
    }
}