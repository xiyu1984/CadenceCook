import SubmitAuthor from 0x33a8abe2196c9e15

transaction {

  prepare(acct: AuthAccount) {
    let ctt = SubmitAuthor.eContent(oInfo: "Hello authority!");

    let sbm = acct.borrow<&SubmitAuthor.Submitter>(from: /storage/submitter);
    if let sbmRef = sbm{ 
      sbmRef.submitWithAuth(ctt, acceptorAddr: 0xd77db11694592a2b, alink: "acceptlink", oSubmitterAddr: acct.address, slink: "submitlink");
    }
  }

  execute {
    
  }
}