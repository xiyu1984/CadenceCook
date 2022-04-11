import SubmitAuthor from 0x33a8abe2196c9e15

transaction {

  prepare(acct: AuthAccount) {
    acct.save(<- SubmitAuthor.createAcceptor(), to: /storage/acceptor);
    acct.link<&{SubmitAuthor.AcceptorFace}>(/public/acceptlink, target: /storage/acceptor);
  }

  execute {
    
  }
}
