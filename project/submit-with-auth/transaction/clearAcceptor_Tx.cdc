import SubmitAuthor from 0x33a8abe2196c9e15

transaction {

  prepare(acct: AuthAccount) {
    acct.unlink(/public/acceptlink);

    let acceptor <- acct.load<@SubmitAuthor.Acceptor>(from: /storage/acceptor);
    destroy acceptor;
  }

  execute {
    
  }
}